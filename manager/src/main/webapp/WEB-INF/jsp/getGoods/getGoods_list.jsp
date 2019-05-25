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
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
    <script language="javascript" src="Binary/lodop/LodopFuncs.js"></script>


    <script>
        $(function () {


            //跳转页面
            $("#toPageBtn").click(function(){

                //跳转到xxx页

                var pageNum = parseInt($("#pageNumInp").val());
                if(pageNum<=0 || pageNum> ${pageCount}){
                    alert("没有"+pageNum+"页");
                    return;
                }
                window.location.href = "order/orderlist?pageNum="+pageNum;
            });

            $(".confirmBtn").click(function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('cancelId');
                var getStatus = '已领货';
                window.location.href = "getstatus/updateGetStatus?orderId="+id+"&getStatus="+getStatus;

            })

            $(".printBtn").click(function(){
                var id = $(this).attr('printId');
                var orderInfo;
                $.ajax('order/print',{           //url      $.ajax(url,options)
                    type:"post",                         //提交方法
                    data:{"orderId":id},                //提交的参数
                    dataType:'json',                     //接受到信息如何处理
                    success:function(data){
                        orderInfo = eval(data);
                        var LODOP=getLodop();
                        // LODOP.ADD_PRINT_HTM(10,55,"100%","100%",document.getElementById("textarea01").value);
                        LODOP.PRINT_INITA(0,1,486,969,"");
                        LODOP.SET_PRINT_PAGESIZE(0,500,250,"");
                        LODOP.ADD_PRINT_SETUP_BKIMG("<img src='http://localhost:8080/transportion/protal/Binary/img/getGoods.png'/>");
                        //LODOP.SET_PRINT_STYLEA(0,"HtmWaitMilSecs",100);//延迟100毫秒
                        LODOP.SET_SHOW_MODE("BKIMG_IN_PREVIEW",true); //预览包含背景图
                        LODOP.SET_SHOW_MODE("BKIMG_PRINT",true);//打印包含背景图
                        LODOP.ADD_PRINT_TEXT(105,294,300,20,orderInfo.orderId);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(105,268,100,20,orderInfo.senderName);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(130,242,100,20,orderInfo.senderStation);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(329,264,100,20,orderInfo.senderPhone);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(533,264,100,20,orderInfo.receiptName);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(558,235,100,20,orderInfo.receiptStation);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(731,290,200,20,timeStamp2String(orderInfo.getTime));
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(809,261,100,20,orderInfo.receiptPhone);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(131,155,100,20,orderInfo.goodsName);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(319,155,100,20,orderInfo.goodsWeight);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(529,153,100,20,orderInfo.goodsVolume);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(647,100,200,20,timeStamp2String(orderInfo.arriveTime));
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);
                        LODOP.ADD_PRINT_TEXT(754,153,200,20,timeStamp2String(orderInfo.transTime));
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);

                        LODOP.ADD_PRINT_TEXT(798,123,100,20,orderInfo.money);
                        LODOP.SET_PRINT_STYLEA(0,"Angle",-90);

                        //LODOP.PRINT();
                        LODOP.PREVIEW();
                    }
                })


            })

            //date mate
            function timeStamp2String(time){
                var datetime = new Date();
                datetime.setTime(time);
                var year = datetime.getFullYear();
                var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
                var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
                var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();
                var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
                var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
                return year + "-" + month + "-" + date+" "+hour+":"+minute+":"+second;
            }

        })

    </script>
    <style>
        table td{
            table-layout: fixed;
            white-space:nowrap;overflow:hidden;text-overflow: ellipsis;
        }
    </style>
</head>
<body>

<form class="layui-form" action="order/orderlist">

    <div class="layui-input-inline" style="width: 300px">
        <input type="text" name="orderId" autocomplete="off"
               placeholder="订单号" class="layui-input">
    </div>
    <div class="layui-input-inline " style="width: 200px">
        <button class="layui-btn" type="submit" data-type="reload">
            <i class="layui-icon" style="font-size: 20px; ">&#xe615;</i> 搜索
        </button>
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
                    <button class="layui-btn layui-btn-sm confirmBtn <c:if test="${order.getStatus eq '已领货'}">layui-btn-disabled</c:if>" <c:if test="${order.getStatus eq '已领货'}">disabled</c:if> cancelId="${order.orderId}">
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
<div align="center">
    <c:if test="${orderList.size()>0}">
        <c:choose>
            <c:when test="${pageNum == 1}">
                <button class="layui-btn">
                    上一页
                </button>
            </c:when>
            <c:otherwise>
                <button class="layui-btn" onclick="window.location.href='getstatus/getstatuslist?pageNum=${pageNum - 1}&userName=${userName}&telephone=${telephone}'">
                    上一页
                </button>
            </c:otherwise>
        </c:choose>
        &nbsp;
        <c:choose>
            <c:when test="${pageNum  == pageCount}">
                <button class="layui-btn">
                    下一页
                </button>
            </c:when>
            <c:otherwise>
                <button class="layui-btn" onclick="window.location.href='getstatus/getstatuslist?pageNum=${pageNum+1}&userName=${userName}&telephone=${telephone}'">
                    下一页
                </button>
            </c:otherwise>
        </c:choose>
    </c:if>
    &nbsp;&nbsp;
    当前第${pageNum}页,共${pageCount}页
    &nbsp;
    跳转到<input type="text" size="3" id="pageNumInp" value="${pageNum}">
    <button id="toPageBtn" class="layui-btn" >跳转</button>
</div>
</body>
</html>
