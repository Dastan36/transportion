<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/16
  Time: 22:15
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
    <title>快运班列修改</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
</head>
<body>
<form class="layui-form" action="train/update">
    <input type="hidden" name="traId" value="${train.traId}">
    <input type="hidden" name="createTime" value="<fmt:formatDate value="${train.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
    <div class="layui-form-item">
        <label class="layui-form-label">快运班列：</label>
        <div class="layui-input-inline">
            <input type="text" name="traName" value="${train.traName}" autocomplete="off" class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所属机构：</label>
        <div class="layui-input-inline">
            <select name="orgId" lay-verify="">
                <c:forEach items="${orgList}" var="org" varStatus="status">
                    <option value="${org.orgId}" name="orgId" <c:if test="${organize.orgId == org.orgId}">selected = "selected"</c:if>>${org.orgName}</option>
                </c:forEach>
            </select>
        </div>
    </div>



    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>

</form>
</table>
<script>
    //Demo
    layui.use('form', function(){
        var form = layui.form;

    });
</script>

</body>
</html>
