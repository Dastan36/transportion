<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/5/22
  Time: 10:03
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
</head>
<body style="background-color: #f2f2f2;overflow-x:auto; overflow-y:hidden;">
<div class="layui-layout layui-layout-admin">
    <div id="content" style="height:100%; margin: 0 125px 0 125px;padding: 40px;background-color: #ffffff;">
        <form class="layui-form" action="" enctype="multipart/form-data">

            <h2>理赔申请信息</h2>
            <hr>

            <div class="layui-form-item">
                <label class="layui-form-label">理赔方</label>
                <div class="layui-input-inline">
                    <input type="text" id="compensateName" name="compensateName" placeholder="请输入理赔方"  required lay-verify="required" autocomplete="off" class="layui-input" >
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">索赔金额</label>
                <div class="layui-input-inline">
                    <input type="text" id="compensateMoney" name="compensateMoney" placeholder="请输入索赔金额" required lay-verify="number" autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">订单号</label>
                <div class="layui-input-inline" style="width: 300px">
                    <%--自定义验证订单号--%>
                    <input type="text" name="orderId" placeholder="请输入订单号" required lay-verify="orderId"  autocomplete="off" class="layui-input orderId" >
                </div>
            </div>

            <div class="layui-form-item" hidden>
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn btnCompensate" type="button"lay-submit lay-filter="formDemo"value="123">申请</button>
                </div>
            </div>
        </form>
        <script>
            //Demo
            layui.use(['form','layer'], function(){
                var form = layui.form;
                form.render();
                var layer = layui.layer;
                var order;
                var compensate;
                //自定义验证
                form.verify({
                    orderId: function(value, item){ //value：表单的值、item：表单的DOM对象
                        if (value == null || value == undefined || value == '' ) {
                            return "订单号不能为空"
                        }else{
                            $.ajax('compensate/compensateVerifyOrderId',{//验证订单号是否可理赔
                                type:'POST',
                                data:{'orderId':value},
                                dataType:'json',
                                async:false,//默认为true异步
                                success:function (data) {
                                    order = data.order;
                                }
                            })
                            //console.log(order);
                            if (order == 'null'){
                                return "订单不存在"
                            }else{ //存在订单
                                if (order != 'true'){
                                    return "订单状态不可理赔";
                                }else{//可理赔的需要判断是否唯一 只能理赔一次
                                    $.ajax('compensate/compensateVerify',{//验证订单号是否唯一
                                        type:'POST',
                                        data:{'orderId':value},
                                        dataType:'json',
                                        async:false,//默认为true异步
                                        success:function (data) {
                                            compensate = data.compensate;
                                        }
                                    })
                                    if (compensate == 'true'){
                                        return "此订单已申请理赔，不可重复申请"
                                    }else{
                                        var compensateName = $('#compensateName').val();
                                        var compensateMoney = $('#compensateMoney').val();
                                        $.ajax('compensate/create',{
                                            type:'POST',
                                            data:{'orderId':value,'compensateName':compensateName,'compensateMoney':compensateMoney},
                                            dataType:'json',
                                            async:false,//默认为true异步
                                            success:function (data) {
                                                if (data) {

                                                    layer.open({
                                                        type: 1
                                                        ,offset: 'c'
                                                        ,content: '<div style="padding: 20px 30px;">理赔申请成功</div>'
                                                        ,btn: '确定'
                                                        ,btnAlign: 'c' //按钮居中
                                                        ,shade: 0.2 //显示遮罩率
                                                        ,yes: function(){
                                                            var index=parent.layer.getFrameIndex(window.name); //父级子级弹窗一起关闭
                                                            parent.layer.close(index);
                                                            parent.location.reload();
                                                        }
                                                    });

                                                }
                                            }
                                        })
                                    }
                                }
                                return ;
                            }
                        }
                    }
                });
            });
        </script>

    </div>
</div>
</body>
</html>
