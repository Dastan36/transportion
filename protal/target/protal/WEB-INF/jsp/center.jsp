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

    <%--layui--%>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>

    <script src="Binary/js/jquery1.9.1.js"></script>
    <script src="Binary/js/jQuery.query.js"></script>


    <%--baidu 地图--%>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=PlhFWpA02aoURjAOpnWcRGqw7AI8EEyO"></script>

    <!-- 加载编辑器的容器 -->
    <script id="container" name="content" type="text/plain">
    </script>
    <!-- 配置文件 -->
    <script type="text/javascript" src="Binary/ueditor/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="Binary/ueditor/ueditor.all.js"></script>

    <script type="text/javascript" charset="utf-8" src="Binary/ueditor/lang/zh-cn/zh-cn.js"></script>

    <script>
        UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    </script>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo"><a href=''><span style="color: #FFFFFF">铁路货运</span></a></div>
        <ul class="layui-nav layui-layout-left">

            <li class="layui-nav-item refresh" lay-unselect="">
                <a href="javascript:;" layadmin-event="refresh" title="刷新">
                    <i class="layui-icon layui-icon-refresh-3 "></i>
                </a>
            </li>
            <span class="layui-nav-bar" style="left: 150px; top: 48px; width: 0px; opacity: 0;"></span>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <c:choose>
                    <c:when test="${user.userName!=null}">
                        <a style="cursor:pointer">${user.userName}</a>
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
                        <dd><a style="cursor:pointer" onclick="loadPage('order/orderinfo')">在线下单</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">我的订单</a>
                    <dl class="layui-nav-child">
                        <dd><a style="cursor:pointer" onclick="loadPage('order/tolist')">全部订单</a></dd>
                        <dd><a style="cursor:pointer" onclick="loadPage('follow/tofollowinfo')">货物追踪</a></dd>
                        <dd><a style="cursor:pointer" onclick="loadPage('getstatus/tolist')">领货</a></dd>
                    </dl>
                </li>
                    <li class="layui-nav-item"><a style="cursor:pointer" onclick="loadPage('contract/tolist')">我的合同</a></li>
                <li class="layui-nav-item"><a style="cursor:pointer" onclick="loadPage('complaint/tolist')">建议投诉</a></li>
                <li class="layui-nav-item"><a style="cursor:pointer" onclick="loadPage('compensate/tolist')">在线理赔</a></li>
                <li class="layui-nav-item">
                    <a href="javascript:;">账户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a style="cursor:pointer" onclick="loadPage('user/userinfo')">个人信息设置</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <%--<div id="content">--%>
        <div id="content" style="padding: 15px;height: auto;width: auto;">

        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © transportion.com
    </div>
</div>
<script src="Binary/layui-v2.4.5/layui/layui.js"></script>
<script>
    var URL;
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;

           element.on('nav(test)', function (elem) {

            //console.log(elem); //得到当前点击的DOM对象
            elem.parent().siblings().removeClass('layui-nav-itemed') //左侧菜单不默认打开
        });
    });

    function loadPage(url) {
        URL = url;
        $.ajax({
            type: "POST",
            url: URL,
            async: true,
            dataType: "html",
            contentType: 'application/json; charset=utf-8',
            success: function (html) {
                //removeEvent($('#content').get(0));

                $('body').unbind();  //頁面的事件綁定document 解绑事件 直接onclick不需要
                $('#content').html("");
                $('#content').html(html); //$('#right').load(url);//load函数同样能实现效果


            }
        });
    }
    $(function () {
        $(".refresh").click(function () {
            //alert(URL);
            $.ajax({
                type: "POST",
                url: URL,
                async: true,
                dataType: "html",
                contentType: 'application/json; charset=utf-8',
                success: function (html) {
                    //removeEvent($('#content').get(0));

                    $('body').unbind();  //頁面的事件綁定document 解绑事件 直接onclick不需要

                    $('#content').html(html); //$('#right').load(url);//load函数同样能实现效果


                }
            });
        })
    })
    $(function () {
        //此处是用来 order.jsp 也就是最外边的订单form 跳转到会员中心操作  （传值 接值  跳转）
        //jQuery.query.js  插件   html 之间传值
        var url = $.query.get('url');
        //alert(url);     //  ali/topay?orderId
        var orderId = $.query.get('orderId');
        //alert(orderId);  //.....
        if(url != null && url != ""){
            loadPage(url);
        }
        if(orderId != null && orderId !=""){
            loadPage(url+"="+orderId);
        }
    })

</script>

</body>
</html>