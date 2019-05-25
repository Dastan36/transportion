<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/31
  Time: 19:51
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
    <title>快运班列方案细节</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=PlhFWpA02aoURjAOpnWcRGqw7AI8EEyO"></script>

</head>
<body style="height: 100%">

<div style="width: 1290px;">
    <%--<div style="width: 675px;">--%>
    <div>
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">快运班列</label>
                <div class="layui-input-inline">
                    <input type="text" value="${traName}" disabled autocomplete="off" class="layui-input" >
                </div>
            </div>
            <h3>方案</h3>
            <c:forEach items="${stationList}" var="station" varStatus="status">
                <div class="layui-form-item">
                    <label class="layui-form-label">站点</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${station.stationName}" disabled autocomplete="off" class="layui-input" >
                    </div>
                    <label class="layui-form-label">城市</label>
                    <div class="layui-input-inline">
                        <input type="text" value="${station.city}" disabled  autocomplete="off" class="layui-input" >
                    </div>
                    <label class="layui-form-label">进站时间</label>
                    <div class="layui-input-inline">
                        <input type="text" value="<fmt:formatDate value='${station.way.inTime}' pattern="HH:mm:ss"/>" disabled  autocomplete="off" class="layui-input" >
                    </div>
                    <label class="layui-form-label">发车时间</label>
                    <div class="layui-input-inline">
                        <input type="text"  value="<fmt:formatDate value='${station.way.outTime}' pattern="HH:mm:ss"/>" disabled  autocomplete="off" class="layui-input" >
                    </div>
                </div>
            </c:forEach>
        </form>

    </div>

    <%--<div id="allMap" style="border: 1px black solid;position:absolute;left:675px;top:0px;width: 650px;height: 600px;">--%>
    <div id="allMap" style="width: 100% ;height: 100%;display: none">
        <%--地图div--%>
    </div>
</div>
<%--<input type="button" class="see" traId="${traId}" value="查看"/>--%>
<button class="layui-btn see" traId="${traId}">
    <i class="layui-icon">&#xe715;</i>查看
</button>
<script type="text/javascript">

        $(function () {
            $(".see").click(function () {
                var traId = $(this).attr('traId');
                //alert(traId);
                see(traId);
            });
    })

    var stationList;

    function see(traId) {
        $.ajax('way/waydir',{
            type:'post', //提交方法
            data:{'traId':traId},//提交的参数
            dataType:'json',
            success:function(data) {
                //alert(data.stationList);
                stationList = eval(data.stationList);//转换成js对象
                //alert(stationList.length);
                layui.use('layer',function () {          //百度地图结合layui.layer  牛逼
                    var layer = layui.layer;
                    layer.open({                    //注意要设置此页面的body height
                        type: 1,
                        title:'列车线路',
                        offset: ['50px', '50px'],	//同时定义top、left坐标  定位
                        //resize:true,//不允许拉伸
                        //move: false,//禁止拖拽
                        area: ['80%', '75%'], //宽高
                        content: $('#allMap'), //这里content是一个DOM，这个元素要放在body根节点下
                        success:bdMap(stationList) //执行地图函数
                    });
                })
            }
        })

    }

    function bdMap(stationList) {

        var map = new BMap.Map("allMap");

        map.centerAndZoom(new BMap.Point(116.404, 39.915), 13);
        map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
        map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
        map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
        map.enableScrollWheelZoom(true);                            //开启鼠标滚轮缩放
        var i;
        var myP = new Array();
        var loc = new Array();
        for(i=0;i<stationList.length;i++) {
            myP[i] = new BMap.Point(parseFloat(stationList[i].coordinate_l),parseFloat(stationList[i].coordinate_r));
            //alert("new BMap.Point("+stationList[i].coordinate+")");
            loc[i] = stationList[i].stationName;
            //alert(stationList[i].stationName);
        }


            map.clearOverlays();                        //清除地图上所有的覆盖物
            var driving = new BMap.DrivingRoute(map);    //创建驾车实例
            for(i=0;i<stationList.length;i++) {
                if(i<stationList.length-1){
                    //alert(myP[i],myP[i+1]);
                    driving.search(myP[i],myP[(i+1)]);//驾车搜索
                }
            }

            driving.setSearchCompleteCallback(function(){
                //alert("asd");
                var pts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组
                var polyline = new BMap.Polyline(pts);
                map.addOverlay(polyline);
                for(i=0;i<stationList.length;i++){
                    map.addOverlay(new BMap.Marker(myP[i]));              //创建marker

                }
                for(i=0;i<stationList.length;i++){
                    map.addOverlay(new BMap.Label(loc[i],{position:myP[i]}));
                }
                setTimeout(function(){
                    map.setViewport(myP);          //调整到最佳视野
                },1000);

            });


    }



</script>
</body>
</html>

