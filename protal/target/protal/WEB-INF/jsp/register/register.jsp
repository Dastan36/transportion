<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/5/11
  Time: 15:57
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
    <title>用户注册</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
    <style type="text/css">
        html, body {

            background: url(Binary/img/bg.jpg) no-repeat center center fixed; /* 与上面的bg中的background设置一样 */
        }

        .divForm {
            position: absolute; /*绝对定位*/
            width: 300px;
            height: 500px;

            border: 0px solid red;
            text-align: center; /*(让div中的内容居中)*/
            top: 50%;
            left: 50%;
            margin-top: -200px;
            margin-left: -150px;
        }

        .bg {
            background: url(Binary/img/bg.jpg) no-repeat center center fixed; /* 与下面的blur_box:before中的background设置一样 */
            width: 100%;
            height: 80%; /*背景*/

        }

        .blur_box {
            z-index: 0; /* 为不影响内容显示必须为最高层 */
            position: relative;
            overflow: hidden;
        }

        .blur_box:before {
            content: ""; /* 必须包括 */
            position: absolute; /* 固定模糊层位置 */
            width: 100%;
            height: 100%;
            left: -100%; /* 回调模糊层位置 */
            top: -100%; /* 回调模糊层位置 */
            background: url(Binary/img/bg.jpg) no-repeat center center fixed; /* 与上面的bg中的background设置一样 */
            filter: blur(50px); /* 值越大越模糊 */
            z-index: -2; /* 模糊层在最下面 */
        }

        .rgba {
            background-color: rgba(0, 0, 0, 0.2); /* 为文字更好显示，将背景颜色加深 */
            position: absolute; /* 固定半透明色层位置 */
            width: 100%;
            height: 100%;
            z-index: -1; /* 中间是rgba半透明色层 */
        }

        .content_text {
            text-align: center;
            color: rgba(255, 255, 255, 0.8);
            padding: 50px 30px;
            line-height: 28px;
        }

        article {
            width: 40%;
            height: 480px;
            margin: 60px auto;
        }
    </style>
</head>
<body>
<div class="bg">
    <article class="blur_box">
        <div class="rgba"></div><!-- 写在这其实和blur_box:before效果相同，但已经设置过blur_box:before了 -->
        <div class="divForm content_text" style="width: auto">
            <h2>账号注册</h2>
            <br>
            <form class="layui-form" action="register/register" style="z-index: 1">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-inline">
                        <input type="text" id="userName" name="userName" required lay-verify="required"
                               lay-verType="tips" placeholder="请输入手机号" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-inline">
                        <%--自定义验证 电话是否已注册--%>
                        <input type="text" id="telephone" name="telephone" required lay-verify="tele" lay-verType="tips"
                               placeholder="请输入手机号" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密&nbsp;&nbsp;码</label>
                    <div class="layui-input-inline">
                        <input type="password" id="password1" name="password" required lay-verify="pass"
                               lay-verType="tips" placeholder="请输入密码" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密&nbsp;&nbsp;码</label>
                    <div class="layui-input-inline">
                        <input type="password" id="password2" name="password2" required lay-verify="pass2"
                               lay-verType="tips" placeholder="请再次输入密码" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <%--<div class="layui-form-item">
                    <label class="layui-form-label">验证码</label>
                    <div class="layui-input-inline">
                        <input type="text" id="validatecode" name="validatecode" required lay-verify="validatecode" lay-verType="tips" placeholder="请输入验证码" autocomplete="off" class="layui-input">
                    </div>
                    <img id="img" src="validatecode/show" title="看不清楚，换一张" alt="验证码">
                </div>--%>
                <div class="layui-form-item">
                    <label class="layui-form-label">滑动验证</label>
                    <div class="layui-input-inline" required lay-verify="sliderVerify" lay-verType="tips">
                        <div id="slider"></div>
                    </div>
                </div>
                ${registerMsg}
                <div align="center" class="layui-form-item">
                    <div class="layui-input-block">
                        <button id="loginBtn" class="layui-btn" lay-submit lay-filter="formDemo">一键注册</button>
                        <button id="reset" type="reset" class="layui-btn layui-btn-primary">重置</button>

                    </div>
                </div>
            </form>
        </div>
    </article>
</div>
<script>
    var slider;
    $(function () {
        $('#img').click(function () {
            /*重新请求图片路径 不加参数会导致图片不能覆盖之前的图片*/
            $('#img').attr('src', 'validatecode/show?random=' + Math.random());
        })
        $('#reset').click(function () {
            slider.reset();
        })
    })

    layui.config({
        base: 'Binary/layui_exts/sliderVerify/'
    }).extend({ //设定模块别名
        sliderVerify: 'sliderVerify'
    }).use(['sliderVerify', 'jquery', 'form'], function () {
        var sliderVerify = layui.sliderVerify,
            form = layui.form;
        slider = sliderVerify.render({
            elem: '#slider',
            isAutoVerify: false,//关闭自动验证msg 可以手动验证
            //bg : 'layui-bg-red',//自定义背景样式名
            text: '请拖动滑块验证',
            onOk: function () {//当验证通过回调
                layer.tips("滑块验证通过");
            }
        })
        form.verify({
            sliderVerify: function (value, item) {
                //获取当前实例是否已经滑动成功
                if (!slider.isOk()) {
                    return "请拖动滑块验证"
                }
            }
        })
    })

    layui.use('form', function () {
        var form = layui.form;
        var phone;
        var code;
        form.verify({
            pass: [
                /^[\S]{6,12}$/
                , '密码必须6到12位，且不能出现空格'
            ]
            , pass2: function (value, item) { //value 为该节点值 item为dom对象
                var password1 = $('#password1').val();
                var password2 = value;
                if (password1 != password2) {
                    return "两次密码不匹配"
                }
            }
            , tele: function (value, item) {
                if (value == null || value == undefined || value == '') {
                    return "必填项不能为空"
                } else {
                    var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
                    if (!myreg.test(value)) {
                        return "请输入正确的手机号"
                    } else {
                        $.ajax('register/verifyphone', {
                            type: 'POST',
                            cache: false,
                            async: false,//默认为true异步
                            // 在等待server端返回的这个过程中，前台会继续 执行ajax块后面的脚本，直到server端返回正确的结果才会去执行success
                            //导致两个线程
                            data: {'telephone': value},
                            dataType: 'json',
                            success: function (data) {
                                phone = eval(data.user);
                            }
                        });
                        if (phone != null) {
                            return "此电话号码已注册"
                        }
                    }
                }
            }
            , validatecode: function (value, item) {
                if (value == null || value == undefined || value == '') {
                    return "必填项不能为空"
                } else {
                    $.ajax('register/validatecode', {
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
    });
</script>
</div>
</body>
</html>
