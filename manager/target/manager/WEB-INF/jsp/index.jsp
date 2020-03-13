<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <%--layui--%>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>

    <script src="Binary/js/jquery1.9.1.js"></script>

    <%--baidu 地图--%>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=PlhFWpA02aoURjAOpnWcRGqw7AI8EEyO"></script>

    <%--ueditor--%>
    <!-- 配置文件 -->
    <script type="text/javascript" src="Binary/ueditor/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="Binary/ueditor/ueditor.all.js"></script>

    <script type="text/javascript" charset="utf-8" src="Binary/ueditor/lang/zh-cn/zh-cn.js"></script>

    <script>

        UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;

    </script>


    <script>
        $(function () {
            var layer = null;
            var form = null;
            layui.use(['layer', 'form'], function () {
                layer = layui.layer;
                form = layui.form;
            });
        })


    </script>

</head>
<body class="layui-layout-body" style="height: 100%">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">铁路货运后台管理系统</div>
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
                        <dd><a style="cursor:pointer" onclick="loadPage('order/tolist')">订单管理</a></dd>
                        <dd><a style="cursor:pointer" onclick="loadPage('user/tolist')">客户基本信息管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">运输管理</a>
                    <dl class="layui-nav-child">
                        <c:if test="${adminName eq '国家铁路局'}">

                            <dd><a style="cursor:pointer" onclick="loadPage('station/tolist')">站点管理</a></dd>
                            <dd><a style="cursor:pointer" onclick="loadPage('way/tolist')">方案管理</a></dd>
                        </c:if>
                        <dd><a style="cursor:pointer" onclick="loadPage('follow/tosearch')">运输跟踪</a></dd>
                        <dd><a style="cursor:pointer" onclick="loadPage('getstatus/tolist')">领货</a></dd>
                    </dl>
                </li>
                <c:if test="${adminName eq '国家铁路局'}">

                    <li class="layui-nav-item"><a style="cursor:pointer" onclick="loadPage('organize/tolist')">机构管理</a>
                    </li>
                    <li class="layui-nav-item"><a style="cursor:pointer" onclick="loadPage('train/tolist')">快运班列</a>
                    </li>
                </c:if>
                <li class="layui-nav-item">
                    <a href="javascript:;">合同管理</a>
                    <dl class="layui-nav-child">
                        <dd><a style="cursor:pointer" onclick="loadPage('contract/toedit')">合同范本管理</a></dd>
                        <dd><a style="cursor:pointer" onclick="loadPage('contract/tolist')">合同管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a style="cursor:pointer" onclick="loadPage('complaint/tolist')">建议投诉</a>
                </li>
                <li class="layui-nav-item"><a style="cursor:pointer" onclick="loadPage('compensate/tolist')">报价理赔</a>
                </li>
                <c:if test="${adminName eq '国家铁路局'}">

                    <li class="layui-nav-item"><a style="cursor:pointer" onclick="loadPage('admin/tolist')">管理员列表</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域   width: auto; 使宽度适应-->
        <div id="content" style="padding: 15px;height: auto;width: auto;">
            <%--<iframe id="option" name="content" style="overflow: hidden;" scrolling="yes" frameborder="no"--%>
            <%--width="100%" height="100%" >--%>
            <%--</iframe>--%>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © transportion.com
    </div>
</div>
<script>
    var URL;
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;

        element.on('nav(test)', function (elem) {

            console.log(elem); //得到当前点击的DOM对象
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

                $(document).unbind();  //頁面的事件綁定document 解绑事件 直接onclick不需要

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

                     $(document).unbind();  //頁面的事件綁定document 解绑事件 直接onclick不需要

                     $('#content').html(html); //$('#right').load(url);//load函数同样能实现效果


                 }
             });
         })
     })


    // function removeEvent(ele){
    //
    //     // console.info($(ele).attr('class'));
    //     $(ele).unbind();
    //
    //
    //
    //     if($(ele).hasClass("delBtn")){
    //         console.info(ele)
    //         $(ele).unbind();
    //     }
    //
    //     if($(ele).children().length>0){
    //         $($(ele).children()).each(function(){
    //             removeEvent(this);
    //         });
    //     }
    //
    // }

</script>
</body>
</html>