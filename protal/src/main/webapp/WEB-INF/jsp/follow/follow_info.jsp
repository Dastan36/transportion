<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/24
  Time: 22:24
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>

</head>
<body style="overflow-x:auto; overflow-y:hidden;">
<div class="layui-layout layui-layout-admin">
    <div id="content" >

        <form class="layui-form" >

            <div class="layui-input-inline" style="width: 300px">
                <input id="orderId" type="text" name="orderId" autocomplete="off"
                       placeholder="单号" class="layui-input">
            </div>
            <div class="layui-input-inline " style="width: 200px">
                <button id="follow" class="layui-btn" type="button" data-type="reload">
                    <i class="layui-icon" style="font-size: 20px; ">&#xe615;</i> 追踪货运
                </button>
            </div>


        </form>
        <br>
        <div id="alllMap" style="width: 100%;height: 600px"></div>

    </div>
</div>


</body>
<script>


    $(function () {

        var map = new BMap.Map("alllMap");
        map.centerAndZoom(new BMap.Point(116.404, 39.915), 13);
        map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
        map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
        map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
        map.enableScrollWheelZoom(true);                            //开启鼠标滚轮缩放

        $('#follow').click(function () {
            var orderId = $('#orderId').val();
            $.ajax('follow/selectStaion',{
                type:'POST',
                data:{'orderId':orderId},
                dateType:'json',
                success:function(data){
                    //单击获取点击的经纬度
                    // map.addEventListener("click",function(e){
                    //     alert(e.point.lng + "," + e.point.lat);
                    // });
                    var senderCoordinate_l = data.stationList[0].coordinate_l;
                    var senderCoordinate_r = data.stationList[0].coordinate_r;
                    var receiptCoordinate_l = data.stationList[1].coordinate_l;
                    var receiptCoordinate_r = data.stationList[1].coordinate_r;

                    var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/Mario.png", new BMap.Size(32, 70), {    //小车图片
                        //offset: new BMap.Size(0, -5),    //相当于CSS精灵
                        imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
                    });

                    var sender = new BMap.Point(parseFloat(senderCoordinate_l),parseFloat(senderCoordinate_r));    //起点-重庆
                    var current = new BMap.Point(116.74665,33.568801);
                    var receipt = new BMap.Point(parseFloat(receiptCoordinate_l),parseFloat(receiptCoordinate_r));    //终点-北京
                    map.clearOverlays();                        //清除地图上所有的覆盖物
                    var driving = new BMap.DrivingRoute(map);    //创建驾车实例
                    driving.search(sender, current);                 //第一个驾车搜索
                    driving.search(current, receipt);                 //第二个驾车搜索
                    driving.setSearchCompleteCallback(function(){
                        var pts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组

                        var polyline = new BMap.Polyline(pts);

                        map.addOverlay(polyline);
                        var senderMarker = new BMap.Marker(sender);         //创建3个marker
                        var currentMarker = new BMap.Marker(current,{icon:myIcon});
                        var receiptMarker = new BMap.Marker(receipt);
                        map.addOverlay(senderMarker);
                        map.addOverlay(currentMarker);
                        map.addOverlay(receiptMarker);
                        var lab1 = new BMap.Label("起点",{position:sender});        //创建3个label
                        var lab2 = new BMap.Label("当前",{position:current});
                        var lab3 = new BMap.Label("终点",{position:receipt});
                        map.addOverlay(lab1);
                        map.addOverlay(lab2);
                        map.addOverlay(lab3);
                        setTimeout(function(){
                            map.setViewport([sender,current,receipt]);          //调整到最佳视野
                        },1000);
                    });

                    var driving2 = new BMap.DrivingRoute(map);
                    driving2.search(sender, current);                 //第一个驾车搜索

                    driving2.setSearchCompleteCallback(function(){

                        var pts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组

                        var polyline = new BMap.Polyline(pts,{
                            strokeWeight:'8',//折线的宽度，以像素为单位
                            strokeOpacity: 0.8,//折线的透明度，取值范围0 - 1
                            strokeColor:"#18a45b" //折线颜色
                        });

                        map.addOverlay(polyline);
                        var senderMarker = new BMap.Marker(sender);         //创建2个marker
                        var currentMarker = new BMap.Marker(current,{icon:myIcon});

                        map.addOverlay(senderMarker);
                        map.addOverlay(currentMarker);

                        //创建3个label
                        var lab1 = new BMap.Label("起点",{position:sender});
                        var lab2 = new BMap.Label("当前",{position:current});
                        map.addOverlay(lab1);
                        map.addOverlay(lab2);

                        setTimeout(function(){
                            map.setViewport([sender,current]);          //调整到最佳视野
                        },1000);
                    });
                }
            })
        })

    })



</script>
</html>
