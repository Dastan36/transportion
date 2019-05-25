<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/27
  Time: 12:58
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
                window.location.href = "complaint/complaintlist?pageNum="+pageNum;
            });

            $(".cancelBtn").click(function(){
                //获取当前点击取消按钮的 id     判断订单
                var id = $(this).attr('cancelId');
                var status = $(this).attr('status');

                    cancel(id);//真正删除的 逻辑

            })


            function cancel(id) {

                $.ajax('complaint/cancel',{           //url      $.ajax(url,options)
                    type:"post",                         //提交方法
                    data:{"complaintId":id},                //提交的参数
                    dataType:'json',                     //接受到信息如何处理
                    success:function(data){
                        if(data && data.success){        //success 状态为4  http200
                            alert('撤销投诉成功');
                            window.location.href = 'complaint/complaintlist';
                        }else{
                            alert("撤销投诉失败");
                        }
                    }
                })
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
<form class="layui-form" action="complaint/complaintlist">

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
        <th>序号</th>
        <th>订单号</th>
        <th>投诉类型</th>
        <th>投诉人姓名</th>
        <th>投诉人电话</th>
        <th>状态</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${complaintList}" var="order" varStatus="status">
        <tr >
        <c:forEach items="${order.complaint}" var="complaint" varStatus="complaintStatus">
            <c:if test="${complaintStatus.index gt 0}">
                <tr>
            </c:if>
            <c:if test="${complaintStatus.index eq 0}">
                <td rowspan="${order.complaint.size()}">${status.count}</td>
                <td rowspan="${order.complaint.size()}">${order.orderId}</td>
            </c:if>
            <td>${complaint.complaintType}</td>
            <td>${complaint.complaintName}</td>
            <td>${complaint.complaintPhone}</td>
            <td>${complaint.status}</td>
            <td><fmt:formatDate value="${complaint.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm cancelBtn" cancelId="${complaint.complaintId}" status="${complaint.status}">
                        <i class="layui-icon">&#xe640;</i>
                    </button>
                    <button class="layui-btn layui-btn-sm " onclick="window.location.href='complaint/todetails?complaintId=${complaint.complaintId}'">
                        <i class="layui-icon">&#xe702;</i>
                    </button>
                </div>
            </td>
            <c:if test="${complaintStatus.index gt 0}">
                </tr>
            </c:if>
        </c:forEach>
        </tr>

    </c:forEach>
    </tbody>
</table>
<div align="center">
    <c:if test="${complaintList.size()>0}">
        <c:choose>
            <c:when test="${pageNum == 1}">
                <button class="layui-btn">
                    上一页
                </button>
            </c:when>
            <c:otherwise>
                <button class="layui-btn" onclick="window.location.href='complaint/complaintlist?pageNum=${pageNum - 1}&userId=${userId}&orderId=${orderId}'">
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
                <button class="layui-btn" onclick="window.location.href='complaint/complaintlist?pageNum=${pageNum+1}&userId=${userId}&orderId=${orderId}'">
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
