<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/14
  Time: 14:59
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
    <title>在线下单</title>
    <style>
        input.unit{
            padding-right: 40px;
        }
        span.unit{
            position:absolute;
            top:8px;
            right: 18px;
        }
        input.goodsWeight{
            padding-right: 40px;
        }
        span.goodsWeight{
            position:absolute;
            top:8px;
            right: 18px;
        }
        input.goodsVolume{
            padding-right: 40px;
        }
        span.goodsVolume{
            position:absolute;
            top:8px;
            right: 18px;
        }
    </style>
</head>
<body style="background-color: #f2f2f2;overflow-x:auto; overflow-y:hidden;height: 100%">
<div class="layui-layout layui-layout-admin">
    <div id="content" style="margin: 0 125px 0 125px;padding: 40px;background-color: #ffffff;">
        <form class="layui-form" >
            <input type="hidden" name="orderId" value="${order.orderId}"/>
            <input type="hidden" name="createTime" value="${order.createTime}">
            <div class="layui-form-item">
                <h2>发收货信息</h2>
                <br><br>
                <label class="layui-form-label">发货人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="senderName" value="${order.senderName}" disabled  autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">收货人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="receiptName" value="${order.receiptName}" disabled autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="senderPhone" value="${order.senderPhone}" disabled autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="receiptPhone" value="${order.receiptPhone}" disabled autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">寄货地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="senderStation" name="senderStation" value="${order.senderStation}" disabled autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">收货地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="receiptStation" name="receiptStation"  value="${order.receiptStation}" disabled autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <h2>托运货物信息</h2>
                <br><br>
                <label class="layui-form-label">货物名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="goodsName" value="${order.goodsName}" disabled autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">重量</label>
                <div class="layui-input-inline">
                    <input type="text" name="goodsWeight" value="${order.goodsWeight}" disabled autocomplete="off" class="layui-input goodsWeight" >
                    <span class="goodsWeight">t</span>
                </div>
                <label class="layui-form-label">体积</label>
                <div class="layui-input-inline">
                    <input type="text" name="goodsVolume" value="${order.goodsVolume}" disabled autocomplete="off" class="layui-input goodsVolume" >
                    <span class="goodsVolume">m³</span>
                </div>
            </div>

            <div class="layui-form-item">
                <h2>其它</h2>
                <br>
                <label class="layui-form-label">运货日期</label>
                <div class="layui-input-inline">
                    <input id="transTime" type="text" name="transTime"  value="<fmt:formatDate value='${order.transTime}' pattern='yyyy-MM-dd' />" disabled lay-verify="required"  class="layui-input" >
                </div>
                <label class="layui-form-label">运输状态</label>
                <div class="layui-input-inline">
                    <select name="status" disabled lay-verify="">
                        <option value="运输中" <c:if test="${order.status eq '运输中'}">selected</c:if> >运输中</option>
                        <option value="等待中" <c:if test="${order.status eq '等待中'}">selected</c:if> >等待中</option>
                        <option value="已完成" <c:if test="${order.status eq '已完成'}">selected</c:if> >已完成</option>
                    </select>
                </div>
                <label class="layui-form-label">领货状态</label>
                <div class="layui-input-inline">
                    <select name="getStatus" disabled lay-verify="">
                        <option value="待领货" <c:if test="${order.getStatus eq '待领货'}">selected</c:if> >待领货</option>
                        <option value="已领货" <c:if test="${order.getStatus eq '已领货'}">selected</c:if> >已领货</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">运货方案</label>
                <div class="layui-input-inline">
                    <input id="lineMatch" type="text" name="lineMatch" value="${order.lineMatch}" disabled lay-verify="required"  class="layui-input" >
                </div>

                <label class="layui-form-label">付款状态</label>
                <div class="layui-input-inline">
                    <select name="moneyStatus" disabled lay-verify="">
                        <option value="在线支付(待支付)" <c:if test="${order.getStatus eq '在线支付(待支付)'}">selected</c:if> >在线支付(待支付)</option>
                        <option value="在线支付(已支付)" <c:if test="${order.getStatus eq '在线支付(已支付)'}">selected</c:if> >在线支付(已支付)</option>
                        <option value="到付(待支付)" <c:if test="${order.getStatus eq '到付(待支付)'}">selected</c:if> >到付(待支付)</option>
                        <option value="到付(已支付)" <c:if test="${order.getStatus eq '到付(已支付)'}">selected</c:if> >到付(已支付)</option>
                    </select>
                </div>
            </div>

            <div id="match" style="display: none">
            </div>
        </form>

        <script>

            layui.use(['form'], function(){

                var form = layui.form;
                form.render();
            });

        </script>

    </div>
</div>
</body>
</html>
