<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/5/10
  Time: 19:44
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
    <script type="text/javascript" src="Binary/ueditor/ueditor.all.min.js"></script>

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
        <form class="layui-form" action="complaint/update" enctype="multipart/form-data">
            <input name="complaintId" hidden value="${complaint.complaint[0].complaintId}">
            <div class="layui-form-item">
                <h2>投诉人信息</h2>
                <br><br>
                <label class="layui-form-label">订单号</label>
                <div class="layui-input-inline" style="width: 300px">
                    <input type="text" name="orderId" value="${complaint.orderId}" disabled autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">投诉类型</label>
                <div class="layui-input-inline">
                    <input type="text" name="complaintType" disabled value="${complaint.complaint[0].complaintType}" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">投诉人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="complaintName" disabled value="${complaint.complaint[0].complaintName}" class="layui-input" >
                </div>
                <label class="layui-form-label">投诉人电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="complaintPhone"  disabled value="${complaint.complaint[0].complaintPhone}" autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">状态</label>
                <div class="layui-input-inline">
                    <select name="status" lay-verify="required" >
                        <option value=""></option>
                        <option value="等待中" <c:if test="${complaint.complaint[0].status eq '等待中'}">selected</c:if>>等待中</option>
                        <option value="处理中" <c:if test="${complaint.complaint[0].status eq '处理中'}">selected</c:if> >处理中</option>
                        <option value="已采纳建议" <c:if test="${complaint.complaint[0].status eq '已采纳建议'}">selected</c:if> >已采纳建议</option>
                        <option value="可理赔" <c:if test="${complaint.complaint[0].status eq '可理赔'}">selected</c:if>>可理赔</option>
                        <option value="已解决" <c:if test="${complaint.complaint[0].status eq '已解决'}">selected</c:if> >已解决</option>
                    </select>
                </div>
            </div>


            <div class="layui-form-item">
                <h2>投诉信息</h2>
                <br><br>
                <textarea name="complaintDescribe"  id="editor" disabled style="border:0;height: 250px" required class="layui-textarea">
                    ${complaint.complaint[0].complaintDescribe}
                </textarea>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">

                    var ue = UE.getEditor('editor',{toolbars: [
                            ['undo', 'redo', 'bold', 'date', 'time','insertimage']
                        ]});
                    ue.ready(function() {
                        ue.setDisabled();//不可编辑
                    });

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
                    <button class="layui-btn" lay-submit lay-filter="formDemo">提交</button>
                </div>
            </div>
        </form>
        <script>
            //Demo
            layui.use('form', function(){
                var form = layui.form;

            });
        </script>

    </div>
</div>
</body>
</html>
