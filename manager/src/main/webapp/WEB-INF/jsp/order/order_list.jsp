<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/4/8 0008
  Time: 下午 2:40
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>我的订单</title>

    <style>
        table td{
            overflow:auto;
            white-space:nowrap;overflow:hidden;text-overflow: ellipsis;
        }

    </style>
</head>
<body>
<form class="layui-form searchForm" >

    <div class="layui-input-inline" style="width: 300px">
        <input id="searchOrderId" type="text" name="orderId" autocomplete="off"
               placeholder="订单号" class="layui-input">
    </div>

</form>
<table class="layui-table"  >
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>单号</th>
        <th>出发站</th>
        <th>到达站</th>
        <th>线路方案</th>
        <th>付款状态</th>
        <th>运输状态</th>
        <th>下单时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${orderList}" var="order" varStatus="status">
        <tr>
            <td>${order.orderId}</td>
            <td>${order.senderName}</td>
            <td>${order.senderStation}</td>
            <td>${order.receiptName}</td>
            <td>${order.receiptStation}</td>
            <td><fmt:formatDate value="${order.transTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${order.lineMatch}</td>
            <td>${order.moneyStatus}</td>
            <td>${order.status}</td>
            <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm" onclick="loadPage('order/toupdate?orderId=${order.orderId}')">
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                </div>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div id="page" align="center"></div>
<script>
    var defaultPage;
    var count;
    $(function () {
        defaultPage = 1;
        count = query(defaultPage);//查出数据
        page(count,defaultPage);//layui分页

        //监听表单提交
        layui.use(['form'], function () {
            var form = layui.form;
            form.render();
            form.on('submit(*)', function (data) {
                //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                //alert(count)
                count = query(1);//根据搜索内容  查出新的数据条数  在分页
                page(count, defaultPage);//layui分页
                return false;//阻止表单跳转

            })
        })
        $(document).on('input','#searchOrderId',function () {
            count = query(1);//根据搜索内容  查出新的数据条数  在分页
            page(count,defaultPage);//layui分页
        })

    })

    //layui 的 分页
    function page(count,defaultPage) {
        layui.use('laypage', function() {
            //alert("laypage"+pageCount)
            var laypage = layui.laypage;
            laypage.render({
                elem: 'page',
                count: count, //总条数
                limit: 9,//每页条数  和后台控制条数的数据一样 为了简便一些没有用传参的方式
                layout: ['prev', 'page', 'next', 'skip'],
                curr: defaultPage,  //当前页码
                theme: '#00A0E9',
                jump: function (obj, first) {//回调该展示数据的方法,数据展示
                    if (!first) {
                        //第一次不执行,一定要记住,这个必须有,要不然就是死循环

                        //console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                        //console.log(obj.limit); //得到每页显示的条数

                        // 更改存储变量容器中的数据,是之随之更新数据
                        defaultPage = obj.curr;
                        count = query(defaultPage);
                    }
                }
            })
        })
    }

    //
    function query(page){
        var pageCount;  //总条数

        $("table tr").each(function(index,tr){
            if(index>0){
                $(tr).remove();
            }
        });
        $.ajax('order/orderlist?pageNum='+page,{
            type:'post',
            cache:false,
            data:$('.searchForm').serialize(),
            dataType:'json',
            async: false,
            success:function(data){
                pageCount =  data.pageCount;
                $(data.orderList).each(function(index,data){
                    //console.info(data.createTime);
                    var transTime = getDateTime(data.transTime);
                    var createTime = getDateTime(data.createTime);

                    $("tbody").append(" <tr>\n" +
                        "\n" +
                        "        <td>"+data.orderId+"</td>\n" +
                        "        <td>"+data.senderStation+"</td>\n" +
                        "        <td>"+data.receiptStation+"</td>\n" +
                        "        <td>"+data.lineMatch+"</td>\n" +
                        "        <td>"+data.moneyStatus+"</td>\n" +
                        "        <td>"+data.status+"</td>\n" +
                        "        <td>"+createTime+"</td>\n" +
                        "        <td><div class=\"layui-btn-group\">\n" +
                        "                    <button class=\"layui-btn layui-btn-sm\" onclick=\"loadPage('order/toupdate?orderId="+data.orderId+"')\">\n" +
                        "                        <i class=\"layui-icon\">&#xe642;</i>\n" +
                        "                    </button>\n" +
                        "                </div></td>\n" +
                        "    </tr>")
                });
            }
        });
        return pageCount;
    }

    /* ajax日期时间格式转换*/

    function getDateTime(date) {
        var date = new Date(parseInt(date, 10));

        var year = date.getFullYear();

        var month = date.getMonth() + 1;

        var day = date.getDate();

        var hh = date.getHours();

        var mm = date.getMinutes();

        var ss = date.getSeconds();

        return year + "-" + month + "-" + day + " " + hh + ":" + mm + ":" + ss;
    }

</script>
</body>
</html>

