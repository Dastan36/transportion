<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/16
  Time: 10:14
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
    <title>快运班列添加</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
</head>
<body style="height: 100%">
<br>
<form class="layui-form trainForm" action="train/savetrain">
    <div class="layui-form-item">
        <label class="layui-form-label">快运班列：</label>
        <div class="layui-input-inline">
            <input type="text" name="traName" placeholder="请输入" autocomplete="off" required lay-verify="required" class="layui-input" >
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">所属机构：</label>
        <div class="layui-input-inline">
            <select name="orgId" required lay-verify="required" lay-search>
                <option value="">请选择所属机构</option>
                <c:forEach items="${orgList}" var="org" varStatus="status">
                    <option value="${org.orgId}" name="orgId">${org.orgName}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block" hidden>
            <button class="layui-btn createBtn" lay-submit lay-filter="*">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>

</form>
<script>
    $(function () {
        layui.use(['form', 'layer'], function () {
            var form = layui.form;
            form.render();
            form.on('submit(*)',function (data) {
                //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。

                $.ajax('train/savetrain',{
                    type:'POST',
                    data:$('.trainForm').serialize(),  //整个表单的内容
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
                                    parent.loadPage('train/tolist');
                                });
                            })
                        }
                    }
                })
                return false;//阻止表单跳转
            })
        })

    })
</script>

</body>
</html>
