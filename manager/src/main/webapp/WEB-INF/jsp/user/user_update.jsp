<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/9
  Time: 18:02
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
    <title>用户修改</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
</head>
<body>
<br>
<form class="layui-form userForm" >
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="createTime" value="<fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
    <div class="layui-form-item">
        <label class="layui-form-label">用户名：</label>
        <div class="layui-input-inline">
            <input type="text" name="userName" value="${user.userName}" required lay-verify="required" autocomplete="off" class="layui-input" >
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">密码：</label>
        <div class="layui-input-inline">
            <input type="password" name="password" value="${user.password}" required lay-verify="required" autocomplete="off" class="layui-input" >
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">联系电话：</label>
        <div class="layui-input-inline">
            <input type="text" name="telephone" value="${user.telephone}" required lay-verify="phone" autocomplete="off" class="layui-input" >
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">状态：</label>
        <div class="layui-input-inline">
            <input type="text" name="status" value="${user.status}" autocomplete="off" required lay-verify="required" class="layui-input" >
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block" hidden>
            <button class="layui-btn update" lay-submit lay-filter="*">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>

</form>
</table>
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
                //var orgName = $('#orgName').val();
                $.ajax('user/update',{
                    type:'POST',
                    data:$('.userForm').serialize(),  //整个表单的内容
                    dataType:'json',
                    async:false,//默认为true异步
                    success:function (data) {
                        console.log(data);
                        if (data) {
                            layui.use( 'layer', function () {
                                var layer = layui.layer;
                                layer.alert('修改成功', {
                                    skin: 'layui-layer-molv' //样式类名
                                    ,closeBtn: 0
                                    ,anim: 4 //动画类型
                                }, function(){
                                    var index=parent.layer.getFrameIndex(window.name); //父级子级弹窗一起关闭
                                    parent.layer.close(index);
                                    //parent.location.reload();
                                    parent.loadPage('user/tolist');
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
