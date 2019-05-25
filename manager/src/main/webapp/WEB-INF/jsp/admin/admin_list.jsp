<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/7
  Time: 17:37
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
    <title>Title</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
</head>
<body>
<table class="layui-table" >
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>序号</th>
        <th>用户</th>
        <th>密码</th>
        <th>创建时间</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${adminList}" var="admin" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${admin.adminName}</td>
                <%--<td width="25%" style="word-break : break-all; overflow:hidden; ">${pic.content}</td>--%>
            <td>${admin.password}</td>
            <td><fmt:formatDate value="${admin.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
