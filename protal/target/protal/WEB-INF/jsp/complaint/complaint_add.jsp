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

    <style>
        .layui-form-select dl {
            z-index: 9999;
         /*layui下拉选被Ueditor遮挡*/
        }
    </style>

</head>
<body style="background-color: #f2f2f2;overflow-x:auto; overflow-y:hidden;">
<div class="layui-layout layui-layout-admin">
    <div id="content" style="margin: 0 125px 0 125px;padding: 40px;background-color: #ffffff;">
        <%--action="complaint/add"--%>
        <form class="layui-form complaintForm" >
            <div class="layui-form-item">
                <h2>投诉人信息</h2>
                <br><br>
                <label class="layui-form-label">订单号</label>
                <div class="layui-input-inline" style="width: 300px">
                    <%--自定义验证订单号--%>
                    <input type="text" name="orderId" placeholder="请输入订单号"  lay-verify="orderId" lay-verType="msg"
                           autocomplete="off" class="layui-input orderId">
                </div>
                <label class="layui-form-label">投诉类型</label>
                <div class="layui-input-inline">
                    <select name="complaintType" lay-verify="required">
                        <option value=""></option>
                        <option value="时间延误">时间延误</option>
                        <option value="货物丢失">货物丢失</option>
                        <option value="发货速度慢">发货速度慢</option>
                        <option value="货物破损短少">货物破损短少</option>
                        <option value="服务态度">服务态度</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">投诉人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="complaintName" value="${user.userName}" readonly placeholder="请输入投诉人姓名" autocomplete="off"  lay-verify="required" lay-verType="msg"
                           class="layui-input">
                </div>
                <label class="layui-form-label">投诉人电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="complaintPhone" value="${user.telephone}" readonly placeholder="请输入投诉人电话"  lay-verify="phone" lay-verType="msg"
                           autocomplete="off" class="layui-input">
                </div>
            </div>


            <div class="layui-form-item">
                <h2>投诉信息</h2>
                <br><br>
                <textarea name="complaintDescribe" id="editor" style="border:0;height: 250px" lay-verify="required" lay-verType="msg"
                          class="layui-textarea"></textarea>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">

                    UE.delEditor('editor');//防止第二次加载 不渲染
                    var ue = UE.getEditor('editor', {
                        toolbars: [
                            [ 'undo', 'redo', 'bold', 'date', 'time', 'insertimage']
                        ]
                    });
                    //这里Ueditor  geturl ajax加载页面后变成全局的  和iframe不同
                    // UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
                    UE.getActionUrl = function (action) {
                        // console.log("action:" + action);
                        if (action == 'uploadimage') {

                            return "/transportion/protal/upload/images";

                        } else {
                            console.info("other action  "+action)
                            return this._bkGetActionUrl.call(this, action);

                        }

                    }

                </script>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn" lay-submit lay-filter="1">投诉</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    $(function () {
        //alert("asd");
        layui.use(['form'], function () {
            var form = layui.form;
            form.render();
            var order;
            //自定义验证
            form.verify({
                orderId: function (value, item) { //value：表单的值、item：表单的DOM对象
                    if (value == null || value == undefined || value == '') {
                        return "订单号不能为空"
                    } else {
                        $.ajax('complaint/complaintVerifyOrderId', {//验证订单号的有效性
                            type: 'POST',
                            data: {'orderId': value},
                            dataType: 'json',
                            async: false,//默认为true异步
                            success: function (data) {
                                order = eval(data.order);
                            }
                        })
                        if (order == null) {
                            return "订单不存在";
                        }
                    }
                }
            });
            form.on('submit(1)', function (data) {
                //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                $.ajax('complaint/add', {
                    type:'POST',
                    data:$('.complaintForm').serialize(),
                    dataType:'json',
                    async:false,//默认为true异步
                    success:function (data) {
                        //alert(data);
                        if (data) {
                            loadPage('complaint/tolist');
                        }
                    }
                })
                return false;//阻止表单跳转

            });

        });

    })
</script>
</body>
</html>
