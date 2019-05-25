<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/7
  Time: 11:21
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <base href="<%=basePath%>">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>铁路货运会员中心</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo"><a href='center'><span style="color: #FFFFFF">铁路货运</span></a></div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <c:choose>
                    <c:when test="${user.userName!=null}">
                        <a>${user.userName}</a>
                        <dl class="layui-nav-child">
                            <dd><a href="center" target="_self">会员中心</a></dd>
                            <dd><a href="logout">退出</a></dd>
                        </dl>
                    </c:when>
                    <c:otherwise>
                        <a href="touserlogin">更多操作请登录</a>
                    </c:otherwise>
                </c:choose>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <%--<li class="layui-nav-item layui-nav-itemed"> layui-nav-itemed 默认打开下拉--%>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">我要寄货</a>
                    <dl class="layui-nav-child">
                        <dd><a href="order/orderinfo" target="content">在线下单</a></dd>
                        <dd><a href="user/userlist" target="content">价格时效查询</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">我的订单</a>
                    <dl class="layui-nav-child">
                        <dd><a href="order/orderlist" target="content">全部订单</a></dd>
                        <dd><a href="follow/tofollowinfo" target="content">货物追踪</a></dd>
                        <dd><a href="getstatus/getstatuslist" target="content">领货</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="complaint/complaintlist" target="content">建议投诉</a></li>
                <li class="layui-nav-item"><a href="compensate/compensatelist" target="content">在线理赔</a></li>
                <li class="layui-nav-item">
                    <a href="javascript:;">账户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="user/userinfo?userId=${userId}" target="content">个人信息设置</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <%--<div id="content">--%>
        <div id="content" style="padding: 15px;height: 100%">
            <iframe id="mainframe" name="content" style="overflow: hidden;" scrolling="no" frameborder="no" width="100%"
                    height="100%">
            </iframe>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © transportion.com
    </div>
</div>
<script src="Binary/layui-v2.4.5/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;

        element.on('nav(test)', function (elem) {

            console.log(elem); //得到当前点击的DOM对象
            elem.parent().siblings().removeClass('layui-nav-itemed') //左侧菜单不默认打开
        });
    });
</script>

</body>
</html>