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
    <link href="Binary/ueditor/themes/default/css/ueditor.css">
    <script src="Binary/js/jquery1.9.1.js"></script>
    <!-- 加载编辑器的容器 -->
    <script id="container" name="content" type="text/plain">
    </script>



    <style>
        .layui-form-select dl {
            z-index: 9999;  //layui下拉选被Ueditor遮挡
        }
    </style>

</head>
<body style="background-color: #f2f2f2;overflow-x:auto; overflow-y:hidden;">
<div class="layui-layout layui-layout-admin">
    <div id="content" style="margin: 0 125px 0 125px;padding: 40px;background-color: #ffffff;">
        <form class="layui-form complaintForm" >
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

                    $(function () {
                        UE.delEditor('editor');//防止第二次加载 不渲染
                        var ue = UE.getEditor('editor',{toolbars: [
                                ['undo', 'redo', 'bold', 'date', 'time','insertimage']
                            ]});
                        ue.ready(function() {
                            ue.setDisabled();//不可编辑
                        });
                    })



                </script>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn subBtn" type="button" lay-submit lay-filter="formDemo">提交</button>
                </div>
            </div>
        </form>
        <script>
            $(function () {
                layui.use('form', function(){
                    var form = layui.form;
                    form.render('select');
                });

                $(document).on('click','.subBtn',function () {
                    $.ajax('complaint/update',{
                        type:'POST',
                        data:$('.complaintForm').serialize(),  //整个表单的内容
                        dataType:'json',
                        async:false,//默认为true异步
                        success:function (data) {
                            if (data) {
                                loadPage('complaint/tolist');
                            }
                        }
                    })
                })
            })

        </script>

    </div>
</div>
</body>
</html>
