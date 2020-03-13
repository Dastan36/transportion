<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/14
  Time: 14:59
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
    <style>
        .railway_list {
            padding: 30px 25px;
            height: 1%;
            min-height: 20px;
            border-bottom: 1px solid #E8E8E8;
            position: relative;
        }

        .w1, .w2, .w3, .w4 {
            float: left;
            padding-top: 5px;
        }

        .w1 {
            width: 15%;
        }

        .w2 {
            width: 16%;
            text-align: center;
        }

        .railway_list .w4 {
            position: relative;
        }

        .w4 {
            width: 30%;
            text-align: center;
            margin: 0 -1%;
        }

        .w3 {
            width: 14%;
            text-align: center;
        }

        .w5 {
            position: absolute;
            right: 136px;
        }
        .w6 {
            position: absolute;
            right: 10px;
        }

        .shi_icon {
            color: #2577e3;
        }

        .shi_icon, .zhong_icon, .guo_icon {
            display: inline-block;
            vertical-align: middle;
            width: 14px;
            height: 14px;
            line-height: 14px;
            text-align: center;
            border: 1px solid #e0e0e0;
            font-size: 12px;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            border-radius: 4px;
            margin-top: -3px;
        }

        i, em {
            font-style: normal;
        }

        .railway_list .w4 .haoshi {
            padding-top: 0px;
            font-size: 12px;
        }

        .railway_list .w4 .line {
            width: 124px;
            height: 6px;
            background: url(https://pic.c-ctrip.com/train/railway_v3/un_list.png) no-repeat;
            position: absolute;
            top: 20px;
            left: 50%;
            margin-left: -62px;
        }

        .zhong_icon {
            color: #ff9913;
        }

        .zhuan_icon {
            color: #117700;
        }

        .shi_icon, .zhong_icon, .zhuan_icon {
            display: inline-block;
            vertical-align: middle;
            width: 14px;
            height: 14px;
            line-height: 14px;
            text-align: center;
            border: 1px solid #e0e0e0;
            font-size: 12px;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            border-radius: 4px;
            margin-top: -3px;
        }
        span.goodsWeight{
            position:absolute;
            top:8px;
            right: 18px;
        }
        span.goodsVolume{
            position:absolute;
            top:8px;
            right: 18px;
        }
    </style>
</head>
<body style="background-color: #f2f2f2;overflow-x:auto; overflow-y:hidden;height: 100%">
<div class="layui-layout layui-layout-admin">
    <div id="content" style="margin: 0 100px 0 100px;padding: 40px;background-color: #ffffff;">
        <form class="layui-form ordForm">
            <input type="hidden" name="orderId" value="${order.orderId}"/>
            <input type="hidden" name="createTime" value="${order.createTime}">
            <div class="layui-form-item">
                <h2>发收货信息</h2>
                <br><br>
                <label class="layui-form-label">发货人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="senderName" value="${order.senderName}" disabled autocomplete="off"
                           class="layui-input">
                </div>
                <label class="layui-form-label">收货人姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="receiptName" value="${order.receiptName}" disabled autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="senderPhone" value="${order.senderPhone}" disabled autocomplete="off"
                           class="layui-input">
                </div>
                <label class="layui-form-label">联系电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="receiptPhone" value="${order.receiptPhone}" disabled autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">寄货地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="senderStation" name="senderStation" value="${order.senderStation}" disabled
                           autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label">收货地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="receiptStation" name="receiptStation" value="${order.receiptStation}"
                           disabled autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <h2>托运货物信息</h2>
                <br><br>
                <label class="layui-form-label">货物名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="goodsName" value="${order.goodsName}" disabled autocomplete="off"
                           class="layui-input">
                </div>
                <label class="layui-form-label">重量</label>
                <div class="layui-input-inline">
                    <input type="text" id="goodsWeight" name="goodsWeight" value="${order.goodsWeight}" disabled
                           autocomplete="off"
                           class="layui-input">
                    <span class="goodsWeight">t</span>
                </div>
                <label class="layui-form-label">体积</label>
                <div class="layui-input-inline">
                    <input type="text" id="goodsVolume" name="goodsVolume" value="${order.goodsVolume}" disabled
                           autocomplete="off"
                           class="layui-input">
                    <span class="goodsVolume">m³</span>
                </div>
            </div>

            <div class="layui-form-item">
                <h2>其它</h2>
                <br>
                <label class="layui-form-label">运货日期</label>
                <div class="layui-input-inline">
                    <input id="transTime" type="text" name="transTime"
                           value="<fmt:formatDate value='${order.transTime}' pattern='yyyy-MM-dd' />" disabled
                           lay-verify="required" class="layui-input">
                </div>
                <label class="layui-form-label">运输状态</label>
                <div class="layui-input-inline">
                    <select name="status" lay-verify="">
                        <option value="运输中"
                                <c:if test="${order.status eq '运输中'}">selected</c:if> >运输中
                        </option>
                        <option value="等待中"
                                <c:if test="${order.status eq '等待中'}">selected</c:if> >等待中
                        </option>
                        <option value="已完成"
                                <c:if test="${order.status eq '已完成'}">selected</c:if> >已完成
                        </option>
                    </select>
                </div>
                <label class="layui-form-label">领货状态</label>
                <div class="layui-input-inline">
                    <select name="getStatus" lay-verify="">
                        <option value="待领货"
                                <c:if test="${order.getStatus eq '待领货'}">selected</c:if> >待领货
                        </option>
                        <option value="已领货"
                                <c:if test="${order.getStatus eq '已领货'}">selected</c:if> >已领货
                        </option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">运货方案</label>
                <div class="layui-input-inline">
                    <input id="traId" name="traId" type="hidden"/>
                    <input id="lineMatch" type="text" name="lineMatch" value="${order.lineMatch}" readonly
                           lay-verify="required" class="layui-input">
                </div>
                <div class="layui-input-inline">
                    <button id="line" class="layui-btn" type="button" data-type="reload">
                        <i class="layui-icon" style="font-size: 20px; ">&#xe615;</i> 匹配线路列车
                    </button>
                </div>
                <label class="layui-form-label">付款状态</label>
                <div class="layui-input-inline">
                    <select name="moneyStatus" disabled lay-verify="">
                        <option value="在线支付(待支付)"
                                <c:if test="${order.getStatus eq '在线支付(待支付)'}">selected</c:if> >在线支付(待支付)
                        </option>
                        <option value="在线支付(已支付)"
                                <c:if test="${order.getStatus eq '在线支付(已支付)'}">selected</c:if> >在线支付(已支付)
                        </option>
                        <option value="到付(待支付)"
                                <c:if test="${order.getStatus eq '到付(待支付)'}">selected</c:if> >到付(待支付)
                        </option>
                        <option value="到付(已支付)"
                                <c:if test="${order.getStatus eq '到付(已支付)'}">selected</c:if> >到付(已支付)
                        </option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block" style="float: right">
                    <button class="layui-btn subBtn" type="button" lay-submit lay-filter="*">提交</button>
                </div>
            </div>
            <div id="match" style="display: none">
            </div>
        </form>

        <script>

            $(function () {
                layui.use('form', function () {
                    var form = layui.form;
                    form.render('select');
                })

                $(document).on('click', '.subBtn', function () {
                    $.ajax('order/update', {
                        type: 'POST',
                        data: $('.ordForm').serialize(),  //整个表单的内容
                        dataType: 'json',
                        async: false,//默认为true异步
                        success: function (data) {
                            if (data) {
                                loadPage('order/tolist');
                            }
                        }
                    })
                })

                var line;
                $(document).on('click', '#line', function () {
                    var senderStation = $("#senderStation").val();
                    var receiptStation = $("#receiptStation").val();
                    var goodsWeight = $("#goodsWeight").val();
                    var goodsVolume = $("#goodsWeight").val();
                    //alert(senderStation+receiptStation);
                    $.ajax('line/match', {
                        type: 'post', //提交方法
                        data: {
                            'senderStation': senderStation,
                            'receiptStation': receiptStation,
                            'goodsWeight': goodsWeight,
                            'goodsVolume': goodsVolume
                        },//提交的参数
                        dataType: 'json',
                        success: function (data) {
                            line = data;

                            layer.open({
                                type: 1,
                                title: '匹配列车',
                                area: ['70%', '50%'], //宽高
                                content: $('#match'),
                                btn: '确认',
                                yes: function (index) {  //确认按钮回调函数
                                    $('#lineMatch').attr("value", $("input[name='linematch']:checked").val());//列车名称
                                    $('#traId').attr('value',$("input[name='linematch']:checked").attr('traId'))//获得列车id
                                    layer.close(index);
                                },
                                success: function (layero) {
                                    // 如果弹层的内容content是某个DOM元素的话，要放在body的根节点下。不能放在div里面了
                                    //这里就是在一个div中不是body根节点下  会出现遮罩层把弹出层遮住
                                    var mask = $(".layui-layer-shade");
                                    mask.appendTo(layero.parent());
                                    //其中：layero是弹层的DOM对象

                                    lineMatch(line);
                                }
                            })
                        }

                    })
                })

                function lineMatch(line) {
                    $('#match').find('div').remove();
                    $('#match').find('hr').remove();

                    if(line == null || line == '' || line == undefined){
                        $('#match').append("<div>暂无乘车数据</div>");
                    }else {
                        for (var i = 0; i < line.length; i++) {

                            if (line[i].type == "直达") {
                                $('#match').append("<div class='railway_list'>\n" +
                                    "    <div class='w1'>\n" +
                                    "        <div>" +
                                    // "            <input type='text'  hidden value='"+line[i].traId+"'>\n" +
                                    "            <input type='radio' name='linematch' traId ='"+line[i].traId+"' value='" + line[i].traName + "'>" + line[i].traName + "\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "    <div class='w2'>\n" +
                                    "        <div>\n" +
                                    "            <strong>" + getDateTime(line[i].outTime) + "</strong>\n" +
                                    "        </div>\n" +
                                    "\n" +
                                    "        <div>\n" +
                                    "            <i class='shi_icon'>始</i>\n" +
                                    "            <span>" + line[i].startStation + "</span>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "\n" +
                                    "    <div class='w4'>\n" +
                                    "        <div class='haoshi'>\n" +
                                    "            " + line[i].time + "<i class='icon-sfz'></i>\n" +
                                    "        </div>\n" +
                                    "        <div class='line'>\n" +
                                    "            <i class='shi guo'></i>\n" +
                                    "            <i class='zhong'></i>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "\n" +
                                    "    <div class='w2'>\n" +
                                    "        <div>\n" +
                                    "            <label>\n" +
                                    "                <strong>\n" +
                                    "                    " + getDateTime(line[i].inTime) + "\n" +
                                    "                </strong>\n" +
                                    "                <i>\n" +
                                    "                </i>\n" +
                                    "            </label>\n" +
                                    "        </div>\n" +
                                    "        <div>\n" +
                                    "            <i class='zhong_icon'>终</i>\n" +
                                    "            <span>" + line[i].endStation + "</span>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "    <div class='w2'>\n" +
                                    "        <div>\n" +
                                    "            <strong>剩余载重：" + line[i].weight + "t</strong>\n" +
                                    "        </div>\n" +
                                    "\n" +
                                    "        <div>\n" +
                                    "            <strong>剩余体积：" + line[i].volume + "m³</strong>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "</div>");

                            }

                            else {
                                $('#match').append("<div class='railway_list'>\n" +
                                    "    <div class='w1'>\n" +
                                    "        <div>\n" +
                                    "            <input type='radio' name='linematch' traId ='"+line[i].traId+"&"+line[i].traId2+"' value='" + line[i].traName + line[i].change2 + line[i].traName2 + "'>" + line[i].traName + "\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "    <div class='w2'>\n" +
                                    "        <div>\n" +
                                    "            <strong>" + getDateTime(line[i].outTime) + "</strong>\n" +
                                    "        </div>\n" +
                                    "\n" +
                                    "        <div>\n" +
                                    "            <i class='shi_icon'>始</i>\n" +
                                    "            <span>" + line[i].startStation + "</span>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "\n" +
                                    "    <div class='w4'>\n" +
                                    "        <div class='haoshi'>\n" +
                                    "            " + line[i].time + "<i class='icon-sfz'></i>\n" +
                                    "        </div>\n" +
                                    "        <div class='line'>\n" +
                                    "            <i class='shi guo'></i>\n" +
                                    "            <i class='zhong'></i>\n" +
                                    "        </div>\n" +
                                    "        <div class=''>\n" +
                                    "            <i class='zhuan_icon'>转</i>\n" +
                                    "            " + line[i].change + "<i class='icon-sfz'></i>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "\n" +
                                    "    <div class='w3'>\n" +
                                    "        <div>\n" +
                                    "            <label>\n" +
                                    "                <strong>\n" +
                                    "                    " + getDateTime(line[i].inTime) + "\n" +
                                    "                </strong>\n" +
                                    "                <i>\n" +
                                    "                </i>\n" +
                                    "            </label>\n" +
                                    "        </div>\n" +
                                    "        <div>\n" +
                                    "            <i class='zhong_icon'>终</i>\n" +
                                    "            <span>" + line[i].endStation + "</span>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "    <div class='w1'>\n" +
                                    "        <div>\n" +
                                    "            " + line[i].traName2 + "\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +
                                    "    <div class='w5'>\n" +
                                    "        <div>\n" +
                                    "            <strong>剩余载重：" + line[i].weight1 + "t</strong>\n" +
                                    "        </div>\n" +
                                    "\n" +
                                    "        <div>\n" +
                                    "            <strong>剩余体积：" + line[i].volume1 + "m³</strong>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +"    <div class='w6'>\n" +
                                    "        <div>\n" +
                                    "            <strong>剩余载重：" + line[i].weight2 + "t</strong>\n" +
                                    "        </div>\n" +
                                    "\n" +
                                    "        <div>\n" +
                                    "            <strong>剩余体积：" + line[i].volume2 + "m³</strong>\n" +
                                    "        </div>\n" +
                                    "    </div>\n" +

                                    "</div>");

                            }
                        }
                    }

                    layui.use('form', function () {
                        var form = layui.form;
                        form.render('radio');
                    })

                }
            })

            /* ajax日期时间格式转换*/

            function getDateTime(date) {
                var date = new Date(parseInt(date, 10));

                var year = date.getFullYear();

                var month = date.getMonth() + 1;

                var day = date.getDate();

                var hh = date.getHours();

                var mm = date.getMinutes();

                var ss = date.getSeconds();

                return hh + ":" + mm;
            }

        </script>

    </div>
</div>
</body>
</html>
