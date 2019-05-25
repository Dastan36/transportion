<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/28
  Time: 21:49
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
    <!-- 加载编辑器的容器 -->
    <script id="container" name="content" type="text/plain">
    </script>
    <!-- 配置文件 -->
    <script type="text/javascript" src="Binary/ueditor/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="Binary/ueditor/ueditor.all.js"></script>

    <script type="text/javascript" charset="utf-8" src="Binary/ueditor/lang/zh-cn/zh-cn.js"></script>


    <style>
        .layui-form-select dl {
            z-index: 9999;  //layui下拉选被Ueditor遮挡
        }
    </style>

</head>
<body style="background-color: #f2f2f2;overflow-x:auto; overflow-y:hidden;">
<div class="layui-layout layui-layout-admin">
    <div id="content" style="margin: 0 125px 0 125px;padding: 40px;background-color: #ffffff;">
        <form class="layui-form" action="complaint/add" enctype="multipart/form-data">
            <div class="layui-form-item">
                <h2>投诉人信息</h2>
                <br><br>
                <label class="layui-form-label">订单号</label>
                <div class="layui-input-inline" style="width: 300px">
                    <%--自定义验证订单号--%>
                    <input type="text" name="orderId" placeholder="请输入订单号" required lay-verify="orderId"  autocomplete="off" class="layui-input orderId" >
                </div>
                <label class="layui-form-label">投诉类型</label>
                <div class="layui-input-inline">
                    <select name="complaintType" lay-verify="required" >
                        <option value=""></option>
                        <option value="时间延误">时间延误</option>
                        <option value="货物丢失">货物丢失</option>
                        <option value="货物破损短少">货物破损短少</option>
                        <option value="服务态度">服务态度</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">投诉人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="complaintName" placeholder="请输入投诉人姓名"  autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">投诉人电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="complaintPhone" placeholder="请输入投诉人电话" required  lay-verify="phone" autocomplete="off" class="layui-input" >
                </div>
            </div>


            <div class="layui-form-item">
                <h2>投诉信息</h2>
                <br><br>
                <textarea name="complaintDescribe"  id="editor" style="border:0;height: 250px" required class="layui-textarea"></textarea>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">

                    var ue = UE.getEditor('editor',{toolbars: [
                            ['undo', 'redo', 'bold', 'date', 'time','insertimage']
                        ]});

                    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
                    UE.Editor.prototype.getActionUrl = function(action){
                        console.log("action:"+action);
                        if (action == 'uploadimage') {

                            return "/transportion/protal/upload/images";

                        } else {

                            return this._bkGetActionUrl.call(this, action);

                        }

                    }

                </script>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">投诉</button>
                </div>
            </div>
        </form>
        <script>
            //Demo
            layui.use('form', function(){
                var form = layui.form;
                form.render();
                var order;
                //自定义验证
                form.verify({
                    orderId: function(value, item){ //value：表单的值、item：表单的DOM对象
                        if (value == null || value == undefined || value == '' ) {
                            return "订单号不能为空"
                        }else{
                            $.ajax('complaint/complaintVerifyOrderId',{//验证订单号的有效性
                                type:'POST',
                                data:{'orderId':value},
                                dataType:'json',
                                async:false,//默认为true异步
                                success:function (data) {
                                    order = eval(data.order);
                                }
                            })
                            if (order == null){
                                return "订单不存在"
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
