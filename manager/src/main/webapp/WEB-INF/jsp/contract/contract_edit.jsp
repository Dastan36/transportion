<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/5/28
  Time: 20:56
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>

    <link rel="stylesheet" href="Binary/umeditor/themes/default/css/umeditor.css">

    <!-- 加载编辑器的容器 -->
    <script id="container" name="content" type="text/plain">
    </script>
    <!-- 配置文件 -->
    <script type="text/javascript" src="Binary/umeditor/umeditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="Binary/umeditor/umeditor.js"></script>

    <script type="text/javascript" charset="utf-8" src="Binary/umeditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div id="content">
        <form class="layui-form contractForm" action="contract/update" enctype="multipart/form-data">
            <input type="text" name="contractId" hidden value="${contract.contractId}">
                <textarea name="contractEdit"  id="editor" style="border:0;height: 250px" required class="layui-textarea">
                    ${contract.contractEdit}
                </textarea>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">

                    //1.2.2版本字体样式大小可以正常使用  1.2.3不好使
                    var um = UM.getEditor('editor',{
                        toolbar:['source | undo redo | bold italic underline strikethrough | superscript subscript | forecolor  | removeformat ',
                            '| selectall cleardoc paragraph | fontfamily fontsize' ,
                            '| justifyleft justifycenter justifyright justifyjustify |',
                            '| horizontal print preview ', 'formula'],
                        initialFrameWidth: null , autoHeightEnabled: false
                    });
                    um.setHeight(545);
                    um.setWidth(1275);

                </script>
            <br>
            <div class="layui-form-item">
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn subBtn" type="button" lay-submit lay-filter="*">保存</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    $(function () {
        $(document).on('click','.subBtn',function () {
            $.ajax('contract/update',{
                type:'POST',
                dataType:'json',
                data:$('.contractForm').serialize(),
                success:function(data){
                    if (data) {
                        loadPage('contract/toedit');
                    }
                }
            })
        })
    })
</script>
</html>
