<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/27
  Time: 11:48
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
    <title>站点更新</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=PlhFWpA02aoURjAOpnWcRGqw7AI8EEyO"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
</head>
<body>
<div style="width: 1285px;">
    <div style="width: 670px;">
        <form class="layui-form" action="station/update">
            <input type="hidden" name="stationId" value="${station.stationId}" />
            <div class="layui-form-item">
                <label class="layui-form-label">站点：</label>
                <div class="layui-input-inline">
                    <input type="text" name="stationName" value="${station.stationName}" required lay-verify="required" placeholder="请输入" class="layui-input stationName" onkeyup='searchByStationName(this.value);' onchange='searchByStationName(this.value);' onblur="searchByStationName(this.value);">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">经度：</label>
                <div class="layui-input-inline">
                    <input type="text" name="coordinate_l" value="${station.coordinate_l}" required lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input coordinate_l" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">纬度：</label>
                <div class="layui-input-inline">
                    <input type="text" name="coordinate_r" value="${station.coordinate_r}" required lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input coordinate_r" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">城市：</label>
                <div class="layui-input-inline">
                    <input type="text" name="city" value="${station.city}" placeholder="请输入" required lay-verify="required" autocomplete="off" class="layui-input city" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">省份：</label>
                <div class="layui-input-inline">
                    <input type="text" name="province" value="${station.province}" placeholder="请输入" required lay-verify="required" autocomplete="off" class="layui-input province" >
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <div id="allMap" style="border: 1px black solid;position:absolute;left:675px;top:0px;width: 650px;height: 600px;">
        <%--地图div--%>
    </div>
</div>


<script>
    //Demo
    layui.use('form', function(){
        var form = layui.form;

    });
</script>
<script type="text/javascript">

    //地图代码
    var map = new BMap.Map("allMap");
    map.centerAndZoom("北京市", 12);
    map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
    map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用

    map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
    map.addControl(new BMap.OverviewMapControl()); //添加默认缩略地图控件
    map.addControl(new BMap.OverviewMapControl({ isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT }));   //右下角，打开

    var localSearch = new BMap.LocalSearch(map);
    localSearch.enableAutoViewport(); //允许自动调节窗体大小
    function searchByStationName(val) {
        map.clearOverlays();//清空原来的标注
        //alert(val);
        var keyword = val;
        localSearch.setSearchCompleteCallback(function (searchResult) {
            var poi = searchResult.getPoi(0);
            var coordinate = poi.point.lng + "," + poi.point.lat;
            var newLoc = coordinate.split(",");
            var point = new BMap.Point(parseFloat(newLoc[0]),parseFloat(newLoc[1]));
            var gc = new BMap.Geocoder();
            gc.getLocation(point,function(rs){
                var addComp = rs.addressComponents;
                var city = addComp.city;
                var province = addComp.province; //省
                //alert(mapAddress);
                $(".city").attr("value",city);
                $(".province").attr("value",province);
            })
            $(".coordinate_l").attr("value",poi.point.lng);
            $(".coordinate_r").attr("value",poi.point.lat);
            map.centerAndZoom(poi.point, 13);
            var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
            map.addOverlay(marker);
        });
        localSearch.search(keyword);
    }
</script>
</body>
</html>

