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
</head>
<script>
    $(function () {
        $('.updatePass').click(function () {
            layui.use(['form', 'layer'], function () {
                var form = layui.form;
                form.render();
                var layer = layui.layer;
                layer.open({
                    type: 2   //iframe层
                    , content: ['user/toupdatepassword', 'no']  //这里content是一个URL，如果你不想让iframe出现滚动条 加 no
                    , title: '修改密码'
                    , area: ['600px', '400px']            //宽高
                    , btn: ['确定', '关闭']
                    , offset:'c'
                    , yes: function (index, layero) { //当前层索引、当前层DOM对象
                        var form = layer.getChildFrame('form', index);//得到弹出框中页面的body
                        //var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                        //console.log(body.html()) //得到iframe页的body内容
                        form.find('.createBtn').click();
                    }
                    , btn2: function (index, layero) {
                        layer.close(index);
                    }
                })
            })
        })
    })
</script>
<body>
<%--action="user/update"--%>
<form class="layui-form userForm" >
    <h2>个人资料设置</h2>
    <br>
    <a class="updatePass" style="font-size: 15px;font-style: italic;cursor:pointer" >修改密码</a>
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
            <button class="layui-btn" lay-submit lay-filter="*">保存</button>
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
        form.on('submit(*)', function (data) {
            //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
            //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
            //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
            //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。

            $.ajax('user/update', {
                type: 'POST',
                data: $('.userForm').serialize(),
                dataType: 'json',
                async: false,//默认为true异步
                success: function (data) {
                    //alert(data.pay)
                    if (data) {
                        layui.use(['layer'], function () {
                            var layer = layui.layer;
                            layer.msg('修改成功', {
                                icon: 1
                                ,time:1000
                            },function () {
                                loadPage('user/userinfo');
                            });
                        })
                    }else{
                        layui.use(['layer'], function () {
                            var layer = layui.layer;
                            layer.msg('修改失败', {
                                icon: 1
                                ,time:1000
                            },function () {
                                loadPage('user/userinfo');
                            });
                        })
                    }
                }
            })
            return false;//阻止表单跳转
        })
    });
</script>
</table>


</body>
</html>
