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
    <base href="<%=basePath%>">
    <title>在线下单</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
</head>
<body style="background-color: #f2f2f2;overflow-x:auto; overflow-y:hidden;height: 100%">
<div class="layui-layout layui-layout-admin">
    <div id="content" style="margin: 0 125px 0 125px;padding: 40px;background-color: #ffffff;">
        <form class="layui-form" action="ali/totoindex">
            <input type="hidden" name="orderId" value="${order.orderId}"/>
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
                    <input type="text" name="goodsWeight" value="${order.goodsWeight}" readonly autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">体积</label>
                <div class="layui-input-inline">
                    <input type="text" name="goodsVolume" value="${order.goodsVolume}" readonly autocomplete="off" class="layui-input" >
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
                    <input id="money" type="text" name="money"  value="${order.money}" readonly lay-verify="required"  class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">提交</button>
                </div>
            </div>
            <div id="match" style="display: none">
            </div>
        </form>

        <script>
            //注意：导航 依赖 element 模块，否则无法进行功能性操作
            layui.use(['element','form','laydate'], function(){
                var element = layui.element;
            })
            $(function () {
                var line;
                $("#line").click(function(){
                    var senderStation = $("#senderStation").val();
                    var receiptStation = $("#receiptStation").val();
                    //alert(senderStation+receiptStation);
                    $.ajax('line/match',{
                        type:'post', //提交方法
                        data:{'senderStation':senderStation,
                            'receiptStation':receiptStation
                        },//提交的参数
                        dataType:'json',
                        success:function (data) {
                            line = eval(data);
                            layui.use('layer',function () {
                                var layer = layui.layer;
                                layer.open({
                                    type:1,
                                    title:'匹配列车',
                                    area: ['50%', '50%'], //宽高
                                    content:$('#match'),
                                    btn:'确认',
                                    yes:function(index){  //确认按钮回调函数
                                        $('#lineMatch').attr("value",$("input[name='linematch']:checked").val());
                                        layer.close(index);
                                    },
                                    success:lineMatch(line)
                                })
                            });
                        }

                    })
                })
                function lineMatch(line) {
                    $('#match').find('div').remove();
                    for(var i = 0;i<line.length;i++){

                        $('#match').append("<div><input type='radio' name='linematch' value='"+line[i]+"'>"+line[i]+"</div>");

                    }
                    layui.use(['element','form','laydate'], function(){
                        var form = layui.form;
                        form.render();
                    })

                }
            })


        </script>

    </div>
</div>
</body>
</html>
