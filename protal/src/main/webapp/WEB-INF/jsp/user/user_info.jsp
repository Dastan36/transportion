<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/7
  Time: 14:15
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
<form class="layui-form" action="user/update">
    <h2>个人资料设置</h2>
    <br>
    <a style="font-size: 15px;font-style: italic" href="user/toupdatepassword">修改密码</a>
    <br><br>
    <h2>基本信息</h2>
    <br><br>
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="createTime" value="<fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名：</label>
        <div class="layui-input-inline">
            <input type="text" name="userName" value="${user.userName}" required lay-verify="required" lay-verType="tips" autocomplete="off" class="layui-input" >
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">联系电话：</label>
        <div class="layui-input-inline">
            <input type="text" name="telephone" value="${user.telephone}" required lay-verify="telephone"  lay-verType="tips" autocomplete="off" class="layui-input" >
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
        </div>
    </div>

</form>
<script>
    layui.use('form', function(){
        var form = layui.form;
        var oldTel = ${user.telephone};
       // console.log(oldTel)
        var phone;
        form.verify({
            telephone:function (value,item) {
                var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
                if(value != oldTel){
                    if (!myreg.test(value)) {
                        return "请输入正确的手机号"
                    }else{
                        $.ajax('user/verifyphone', {
                            type: 'POST',
                            cache: false,
                            async: false,//默认为true异步
                            // 在等待server端返回的这个过程中，前台会继续 执行ajax块后面的脚本，直到server端返回正确的结果才会去执行success
                            //导致两个线程
                            data: {
                                'userId': ${userId}
                            },
                            dataType: 'json',
                            success: function (data) {
                                phone = eval(data.user);
                            }
                        })
                        if(phone == false){
                            return "此手机号已被注册"
                        }
                    }
                }
            }
        })
    });
</script>
</table>


</body>
</html>
