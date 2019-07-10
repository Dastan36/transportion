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
            </div>


            <div class="layui-form-item">
                <h2>投诉信息</h2>
                <br><br>
                <textarea name="complaintDescribe"  id="editor" disabled style="border:0;height: 250px" required class="layui-textarea">
                    ${complaint.complaint[0].complaintDescribe}
                </textarea>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">
                    UE.delEditor('editor');//防止第二次加载 不渲染
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
