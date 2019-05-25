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

        /* 防止下拉框的下拉列表被隐藏---必须设置--- */

        .layui-form { overflow: visible; }

        /* 设置下拉框的高度与表格单元相同 */
        td .layui-form{ margin-top: -10px; margin-left: -15px; margin-right: -15px; }


    </style>
</head>
<body style="height: 100%">
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
    <script >
        layui.use(['form','table'], function(){
            var form = layui.form;
            form.reader();
            var table = layui.table;
            table.reader();
        });
    </script>
</table>
<div align="center">
    <c:if test="${compensateList.size()>0}">
        <c:choose>
            <c:when test="${pageNum == 1}">
                <button class="layui-btn">
                    上一页
                </button>
            </c:when>
            <c:otherwise>
                <button class="layui-btn" onclick="window.location.href='compensate/compensatelist?pageNum=${pageNum - 1}&orderId=${orderId}'">
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
                <button class="layui-btn" onclick="window.location.href='compensate/compensatelist?pageNum=${pageNum+1}&orderId=${orderId}'">
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
