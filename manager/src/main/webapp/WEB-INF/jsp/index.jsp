<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <base href="<%=basePath%>">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>铁路货运后台系统</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">铁路货运后台管理系统</div>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <%--<img src="http://t.cn/RCzsdCq" class="layui-nav-img">--%>
                    ${adminName}
                </a>

            </li>
            <li class="layui-nav-item"><a href="logout">退出</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <%--<li class="layui-nav-item layui-nav-itemed"> layui-nav-itemed 默认打开下拉--%>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">客户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">合同范本管理</a></dd>
                        <dd><a href="user/userlist" target="content">客户基本信息管理</a></dd>
                        <dd><a href="javascript:;">合同管理</a></dd>
                        <dd><a href="order/orderlist" target="content">订单管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">运输管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="station/stationlist" target="content">站点管理</a></dd>
                        <dd><a href="way/waylist" target="content">方案管理</a></dd>
                        <dd><a href="follow/tosearch" target="content">运输跟踪</a></dd>
                        <dd><a href="getstatus/getstatuslist" target="content">领货</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="organize/orglist" target="content">机构管理</a></li>
                <li class="layui-nav-item"><a href="train/trainlist" target="content">快运班列</a></li>
                <li class="layui-nav-item"><a href="">合同管理</a></li>
                <li class="layui-nav-item"><a href="complaint/complaintlist" target="content">建议投诉</a></li>
                <li class="layui-nav-item"><a href="compensate/compensatelist" target="content">报价理赔</a></li>
                <li class="layui-nav-item"><a href="admin/adminlist" target="content">管理员列表</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;height: 100%">
            <iframe id="option" name="content" style="overflow: hidden;" scrolling="no" frameborder="no" width="100%"
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