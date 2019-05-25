<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/5
  Time: 13:15
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
    <title>铁路货运门户网站</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
    <style>
        .hp-online {
            min-width: 1300px;
            width: 100%;
            height: 121px;
            background: rgba(41,44,54,0.9);
            position: absolute;
            margin-top: -121px;
            z-index: 1;
        }
        body {
            font-size: 14px;
            line-height: 1.5;
            color: #333;
        }
        .hp-online .online-container {
            overflow: hidden;
            margin: 0 auto;
        }
        .flex {
            display: -moz-box;
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
        }
        .PAGE_WIDTH {
            width: 800px;
        }
        .hp-online .online-container .online-box {
            width: 25%;
            float: left;
            flex: 1;
            height: 121px;
            box-sizing: border-box;
            -moz-transition: all .4s ease 0s;
            -webkit-transition: all .4s ease 0s;
            -ms-transition: all .4s ease 0s;
            -webkit-transition: all .4s ease 0s;
            transition: all .4s ease 0s;
        }
        .hp-online .online-container .online-box a {
            box-sizing: border-box;
            display: inline-block;
            width: 100%;
            height: 100%;
            padding: 35px 0px 0px 21px;
            color: #8890a4;
            -moz-transition: all .4s ease 0s;
            -webkit-transition: all .4s ease 0s;
            -ms-transition: all .4s ease 0s;
            -webkit-transition: all .4s ease 0s;
            transition: all .4s ease 0s;
            overflow: hidden;
        }
        a {
            background: transparent;
            text-decoration: none;
            color: #08c;
        }
        元素 {
            width: 45px;
        }
        .hp-online .online-container .online-box .icon {
            padding-top: 5px;
            width: 38px;
            height: 43px;
            -moz-transition: all .4s ease 0s;
            -webkit-transition: all .4s ease 0s;
            -ms-transition: all .4s ease 0s;
            -webkit-transition: all .4s ease 0s;
            transition: all .4s ease 0s;
            fill: #8890a4;
            margin-bottom: 25px;
        }
        .hp-online .online-container .online-box a svg {
            float:left;
            margin-right: 11px;
        }
        svg:not(:root) {
            overflow: hidden;
        }
        .hp-online .online-container .online-box a div .title1 {
            font-size: 16px;
        }
        .hp-online .online-container .online-box p {
            line-height: 30px;
        }
        h1, h2, h3, h4, h5, h6, p, figure, form, blockquote {
            margin: 0;
        }
    </style>
</head>
<body style="background-color: #14182d">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo"><a href='center'><span style="color: #FFFFFF">铁路货运</span></a></div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <c:choose>
                    <c:when test="${userName!=null}">
                    <a >${userName}</a>
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

    <div id="contenter">
            <div id="carousel" class="layui-carousel"style="border: black 1px solid">
            <div carousel-item="">
                <div><img src="Binary/image/custommap-banner.png" width="100%" height="100%"/></div>
                <div><img src="Binary/image/ipv6-banner.png" width="100%" height="100%"/></div>
                <div><img src="Binary/image/traffic-0329.png" width="100%" height="100%"/></div>
            </div>
        </div>

        <div class="hp-online">
            <div class="PAGE_WIDTH flex online-container">

                <div class="online-box">
                    <a href='order/protalorder' target="_self" >
                        <div>
                            <p class='title1'>
                                在线下单
                            </p>
                            <p class='title2'>货运我们更专业</p>
                        </div>
                    </a>
                </div>

                <div class="online-box">
                    <a href='/index.php?title=FAQ/tags' target="_self">
                        <div>
                            <p class='title1'>
                                价格时效查询
                            </p>
                            <p class='title2'>随时随地查询时效价格</p>
                        </div>
                    </a>
                </div>
                <div class="online-box">
                    <a href='follow/tofollowprotal' target="_self">
                        <div>
                            <p class='title1'>
                                货运追踪
                            </p>
                            <p class='title2'>当前货物运输状态</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
<script>
    //注意：导航 依赖 element 模块，否则无法进行功能性操作
    layui.use('element', function(){
        var element = layui.element;
    });
    layui.use('carousel', function(){ //轮播图
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#carousel'
            ,width: '100%' //设置容器宽度
            ,arrow: 'always' //始终显示箭头
            ,height: '70%'
            ,interval: '6000'
            //,anim: 'updown' //切换动画方式
        });
    });
</script>
</html>
