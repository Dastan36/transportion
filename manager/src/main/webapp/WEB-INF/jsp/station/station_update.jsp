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
    <%--layui--%>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>

    <script src="Binary/js/jquery1.9.1.js"></script>
    <%--baidu 地图--%>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=PlhFWpA02aoURjAOpnWcRGqw7AI8EEyO"></script>
</head>
<body>
<br>
<div style="width: 1285px;">
    <div style="width: 670px;">
        <form class="layui-form stationForm">
            <input type="hidden" name="stationId" value="${station.stationId}" />
            <div class="layui-form-item" >
                <label class="layui-form-label">站点：</label>
                <div class="layui-input-inline">
                    <input id="stationName" type="text" name="stationName" value="${station.stationName}" placeholder="请输入" lay-verify="required"
                           class="layui-input" oninput="cop()">
                </div>
                <input type="text" id="suggestId" style="border: 0px;width:220px;height:0;">
                <div id="searchResultPanel"
                     style="border:1px solid #C0C0C0;width:150px;z-index: 999;height:auto; display:none;"></div>
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
                <div class="layui-input-block" hidden>
                    <button class="layui-btn update" type="button" lay-submit lay-filter="btn_save">立即提交</button>

                </div>
            </div>
        </form>
    </div>
    <div id="allMap" style="border: 1px black solid;position:absolute;left:675px;top:0px;width: 650px;height: 600px;">
        <%--地图div--%>
    </div>
</div>


<script>

    layui.use(['form'],function () {
        var form=layui.form;
        form.on('submit(btn_save)',function () {
            $.ajax('station/update', {
                type: 'POST',
                data: $('.stationForm').serialize(),  //整个表单的内容
                dataType: 'json',
                async: false,//默认为true异步
                success: function (data) {
                    if (data) {
                        layui.use( 'layer', function () {
                            var layer = layui.layer;
                            layer.alert('修改成功', {
                                skin: 'layui-layer-molv' //样式类名
                                ,closeBtn: 0
                                ,anim: 4 //动画类型
                            }, function(){
                                var index=parent.layer.getFrameIndex(window.name); //父级子级弹窗一起关闭
                                parent.layer.close(index);
                                //parent.location.reload();
                                parent.loadPage('station/tolist');
                            });
                        })
                    }
                }
            });
            return false;//阻止表单跳转
        })

    })

    function cop() {
        var str = document.getElementById("stationName").value;
        document.getElementById("suggestId").value = str;
    }
</script>
<script>

    // 百度地图API功能
    function G(id) {
        return document.getElementById(id);
    }

    //地图代码
    var map = new BMap.Map("allMap");
    map.centerAndZoom(new BMap.Point(parseFloat($('.coordinate_l').val()), parseFloat($('.coordinate_r').val())), 12);
    map.enableScrollWheelZoom();    //启用滚轮放大缩小，默认禁用
    map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
    map.enableScrollWheelZoom(true);             //开启鼠标滚轮缩放
    map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
    map.addControl(new BMap.OverviewMapControl()); //添加默认缩略地图控件
    map.addControl(new BMap.OverviewMapControl({isOpen: true, anchor: BMAP_ANCHOR_BOTTOM_RIGHT}));   //右下角，打开

    //var localSearch = new BMap.LocalSearch(map);
    //localSearch.enableAutoViewport(); //允许自动调节窗体大小

    var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
        {
            "input": "suggestId"
            , "location": map
        });

    ac.addEventListener("onhighlight", function (e) {  //鼠标放在下拉列表上的事件
        var str = "";
        var _value = e.fromitem.value;
        var value = "";
        if (e.fromitem.index > -1) {
            value = _value.province + _value.city + _value.district + _value.street + _value.business;
        }
        str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

        value = "";
        if (e.toitem.index > -1) {
            _value = e.toitem.value;
            value = _value.province + _value.city + _value.district + _value.street + _value.business;
        }

        str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;

        G("searchResultPanel").innerHTML = str;
    });

    var myValue;
    ac.addEventListener("onconfirm", function (e) {    //鼠标点击下拉列表后的事件
        var _value = e.item.value;
        myValue = _value.province + _value.city + _value.district + _value.street + _value.business;
        G("searchResultPanel").innerHTML = "onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
        setPlace();
        $("suggestId").attr('value', '');
    });

    function setPlace() {
        map.clearOverlays();    //清除地图上所有覆盖物
        function myFun() {
            var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
            map.centerAndZoom(pp, 18);
            map.addOverlay(new BMap.Marker(pp));    //添加标注
            var point = new BMap.Point(parseFloat(pp.lng), parseFloat(pp.lat));
            var gc = new BMap.Geocoder();
            gc.getLocation(point, function (rs) {
                var addComp = rs.addressComponents;
                var city = addComp.city;  //市
                var province = addComp.province; //省
                //alert(mapAddress);
                $(".city").val(city);
                $(".province").val(province);

            })
            alert(pp.lng)
            $(".coordinate_l").val(pp.lng);
            $(".coordinate_r").val(pp.lat);
        }

        var local = new BMap.LocalSearch(map, { //智能搜索
            onSearchComplete: myFun
        });
        local.search(myValue);
    }


    /*function searchByStationName(val) {     //stationName  input框添加onkeyup事件
        map.clearOverlays();//清空原来的标注
        //alert(val);
        var keyword = val;
        localSearch.setSearchCompleteCallback(function (searchResult) {
            var poi = searchResult.getPoi(0);
            var coordinate = poi.point.lng + "," + poi.point.lat;
            var newLoc = coordinate.split(",");
            var point = new BMap.Point(parseFloat(newLoc[0]), parseFloat(newLoc[1]));
            var gc = new BMap.Geocoder();
            gc.getLocation(point, function (rs) {
                var addComp = rs.addressComponents;
                var city = addComp.city;  //市
                var province = addComp.province; //省
                //alert(mapAddress);
                $(".city").attr("value", city);
                $(".province").attr("value", province);

            })
            $(".coordinatel").attr("value", poi.point.lng);
            $(".coordinater").attr("value", poi.point.lat);

            map.centerAndZoom(poi.point, 13);
            var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
            map.addOverlay(marker);
        });
        localSearch.search(keyword);
    }*/

</script>
</body>
</html>

