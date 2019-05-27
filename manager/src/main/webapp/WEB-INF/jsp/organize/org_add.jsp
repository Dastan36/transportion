<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/15 0015
  Time: 上午 9:32
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
    <title>机构添加</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
</head>
<body>
<br>
<form class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">机构名：</label>
        <div class="layui-input-inline">
            <input id="orgName" type="text" name="orgName" placeholder="请输入" autocomplete="off" required lay-verify="required"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block" hidden>
            <button class="layui-btn createBtn" lay-submit lay-filter="formDemo">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>

</form>
</table>
<script>
    $(function () {

        $('.createBtn').click(function () {
            var orgName = $('#orgName').val();
            //console.log(orgName);
            $.ajax('organize/saveorg',{
                type:'POST',
                data:{'orgName':orgName},
                dataType:'json',
                async:false,//默认为true异步
                success:function (data) {
                    console.log(data);
                    if (data) {
                        layui.use( 'layer', function () {
                            var layer = layui.layer;
                            layer.open({
                                type: 1
                                ,offset: 'c'
                                ,content: '理赔申请成功'
                                ,btn: '确定'
                                ,btnAlign: 'c' //按钮居中
                                ,shade: 0.2 //显示遮罩率
                                ,yes: function(){
                                    var index=parent.layer.getFrameIndex(window.name); //父级子级弹窗一起关闭
                                    parent.layer.close(index);
                                    parent.location.reload();
                                }
                            });
                        })
                    }
                }
            })
        })
    })
</script>
</body>
</html>
