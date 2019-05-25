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
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
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
        <th>寄件人</th>
        <th>出发站</th>
        <th>收件人</th>
        <th>到达站</th>
        <th>运货日期</th>
        <th>线路方案</th>
        <th>付款状态</th>
        <th>运输状态</th>
        <th>创建时间</th>
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
                    <button class="layui-btn layui-btn-sm" onclick="window.location.href='order/toupdate?orderId=${order.orderId}'">
                        <i class="layui-icon">&#xe642;</i>
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
                <button class="layui-btn" onclick="window.location.href='order/orderlist?pageNum=${pageNum - 1}&orderId=${orderId}'">
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
                <button class="layui-btn" onclick="window.location.href='order/orderlist?pageNum=${pageNum+1}&orderId=${orderId}'">
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

