<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/5/12
  Time: 19:41
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
    <title>用户信息</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/js/jquery1.9.1.js"></script>
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
</head>
<body>
<form class="layui-form userForm">
    <h2>修改密码</h2>
    <br><br>
    <input type="hidden" name="userId" value="${userId}">
    <input type="hidden" name="createTime"
           value="<fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
    <div class="layui-form-item">
        <label class="layui-form-label">旧密码：</label>
        <div class="layui-input-inline">
            <input id="oldPassword" type="password" name="oldPassword" required lay-verify="oldPassword" lay-verType="tips" autocomplete="off"
                   placeholder="请输入旧密码" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">新密码：</label>
        <div class="layui-input-inline">
            <input id="newPassword" type="password" name="newPassword" required lay-verify="newPassword" lay-verType="tips" autocomplete="off"
                   placeholder="请输入新密码" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">确认密码：</label>
        <div class="layui-input-inline">
            <input type="password" name="reqPassword" required lay-verify="reqPassword" lay-verType="tips" autocomplete="off"
                   placeholder="请确认密码" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">验证码</label>
        <div class="layui-input-inline">
            <input type="text" id="validatecode" name="validatecode" required lay-verify="validatecode"
                   lay-verType="tips" placeholder="请输入验证码" autocomplete="off" class="layui-input">
        </div>
        <img id="img" src="validatecode/show" title="看不清楚，换一张" alt="验证码">
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block" hidden>
            <button class="layui-btn createBtn" lay-submit lay-filter="*">保存</button>
        </div>
    </div>

</form>
<script>
    $(function () {
        $('#img').click(function () {
            /*重新请求图片路径 不加参数会导致图片不能覆盖之前的图片*/
            $('#img').attr('src','validatecode/show?random='+Math.random());
        })
    })
    layui.use('form', function () {
        var form = layui.form;
        var code;
        var oldPass;
        form.verify({
            oldPassword:function (value, item) {
                if (value == null || value == undefined || value == '') {
                    return "必填项不能为空"
                } else {
                    $.ajax('user/validateoldpass', {
                        type: 'POST',
                        cache: false,
                        async: false,//默认为true异步
                        // 在等待server端返回的这个过程中，前台会继续 执行ajax块后面的脚本，直到server端返回正确的结果才会去执行success
                        //导致两个线程
                        data: {'userId': ${userId}},
                        dataType: 'json',
                        success: function (data) {
                            oldPass = eval(data.oldPas);
                        }
                    });
                    if (oldPass != value) {
                        return "旧密码错误"
                    }
                }
            }

            ,newPassword:function (value, item) {
                var oldPassword = $('#oldPassword').val();
                var pass = /^[\S]{6,12}$/;
                if (value == null || value == undefined || value == '') {
                    return "必填项不能为空"
                } else {
                    if (value == oldPassword){
                        return "新密码和旧密码一样"
                    }
                    if (value != oldPassword && !pass.test(value)) {
                        return "密码必须6到12位，且不能出现空格"
                    }
                }
            }
            ,reqPassword:function (value, item) {
                var oldPassword = $('#oldPassword').val();
                var newPassword = $('#newPassword').val();
                var pass = /^[\S]{6,12}$/;
                if (value == null || value == undefined || value == '') {
                    return "必填项不能为空"
                } else {

                    if (value != newPassword) {
                        return "两次密码输入不一致"
                    }
                }
            }

            ,validatecode: function (value, item) {
                if (value == null || value == undefined || value == '') {
                    return "必填项不能为空"
                } else {
                    $.ajax('user/validatecode', {
                        type: 'POST',
                        cache: false,
                        async: false,//默认为true异步
                        // 在等待server端返回的这个过程中，前台会继续 执行ajax块后面的脚本，直到server端返回正确的结果才会去执行success
                        //导致两个线程
                        data: {'validatecode': value},
                        dataType: 'json',
                        success: function (data) {
                            code = eval(data.validatecode);
                        }
                    });
                    if (code == false) {
                        return "验证码错误"
                    }
                }
            }
        })
        form.on('submit(*)',function (data) {
            //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
            //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
            //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
            //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。

            $.ajax('user/updatepassword', {
                type: 'POST',
                data: $('.userForm').serialize(),
                dataType: 'json',
                async: false,//默认为true异步
                success: function (data) {
                    //console.log(data);
                    if (data) {
                        layui.use('layer', function () {
                            var layer = layui.layer;
                            layer.alert('修改成功', {
                                skin: 'layui-layer-molv' //样式类名
                                , closeBtn: 0
                                , anim: 4 //动画类型
                            }, function () {
                                var index = parent.layer.getFrameIndex(window.name); //父级子级弹窗一起关闭
                                parent.layer.close(index);
                                //parent.location.reload();
                                parent.loadPage('user/userinfo');
                            });
                        })
                    }else{

                        layui.use( 'layer', function () {
                            var layer = layui.layer;
                            layer.alert('修改失败', {
                                skin: 'layui-layer-molv' //样式类名
                                , closeBtn: 0
                                , anim: 4 //动画类型
                            })
                        })


                    }
                }
            })
            return false;//阻止表单跳转
        })
    })

</script>
</table>


</body>
</html>
