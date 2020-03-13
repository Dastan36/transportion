<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/5/14
  Time: 19:08
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

    <script language="javascript" src="Binary/lodop/LodopFuncs.js"></script>


    <script>
        $(function () {

                $(document).on('click', '.confirmBtn', function () {
                    //获取当前点击删除按钮的 id
                    var id = $(this).attr('orderId');
                    //alert(id)
                    var getStatus = '已领货';
                    //window.location.href = "getstatus/updateGetStatus?orderId=" + id + "&getStatus=" + getStatus;
                    $.ajax('getstatus/updateGetStatus',{
                        type:'POST',
                        data:{'orderId':id,'getStatus':getStatus},
                        dataType:'json',
                        success:function (data) {
                            //alert(data);
                            if(data){
                                loadPage("getstatus/tolist");

                            }
                        }
                    })

                })



                $(document).on('click', '.printBtn', function () {
                    //alert("asd")
                    var id = $(this).attr('printId');
                    var orderInfo;
                    $.ajax('order/print', {           //url      $.ajax(url,options)
                        type: "post",                         //提交方法
                        data: {"orderId": id},                //提交的参数
                        dataType: 'json',                     //接受到信息如何处理
                        success: function (data) {
                            orderInfo = eval(data);
                            var LODOP = getLodop();
                            // LODOP.ADD_PRINT_HTM(10,55,"100%","100%",document.getElementById("textarea01").value);
                            LODOP.PRINT_INITA(0, 1, 486, 969, "");
                            LODOP.SET_PRINT_PAGESIZE(0, 500, 250, "");
                            LODOP.ADD_PRINT_SETUP_BKIMG("<img src='http://localhost:8080/transportion/protal/Binary/img/getGoods.png'/>");
                            //LODOP.SET_PRINT_STYLEA(0,"HtmWaitMilSecs",100);//延迟100毫秒
                            LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW", true); //预览包含背景图
                            LODOP.SET_SHOW_MODE("BKIMG_PRINT", true);//打印包含背景图
                            LODOP.ADD_PRINT_TEXT(105, 294, 300, 20, orderInfo.orderId);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(105, 268, 100, 20, orderInfo.senderName);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(130, 242, 100, 20, orderInfo.senderStation);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(329, 264, 100, 20, orderInfo.senderPhone);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(533, 264, 100, 20, orderInfo.receiptName);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(558, 235, 100, 20, orderInfo.receiptStation);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(731, 290, 200, 20, timeStamp2String(orderInfo.getTime));
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(809, 261, 100, 20, orderInfo.receiptPhone);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(131, 155, 100, 20, orderInfo.goodsName);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(319, 155, 100, 20, orderInfo.goodsWeight);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(529, 155, 100, 20, orderInfo.goodsVolume);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(647, 100, 200, 20, timeStamp2String(orderInfo.arriveTime));
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(754, 153, 200, 20, timeStamp2String(orderInfo.transTime));
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);

                            LODOP.ADD_PRINT_TEXT(319, 123, 100, 20, orderInfo.money);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);
                            LODOP.ADD_PRINT_TEXT(529, 123, 200, 20, orderInfo.moneyStatus);
                            LODOP.SET_PRINT_STYLEA(0, "Angle", -90);

                            //LODOP.PRINT();
                            LODOP.PREVIEW();
                        }
                    })


                })

                //date mate
                function timeStamp2String(time) {
                    var datetime = new Date();
                    datetime.setTime(time);
                    var year = datetime.getFullYear();
                    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
                    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
                    var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
                    var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
                    var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
                    return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
                }


        })

    </script>
    <style>
        table td {
            table-layout: fixed;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>

<form class="layui-form searchForm">

    <div class="layui-input-inline" style="width: 300px">
        <input id="searchOrderId" type="text" name="orderId" autocomplete="off"
               placeholder="订单号" class="layui-input">
    </div>

</form>
<table class="layui-table">
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
        <th>到货日期</th>
        <th>线路方案</th>
        <th>领货状态</th>
        <th>领货时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${orderList}" var="order" varStatus="status">
        <tr>
            <td>${order.orderId}</td>
            <td>${order.senderStation}</td>
            <td>${order.receiptStation}</td>
            <td><fmt:formatDate value="${order.arriveTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${order.lineMatch}</td>
            <td>${order.getStatus}</td>
            <td><fmt:formatDate value="${order.getTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm confirmBtn <c:if test="${order.getStatus eq '已领货'}">layui-btn-disabled</c:if>"
                            <c:if test="${order.getStatus eq '已领货'}">disabled</c:if> cancelId="${order.orderId}">
                        <c:choose>
                            <c:when test="${order.getStatus eq '待领货'}">
                                <i id="confirmI" class="layui-icon">确认领货</i>
                            </c:when>
                            <c:otherwise>
                                <i id="confirmI" class="layui-icon ">已领货</i>
                            </c:otherwise>
                        </c:choose>
                    </button>
                    <button class="layui-btn layui-btn-sm printBtn" printId="${order.orderId}" status="${order.status}">
                        <i class="layui-icon">电子凭证</i>
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
        page(count, defaultPage);//layui分页

        //监听表单提交
        layui.use(['form', 'layer'], function () {
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
    function page(count, defaultPage) {
        layui.use('laypage', function () {
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
    function query(page) {
        var pageCount;  //总条数

        $("table tr").each(function (index, tr) {
            if (index > 0) {
                $(tr).remove();
            }
        });
        $.ajax('getstatus/getstatuslist?pageNum=' + page, {
            type: 'post',
            cache: false,
            data: $('.searchForm').serialize(),
            dataType: 'json',
            async: false,
            success: function (data) {
                pageCount = data.pageCount;
                $(data.orderList).each(function (index, data) {
                    //console.info(data.createTime);
                    var arriveTime = getDateTime(data.arriveTime);
                    var getTime;
                    if(data.getTime == null){
                        getTime = "----";
                    }else{

                        getTime = getDateTime(data.getTime);
                    }

                    $("tbody").append(" <tr>\n" +
                        "\n" +
                        "        <td>" + data.orderId + "</td>\n" +
                        "        <td>" + data.senderStation + "</td>\n" +
                        "        <td>" + data.receiptStation + "</td>\n" +
                        "        <td>" + arriveTime + "</td>\n" +
                        "        <td>" + data.lineMatch + "</td>\n" +
                        "        <td>" + data.getStatus + "</td>\n" +
                        "        <td>" + getTime + "</td>\n" +
                        "        <td><div class=\"layui-btn-group\">\n" +
                        "                    <button id='confirmBtn"+index+"' class=\"layui-btn layui-btn-sm confirmBtn\" orderId=\"" + data.orderId + "\" value=''>确认收货\n" + "                    </button>\n" +
                        "                    <button class=\"layui-btn layui-btn-sm printBtn\" printId=\"" + data.orderId + "\" status=\"" + data.status + "\">电子凭证\n" + "                    </button>\n" +
                        "                </div></td>\n" +
                        "    </tr>");

                    if (data.getStatus == '已领货'){
                        $('#confirmBtn'+index).text("已确认");
                        $('#confirmBtn'+index).attr('disabled','');
                        $("#confirmBtn"+index).addClass("layui-btn-disabled");
                    }
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
