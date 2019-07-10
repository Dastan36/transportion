<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/25
  Time: 20:11
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
            table-layout: fixed;
            white-space:nowrap;overflow:hidden;text-overflow: ellipsis;
        }

        /* 防止下拉框的下拉列表被隐藏---必须设置--- */

        .layui-form { overflow: visible; }

        /* 设置下拉框的高度与表格单元相同 */
        td .layui-form{ margin-top: -10px; margin-left: -15px; margin-right: -15px; }


    </style>
    <script>
        $(function(){
            $(document).on('click','.lay-submit',function () {
                var index = $(this).attr('index');
                var orderId = $(this).attr('orderId');
                var compensateMoney = $('#compensateMoney'+index).val();
                var compensateStatus = $('#compensateStatus'+index).val();
                //alert(compensateMoney+compensateStatus)
                $.ajax('compensate/update',{
                    type:'POST',
                    data:{'orderId':orderId,'compensateMoney':compensateMoney,'compensateStatus':compensateStatus},
                    dataType:'json',
                    success:function (data) {
                        if (data) {
                            loadPage("ali/torefundpart?orderId="+orderId+"");
                        }else {
                            loadPage('compensate/tolist');
                        }
                    }
                })
                //window.location.href="compensate/update?orderId="+orderId+"&compensateMoney="+compensateMoney+"&compensateStatus="+compensateStatus+"";

            })
        })
    </script>

</head>
<body style="height: 100%">
<form class="layui-form searchForm" >

    <div class="layui-input-inline" style="width: 300px">
        <input id="searchOrderId" type="text" name="orderId" autocomplete="off"
               placeholder="订单号" class="layui-input">
    </div>

    <div class="layui-input-inline " style="width: 200px">
        <i style="color: #c2c2c2">一旦确认理赔,理赔状态不可恢复</i>
    </div>
</form>
<table class="layui-table" >
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>序号</th>
        <th>订单号</th>
        <th>理赔方</th>
        <th>索赔金额</th>
        <th>理赔状态</th>
        <th>理赔时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${compensateList}" var="order" varStatus="status">
        <form method="post" action="compensate/update">
        <tr >
        <c:forEach items="${order.compensate}" var="compensate" varStatus="compensateStatus">
            <c:if test="${compensateStatus.index gt 0}">
                <tr>
            </c:if>
            <c:if test="${compensateStatus.index eq 0}">
                <td rowspan="${order.compensate.size()}">${status.count}</td>
                <td rowspan="${order.compensate.size()}" >${order.orderId}</td>
                <input type="text" name="orderId" value="${order.orderId}" hidden>
            </c:if>
            <td>${compensate.compensateName}</td>

            <td>
                <input  lay-verify="number" type="text" name="compensateMoney" class="layui-input compensateMoney"
                 <c:if test="${compensate.compensateStatus eq '已理赔'}">disabled</c:if> value="${compensate.compensateMoney}"
                >
            </td>
            <td class="layui-form">
                <select name="compensateStatus" class="compensateStatus" name="status" lay-verify="required"
                        <c:if test="${compensate.compensateStatus eq '已理赔'}">disabled</c:if>
                >
                    <option value=""></option>
                    <option value="处理中" <c:if test="${compensate.compensateStatus eq '处理中'}">selected</c:if> >处理中</option>
                    <option value="已理赔" <c:if test="${compensate.compensateStatus eq '已理赔'}">selected</c:if>>已理赔</option>
                </select>
            </td>
            <td><fmt:formatDate value="${compensate.compensateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <%--class 中的是控制禁用样式  另一个是控制点击禁用事件--%>
                    <button class="layui-btn sub <c:if test="${compensate.compensateStatus eq '已理赔'}">layui-btn-disabled</c:if>" lay-submit lay-filter="formDemo" <c:if test="${compensate.compensateStatus eq '已理赔'}"> disabled </c:if>>确认理赔</button>
                </div>
            </td>
            <c:if test="${complaintStatus.index gt 0}">
                </tr>
            </c:if>
        </c:forEach>
        </tr>
        </form>
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

        //监听表单提交  搜索表单
        layui.use(['form', 'layer'], function () {
            var form = layui.form;
            form.render('select');
            form.on('submit(*)',function (data) {
                //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                //alert(count)
                count = query(1);//根据搜索内容  查出新的数据条数  在分页
                page(count,defaultPage);//layui分页
                form.render(); //这里需要再次渲染一次 按条件查时下拉框渲染
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
                jump:function(obj,first) {//回调该展示数据的方法,数据展示
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
        $.ajax('compensate/compensatelist?pageNum='+page,{
            type:'post',
            cache:false,
            data:$('.searchForm').serialize(),
            dataType:'json',
            async: false,
            success:function(data){
                pageCount =  data.pageCount;
                $(data.compensateList).each(function(index,data){

                    //$('tbody').append("<tr id=\"side"+index+"\"></tr>");
                    //alert($('tbody').html());
                    $(data.compensate).each(function(index1,data1){
                        var compensateTime = getDateTime(data1.compensateTime);

                        //理赔只能申请一次
                        if(index1 == 0){

                            $('tbody').append("<tr>" +
                                "<td rowspan=\""+data.compensate.length+"\">"+(index+1)+"</td>" +
                                "<td rowspan=\""+data.compensate.length+"\">"+data.orderId+"</td>" +
                                "<input type=\"text\" name=\"orderId\" value=\""+data.orderId+"\" hidden>" +
                                "<td>"+data1.compensateName+"</td>\n" +
                                "<td><input lay-verify=\"number\" type=\"text\" id='compensateMoney"+index+"' class=\"layui-input\"\n" +
                                "                 value=\""+data1.compensateMoney+"\">\n" +
                                "</td>\n" +
                                "<td class=\"layui-form\">\n" +
                                "      <select name=\"compensateStatus\" class='layui-form compensateStatus' id='compensateStatus"+index+"' name=\"status\" lay-verify=\"required\">\n" +
                                "          <option value=\"\"></option>\n" +
                                "          <option id=\"one"+index+"\" value=\"处理中\" >处理中</option>\n" +
                                "          <option id=\"two"+index+"\" value=\"已理赔\" >已理赔</option>\n" +
                                "      </select>\n" +
                                "</td>\n" +
                                "<td>"+compensateTime+"</td>\n" +
                                "            <td><div class=\"layui-btn-group\">\n" +
                                "                    <button class=\"layui-btn sub lay-submit\" type='button' id='submit"+index+"' " +
                                "                     orderId=\""+data.orderId+"\" index=\""+index+"\" >确认理赔</button>\n" +
                                "                </div></td>" +
                                "</tr>");
                            if (data1.compensateStatus == $('#one'+index).val()){
                                $('#one'+index).attr("selected","");
                            }
                            if (data1.compensateStatus == $('#two'+index).val()){
                                $('#two'+index).attr("selected","");
                            }
                            if (data1.compensateStatus == $('#two'+index).val()){//已理赔
                                $('#submit'+index).text("已确认");
                                $('#submit'+index).attr('disabled','');
                                $('#submit'+index).addClass("layui-btn-disabled");
                                $('#compensateMoney'+index).attr('disabled','');
                                $('#compensateStatus'+index).attr('disabled','');
                            }
                        }
                    });

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
