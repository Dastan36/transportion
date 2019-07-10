<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/5/20
  Time: 20:20
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
    <%--这是保留订单之后 再付款--%>
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
        <%--action="ali/totoindex"--%>
        <form class="layui-form payForm" >
            <input id="orderId" type="hidden" name="orderId" value="${order.orderId}"/>
            <input type="hidden" name="createTime" value="${order.createTime}">
            <div class="layui-form-item">
                <h2>发收货信息</h2>
                <br><br>
                <label class="layui-form-label">发货人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="senderName" value="${order.senderName}" readonly  autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">收货人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="receiptName" value="${order.receiptName}" readonly autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="senderPhone" value="${order.senderPhone}" readonly autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="receiptPhone" value="${order.receiptPhone}" readonly autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">寄货地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="senderStation" name="senderStation" value="${order.senderStation}" readonly autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">收货地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="receiptStation" name="receiptStation"  value="${order.receiptStation}" readonly autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <h2>托运货物信息</h2>
                <br><br>
                <label class="layui-form-label">货物名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="goodsName" value="${order.goodsName}" readonly autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">重量</label>
                <div class="layui-input-inline">
                    <input type="text" name="goodsWeight" value="${order.goodsWeight}" readonly autocomplete="off"class="layui-input goodsWeight" >
                    <span class="goodsWeight">kg</span>
                </div>
                <label class="layui-form-label">体积</label>
                <div class="layui-input-inline">
                    <input type="text" name="goodsVolume" value="${order.goodsVolume}" readonly autocomplete="off" class="layui-input goodsVolume" >
                    <span class="goodsVolume">m³</span>
                </div>
            </div>

            <div class="layui-form-item">
                <h2>其它</h2>
                <br>
                <label class="layui-form-label">运货日期</label>
                <div class="layui-input-inline">
                    <input id="transTime" type="text" name="transTime"  value="<fmt:formatDate value='${order.transTime}' pattern='yyyy-MM-dd' />" readonly lay-verify="required"  class="layui-input" >
                </div>
                <label class="layui-form-label">金额</label>
                <div class="layui-input-inline">
                    <input id="money" type="text" name="money"  value="${order.money}" readonly lay-verify="required"  class="layui-input unit" >
                    <span class="unit">元</span>
                </div>
                <label class="layui-form-label">付款状态</label>
                <div class="layui-input-inline">
                    <input id="moneyStatus" type="text" name="money"  value="${order.moneyStatus}" readonly lay-verify="required"  class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn" lay-submit lay-filter="*">提交</button>
                </div>
            </div>
            <div id="match" style="display: none">
            </div>
        </form>

        <script>
          $(function () {
              layui.use(['form'], function () {

                  //表单
                  var form = layui.form;
                  form.render();
                  form.on('submit(*)', function (data) {
                      var orderId = $('#orderId').val();
                      loadPage('ali/topay?orderId='+orderId);
                      return false;//阻止表单跳转
                  })
              })
          })



        </script>

    </div>
</div>
</body>
</html>
