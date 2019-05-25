
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

</head>
<body style="background-color: #f2f2f2">
<div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <div class="layui-logo"><a href='index'><span style="color: #FFFFFF">铁路货运</span></a></div>
            <ul class="layui-nav layui-layout-right">
                <li class="layui-nav-item">
                    <c:choose>
                        <c:when test="${userName!=null}">
                            <a >${userName}</a>
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
        <form class="layui-form" action="ali/toindex">
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
                    <select name="city" required lay-verify="required" lay-filter="city1">
                        <option value="">请选择城市</option>
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
                    <select name="city2" required lay-verify="reqired" lay-filter="city2">
                        <option value="">请选择城市</option>
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
                    <input type="text" name="goodsName" placeholder="例：煤、石油、金矿" required lay-verify="required" autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">重量</label>
                <div class="layui-input-inline">
                    <input id="goodsWeight" type="text" name="goodsWeight" onkeyup="sum(this);" placeholder="请输入重量(kg)" required lay-verify="number" autocomplete="off" class="layui-input" >
                </div>
                <label class="layui-form-label">体积</label>
                <div class="layui-input-inline">
                    <input id="goodsVolume" type="text" name="goodsVolume" placeholder="请输入体积(m³)" required lay-verify="number" autocomplete="off" class="layui-input" >
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
                    <input id="money" type="text" name="money"  value="" readonly autocomplete="off" required lay-verify="number" class="layui-input" >
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
                    <button class="layui-btn <c:if test="${userName eq null}">layui-btn-disabled</c:if>" lay-submit lay-filter="formDemo" <c:if test="${userName eq null}"> disabled </c:if> >马上下单</button>
                </div>
            </div>
        </form>
        <div id="allMap" style="display: none"></div>
        <script>

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
                        var money = goodsWeight * 10 + goodsVolume * 100 + distance / 10000 * 20;
                        $('#money').attr('value', money.toFixed(0));
                    }
                })


                //注意：导航 依赖 element 模块，否则无法进行功能性操作
                layui.use(['element', 'form', 'laydate'], function () {
                    var element = layui.element;
                    //表单
                    var form = layui.form;
                    form.render();
                    //二级联动城市1
                    form.on('select(city1)', function (data) {
                        city1 = data.value;

                        form.render();
                        if (city1 != city2) {   //限制两个城市不能一样
                            //alert(data.value);
                            $("#senderStation").find("option").remove();
                            option1(city1);
                        }else{
                            $("#senderStation").find("option").remove();
                            form.render();
                        }
                    });
                    //二级联动城市2
                    form.on('select(city2)', function (data) {
                        city2 = data.value;

                        if (city2 != city1) {
                            $("#receiptStation").find("option").remove();
                            option2(city2);
                        }else{
                            $("#receiptStation").find("option").remove();
                            form.render();
                        }
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
                                var money = goodsWeight * 10 + goodsVolume * 100 + distance / 10000 * 20;
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