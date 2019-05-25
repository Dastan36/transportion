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

            $(".cancelBtn").click(function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('cancelId');
                var status = $(this).attr('status');
                var moneyStatus = $(this).attr('moneyStatus');
                if(status == "运输中"){
                    alert("订单运输中，取消失败！");
                }else if(status == "已完成"){
                    alert("订单已完成，取消无效！");
                }else {
                    if (moneyStatus == "在线支付(已支付)"){
                        //满足撤销订单的条件之后 执行 退款 订单撤销
                        window.location.href = "ali/torefund?orderId="+id;
                    } else{
                        cancel(id);//真正删除的 逻辑
                    }
                }

            })
            $(".delBtn").click(function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('delId');
                var status = $(this).attr('status');
                var getStatus = $(this).attr('getStatus');
                //alert(getStatus);
                //alert("要取消订单的ID："+id);
                if(status == "已完成"){
                    if (getStatus == "待领货") {
                        alert("尚未领货，无法删除!");
                    }else{
                        del(id);//真正删除的 逻辑
                    }

                }else {
                    alert("订单未完成，无法删除!");
                }

            })

        function cancel(id) {

                $.ajax('order/cancel',{           //url      $.ajax(url,options)
                    type:"post",                         //提交方法
                    data:{"orderId":id},                //提交的参数
                    dataType:'json',                     //接受到信息如何处理
                    async : false,
                    success:function(data){
                        if(data && data.success){        //success 状态为4  http200
                            alert("撤销订单成功");
                        }else{
                            alert("撤销订单失败");
                        }
                    }
                })
            }

        })
        function del(id) {

            $.ajax('order/delete',{           //url      $.ajax(url,options)
                type:"post",                         //提交方法
                data:{"orderId":id},                //提交的参数
                dataType:'json',                     //接受到信息如何处理
                async : false,
                success:function(data){
                    if(data && data.success){        //success 状态为4  http200
                        alert('删除订单成功');
                        window.location.href = 'order/orderlist';
                    }else{
                        alert("删除订单失败");
                    }
                }
            })
        }
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
        <th>付款状态</th>
        <th>线路方案</th>
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
            <td>
                <c:choose>
                <c:when test="${order.moneyStatus eq '在线支付(待支付)'}">
                    <a href="order/toupdatemmonystatus?orderId=${order.orderId}" >${order.moneyStatus}</a>
                </c:when>
                <c:otherwise>
                    ${order.moneyStatus}
                </c:otherwise>
                </c:choose>
            </td>
            <td>${order.lineMatch}</td>
            <td>${order.status}</td>
            <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm cancelBtn" cancelId="${order.orderId}" status="${order.status}" moneyStatus="${order.moneyStatus}">
                        <i class="layui-icon">取消</i>
                    </button>
                    <button class="layui-btn layui-btn-sm delBtn" delId="${order.orderId}" status="${order.status}" getStatus="${order.getStatus}">
                        <i class="layui-icon">删除</i>
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
                <button class="layui-btn" onclick="window.location.href='user/userlist?pageNum=${pageNum - 1}&userName=${userName}&telephone=${telephone}'">
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
                <button class="layui-btn" onclick="window.location.href='user/userlist?pageNum=${pageNum+1}&userName=${userName}&telephone=${telephone}'">
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

