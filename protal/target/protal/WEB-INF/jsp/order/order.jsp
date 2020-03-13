
<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/6
  Time: 11:55
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
    <title>在线下单</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=PlhFWpA02aoURjAOpnWcRGqw7AI8EEyO"></script>

    <style>
        input.unit{
            padding-right: 40px;
        }
        span.unit{
            position:absolute;
            top:8px;
            right: 18px;
        }
        input.goodsWeight{
            padding-right: 40px;
        }
        span.goodsWeight{
            position:absolute;
            top:8px;
            right: 18px;
        }
        input.goodsVolume{
            padding-right: 40px;
        }
        span.goodsVolume{
            position:absolute;
            top:8px;
            right: 18px;
        }
    </style>
</head>
<body style="background-color: #f2f2f2">
<div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <div class="layui-logo"><a href='index'><span style="color: #FFFFFF">铁路货运</span></a></div>
            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item">
                    <c:choose>
                        <c:when test="${user.userName!=null}">
                            <a style="cursor:pointer">${user.userName}</a>
                            <dl class="layui-nav-child">
                                <dd><a href="center" target="_self">会员中心</a></dd>
                                <dd><a href="javascript:;">退出</a></dd>
                            </dl>
                        </c:when>
                        <c:otherwise>
                            <a href="touserlogin">更多操作请登录</a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>

    <div id="content" style="margin: 0 250px 0 250px;padding: 20px;background-color: #ffffff;">
        <%--action="ali/toindex"--%>
        <form class="layui-form orderForm" >
            <div class="layui-form-item">
                <h2>发收货信息</h2>
                <br><br>
                <label class="layui-form-label">发货人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="senderName" placeholder="请输入发货人姓名" required lay-verify="required" autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">收货人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="receiptName" placeholder="请输入收货人姓名" required lay-verify="required" autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="senderPhone" placeholder="请输入联系电话" required lay-verify="phone" autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="receiptPhone" placeholder="请输入联系电话" required lay-verify="phone" autocomplete="off" class="layui-input" >
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">寄货地址</label>
                <div class="layui-input-inline">
                    <select name="senderProvince" required lay-verify="required" lay-filter="province1">
                        <option value="">请选择省,直辖市,自治区</option>
                        <c:forEach items="${provinceList}" var="province" varStatus="status">
                            <option value="${province.province}">${province.province}</option>
                        </c:forEach>
                    </select>
                    <select id="city1" name="city" required lay-verify="required" lay-filter="city1">
                        <option value="">请选择市,县</option>
                        <c:forEach items="${cityList}" var="city" varStatus="status">
                            <option value="${city.city}" name="city">${city.city}</option>
                        </c:forEach>
                    </select>
                    <select id="senderStation" name="senderStation" required lay-verify="required" lay-filter="senderStation">
                        <option value="">请选择车站</option>
                    </select>

                </div>
                <label class="layui-form-label">收货地址</label>
                <div class="layui-input-inline">
                    <select name="receiptProvince" required lay-verify="required" lay-filter="province2">
                        <option value="">请选择省,直辖市,自治区</option>
                        <c:forEach items="${provinceList}" var="province" varStatus="status">
                            <option value="${province.province}">${province.province}</option>
                        </c:forEach>
                    </select>
                    <select id="city2" name="city2" required lay-verify="required" lay-filter="city2">
                        <option value="">请选择市,县</option>
                        <c:forEach items="${cityList}" var="city" varStatus="status">
                            <option value="${city.city}" name="city">${city.city}</option>
                        </c:forEach>
                    </select>
                    <select id="receiptStation" name="receiptStation" required lay-verify="required" lay-filter="receiptStation">
                        <option value="">请选择车站</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <h2>托运货物信息</h2>
                <br><br>
                <label class="layui-form-label">货物名称</label>
                <div class="layui-input-inline">
                    <%--<input type="text" name="goodsName" placeholder="例：煤、石油、金矿" required lay-verify="required" autocomplete="off" class="layui-input" >--%>
                    <select id="goodsName" name="goodsName" required lay-verify="required">
                        <option value=""></option>
                        <option value="煤"></option>
                        <option value="石油"></option>
                        <option value="非矿"></option>
                        <option value="金矿"></option>
                        <option value="焦炭"></option>
                        <option value="氧化铝"></option>
                        <option value="磷矿"></option>
                    </select>
                </div>
                <label class="layui-form-label">重量</label>
                <div class="layui-input-inline">
                    <input id="goodsWeight" type="text" name="goodsWeight" onkeyup="sum(this);" placeholder="请输入重量(t)"  lay-verify="number" lay-verType="msg" autocomplete="off" class="layui-input goodsWeight" >
                    <span class="goodsWeight">t</span>
                </div>
                <label class="layui-form-label">体积</label>
                <div class="layui-input-inline">
                    <input id="goodsVolume" type="text" name="goodsVolume" placeholder="请输入体积(m³)"  lay-verify="number" lay-verType="msg" autocomplete="off" class="layui-input goodsVolume" >
                    <span class="goodsVolume">m³</span>
                </div>
            </div>

            <div class="layui-form-item">
                <h2>预估总价</h2>
                <br>
                <label class="layui-form-label">运货日期</label>
                <div class="layui-input-inline">
                    <input id="transTime" type="text" name="transTime"  required lay-verify="required"  class="layui-input" >
                </div>
                <label class="layui-form-label">总价</label>
                <div class="layui-input-inline">
                    <input id="money" type="text" name="money"  value="" readonly autocomplete="off"  lay-verify="number" class="layui-input unit" >
                    <span class="unit">元</span>
                    <%--<button id="yugu" type="button"  autocomplete="off" class="layui-btn" >预估</button>--%>
                </div>
                <label class="layui-form-label">付款方式</label>
                <div class="layui-input-inline">
                    <select id="moneyStatus" name="moneyStatus">
                        <option value="在线支付">在线支付</option>
                        <option value="到付">到付</option>
                    </select>
                </div>

            </div>

            <div class="layui-form-item">
                <div class="layui-input-block" style="float: right">
                    <%--class 中的是控制禁用样式  另一个是控制点击禁用事件--%>
                    <button class="layui-btn <c:if test="${user.userName eq null}">layui-btn-disabled</c:if>" lay-submit lay-filter="*" <c:if test="${user.userName eq null}"> disabled </c:if> >马上下单</button>
                </div>
            </div>
        </form>
        <div id="allMap" style="display: none"></div>
        <script>

            $(function(){
                //alert("asd");
                layui.use('form',function() {
                    var form = layui.form;
                    form.render();
                    form.render('select');
                    form.on('submit(*)', function (data) {
                        //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                        //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                        //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                        //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                        //alert("asd");
                        var ss = $("#senderStation option:selected").val();
                        var rs = $("#receiptStation option:selected").val();
                        var sp = $('#senderPhone').val();
                        var rp = $('#receiptPhone').val();
                        if (ss == rs){
                            layui.use(['layer'],function () {
                                var layer = layui.layer;
                                layer.msg('收发车站不能一样');
                            })
                        }else if (sp == rp){
                            layui.use(['layer'],function () {
                                var layer = layui.layer;
                                layer.msg('收发联系方式不能一样');
                            })
                        }else if (ss == null || ss == undefined || ss == '请选择'){
                            layui.use(['layer'],function () {
                                var layer = layui.layer;
                                layer.msg('收发车站不能为空', {icon: 5});
                            })
                        }else if (rs == null || rs == undefined || rs == '请选择'){
                            layui.use(['layer'],function () {
                                var layer = layui.layer;
                                layer.msg('收发车站不能为空', {icon: 5});
                            })
                        }else{
                            $.ajax('ali/toindex', {
                                type: 'POST',
                                data: $('.orderForm').serialize(),
                                dataType: 'json',
                                async: false,//默认为true异步
                                success: function (data) {
                                    //跳页面传值过去  jquery.query插件 接收值

                                    if (data.pay == 0) {           //到付 直接返回订单列表
                                        var url = "order/tolist";
                                        window.location.href="center?url="+url;
                                        //window.location.href="order/tolist";
                                    }else{                          //在线付
                                        //alert(data.pay);
                                        var url= "ali/topay?orderId=";
                                        //alert(url)
                                        window.location.href="center?url="+url+"&orderId="+data.pay+"";
                                    }
                                }
                            })
                        }

                        return false;//阻止表单跳转
                    })
                })
            })

            $(function() {
                var city1;
                var city2;
                var senderStation;
                var receiptStation;
                var distance;
                var goodsWeight;
                var goodsVolume;

                $(document).on('keyup', "#goodsWeight ,#goodsVolume", function () {

                    goodsWeight = $('#goodsWeight').val();
                    goodsVolume = $('#goodsVolume').val();

                    if (distance != '' && goodsWeight != '' && goodsVolume != '') {
                        var money = goodsWeight * 1000 + goodsVolume * 100 + distance / 10000 * 20;
                        $('#money').attr('value', money.toFixed(0));
                    }
                })


                //注意：导航 依赖 element 模块，否则无法进行功能性操作
                layui.use(['element', 'form', 'laydate'], function () {
                    var element = layui.element;
                    //表单
                    var form = layui.form;
                    form.render();
                    //三级联动省份1
                    form.on('select(province1)', function (data) {
                        province1 = data.value;
                        //alert(data.value);
                        $("#city1").find("option").remove();
                        $("#senderStation").find("option").remove();
                        provinceOption1(province1);
                        form.render();

                    });
                    //三级联动省份2
                    form.on('select(province2)', function (data) {
                        province2 = data.value;
                        //alert(data.value);
                        $("#city2").find("option").remove();
                        $("#receiptStation").find("option").remove();
                        provinceOption2(province2);
                        form.render();

                    });


                    //二级联动城市1
                    form.on('select(city1)', function (data) {
                        city1 = data.value;

                        $("#senderStation").find("option").remove();
                        option1(city1);
                        form.render();
                    });
                    //二级联动城市2
                    form.on('select(city2)', function (data) {
                        city2 = data.value;

                        $("#receiptStation").find("option").remove();
                        option2(city2);
                        form.render();
                    });

                    form.on('select(senderStation)',function (data) {
                        senderStation = data.value;
                        dis(senderStation,receiptStation);
                    })

                    form.on('select(receiptStation)',function (data) {
                        receiptStation = data.value;
                        dis(senderStation,receiptStation);
                    })


                    //日期控件
                    var laydate = layui.laydate;
                    laydate.render({
                        elem: '#transTime' //指定元素
                        , min: 0   //当前日期之前不能选
                        , type: 'date'
                        , done: function (value, date, endDate) {
                            console.log(value); //得到日期生成的值，如：2017-08-18

                            //console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
                            //console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
                        }

                    });
                })

                function provinceOption1(province) {
                    //alert(city);
                    $.ajax('order/provincecity', {
                        type: 'post',                         //提交方法
                        data: {'province': province},                //提交的参数
                        dataType: 'json',                     //接受到信息如何处理
                        success: function (data) {
                            var cityList = eval(data.cityList);
                            $("#city1").find("option").remove();
                            //alert(cityList.length);
                            for (var i = 0; i < cityList.length; i++) {
                                // var option = document.createElement("option");
                                //alert(stationList[i].stationName);
                                // $(option).attr("value",stationList[i].staitonName);
                                // $(option).attr("text",stationList[i].staitonName);staitonName
                                $('#city1').append("<option value='请选择'></option><option value='" + cityList[i].city + "' name='senderStatioin'>" + cityList[i].city + "</option>");
                            }
                            layui.use('form', function () {
                                var form = layui.form;
                                form.render();
                            });
                        }
                    })
                }

                function provinceOption2(province) {
                    //alert(city);
                    $.ajax('order/provincecity', {
                        type: 'post',                         //提交方法
                        data: {'province': province},                //提交的参数
                        dataType: 'json',                     //接受到信息如何处理
                        success: function (data) {
                            var cityList = eval(data.cityList);
                            $("#city2").find("option").remove();
                            //alert(cityList.length);
                            for (var i = 0; i < cityList.length; i++) {
                                // var option = document.createElement("option");
                                //alert(stationList[i].stationName);
                                // $(option).attr("value",stationList[i].staitonName);
                                // $(option).attr("text",stationList[i].staitonName);staitonName
                                $('#city2').append("<option value='请选择'></option><option value='" + cityList[i].city + "' name='senderStatioin'>" + cityList[i].city + "</option>");
                            }
                            layui.use('form', function () {
                                var form = layui.form;
                                form.render();
                            });
                        }
                    })
                }


                function option1(city) {
                    //alert(city);
                    $.ajax('order/citystation', {
                        type: 'post',                         //提交方法
                        data: {'city': city},                //提交的参数
                        dataType: 'json',                     //接受到信息如何处理
                        success: function (data) {
                            var stationList = eval(data.stationList);
                            $("#senderStation").find("option").remove();
                            //alert(stationList.length);
                            for (var i = 0; i < stationList.length; i++) {
                                // var option = document.createElement("option");
                                //alert(stationList[i].stationName);
                                // $(option).attr("value",stationList[i].staitonName);
                                // $(option).attr("text",stationList[i].staitonName);staitonName
                                $('#senderStation').append("<option value='请选择'></option><option value='" + stationList[i].stationName + "' name='senderStatioin'>" + stationList[i].stationName + "</option>");
                            }
                            layui.use('form', function () {
                                var form = layui.form;
                                form.render();
                            });
                        }
                    })
                }

                function option2(city) {
                    //alert(city);
                    $.ajax('order/citystation', {
                        type: 'post',                         //提交方法
                        data: {'city': city},                //提交的参数
                        dataType: 'json',                     //接受到信息如何处理
                        success: function (data) {
                            var stationList = eval(data.stationList);
                            //alert(stationList.length);
                            $("#receiptStation").find("option").remove();
                            for (var i = 0; i < stationList.length; i++) {
                                // var option = document.createElement("option");
                                //alert(stationList[i].stationName);
                                // $(option).attr("value",stationList[i].staitonName);
                                // $(option).attr("text",stationList[i].staitonName);staitonName

                                $('#receiptStation').append("<option value='请选择'></option><option value='" + stationList[i].stationName + "' name='receiptStatioin'>" + stationList[i].stationName + "</option>");
                            }
                            layui.use('form', function () {
                                var form = layui.form;
                                form.render();
                            });
                        }
                    })
                }
                function dis(senderStation,receiptStation){
                    $.ajax('order/selectCoordinate', {
                        type: 'POST',
                        data: {
                            'senderStationName': senderStation,
                            'receiptStationName': receiptStation
                        },
                        dataType: 'json',
                        success: function (data) {
                            var stationList = eval(data.stationList);
                            //alert(stationList[0].coordinate_l);
                            var bMap = new BMap.Map('allMap');
                            var point1 = new BMap.Point(parseFloat(stationList[0].coordinate_l), parseFloat(stationList[0].coordinate_r));
                            var point2 = new BMap.Point(parseFloat(stationList[1].coordinate_l), parseFloat(stationList[1].coordinate_r));
                            distance = bMap.getDistance(point1, point2);
                            if (distance != '' && goodsWeight != '' && goodsWeight != null && goodsVolume != '' && goodsVolume != null) {
                                var money = goodsWeight * 1000 + goodsVolume * 100 + distance / 10000 * 20;
                                $('#money').attr('value', money.toFixed(0));
                            }
                        }
                    })
                }
            })
        </script>
    </div>
</div>
</body>
</html>