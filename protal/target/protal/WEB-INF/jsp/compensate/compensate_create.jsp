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
        <form class="layui-form createForm" action="" enctype="multipart/form-data">

            <h2>理赔申请信息</h2>
            <hr>

            <div class="layui-form-item">
                <label class="layui-form-label">订单号</label>
                <div class="layui-input-inline" style="width: 300px">
                    <%--自定义验证订单号--%>
                    <input type="text" name="orderId" placeholder="请输入订单号" required lay-verify="orderId"  autocomplete="off" class="layui-input orderId" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">理赔方</label>
                <div class="layui-input-inline">
                    <input type="text" value="${user.userName}" id="compensateName" name="compensateName" placeholder="请输入理赔方"  required lay-verify="required" autocomplete="off" class="layui-input" >
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label">索赔金额</label>
                <div class="layui-input-inline">
                    <input type="text" id="compensateMoney" name="compensateMoney" placeholder="请输入索赔金额" required lay-verify="number" autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item" hidden>
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn btnCompensate" type="button"lay-submit lay-filter="*"value="123">申请</button>
                </div>
            </div>
        </form>
        <script>

            $(function () {
                layui.use(['form', 'layer'], function () {
                    var form = layui.form;
                    form.render();
                    var layer = layui.layer;
                    var order;
                    var compensate;
                    //自定义验证
                    form.verify({
                        orderId: function (value, item) { //value：表单的值、item：表单的DOM对象
                            if (value == null || value == undefined || value == '') {
                                return "订单号不能为空"
                            } else {
                                $.ajax('compensate/compensateVerifyOrderId', {//验证订单号是否可理赔
                                    type: 'POST',
                                    data: {'orderId': value},
                                    dataType: 'json',
                                    async: false,//默认为true异步
                                    success: function (data) {
                                        order = data.order;
                                    }
                                })
                                //console.log(order);
                                if (order == 'null') {
                                    return "订单不存在"
                                } else { //存在订单
                                    if (order == 'false') {
                                        return "订单状态不可理赔";
                                    } else {//可理赔的需要判断是否唯一 只能理赔一次
                                        $.ajax('compensate/compensateVerify', {//验证订单号是否唯一
                                            type: 'POST',
                                            data: {'orderId': value},
                                            dataType: 'json',
                                            async: false,//默认为true异步
                                            success: function (data) {
                                                compensate = data.compensate;
                                            }
                                        })
                                        if (compensate == 'true') {
                                            return "此订单已申请理赔，不可重复申请"
                                        }
                                    }
                                }
                            }
                        }
                    });

                    form.on('submit(*)',function (data) {
                        //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                        //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                        //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                        //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                        var orgName = $('#orgName').val();
                        $.ajax('compensate/create',{
                            type:'POST',
                            data:$('.createForm').serialize(),
                            dataType:'json',
                            async:false,//默认为true异步
                            success:function (data) {
                                //console.log(data);
                                if (data) {
                                    layui.use( 'layer', function () {
                                        var layer = layui.layer;
                                        layer.alert('添加成功', {
                                            skin: 'layui-layer-molv' //样式类名
                                            ,closeBtn: 0
                                            ,anim: 4 //动画类型
                                        }, function(){
                                            var index=parent.layer.getFrameIndex(window.name); //父级子级弹窗一起关闭
                                            parent.layer.close(index);
                                            //parent.location.reload();
                                            parent.loadPage("compensate/tolist");
                                        });
                                    })
                                }
                            }
                        })
                        return false;//阻止表单跳转
                    })


                });
            })
        </script>

    </div>
</div>
</body>
</html>
