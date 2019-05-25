<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/30
  Time: 10:12
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
    <title>快运班列方案创建</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script type="text/javascript" src="Binary/js/jquery1.9.1.js"></script>
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script type="text/javascript">
        $(function () {
            var i = 0;
            $(".addBtu").click(function(){
                $("form").append("<div class='layui-form-item' style='display:inline' >" +
                    "    <div style='display:inline'>" +
                    "<input type='hidden' name = 'addList["+i+"].way.i' value = '"+i+"'>"+       //序号
                    "  <label class='layui-form-label'>站点</label>" +
                    "        <div class='layui-input-inline'>" +
                    "   <select name='addList["+i+"].stationId' lay-verify=''>" +
                    "        <option value=''>请选择站点</option>" +
                    "            <c:forEach items='${stationList}' var='station' varStatus='status'>" +
                    "               <option value='${station.stationId}'>${station.stationName}</option>" +
                    "           </c:forEach>" +
                    "   </select>" +
                    "        </div>" +
                    "   <label class='layui-form-label'>进站时间</label>" +
                    "        <div class='layui-input-inline'>" +
                    "           <input  type='text' name='addList["+i+"].way.inTime'  required lay-verify='required'  class='layui-input inTime' >"+
                    "        </div>" +
                    "   <label class='layui-form-label'>发车时间</label>" +
                    "        <div class='layui-input-inline'>" +
                    "           <input  type='text' name='addList["+i+"].way.outTime'  required lay-verify='required'  class='layui-input outTime' >"+
                    "        </div>" +
                    "    </div>" +
                    "        <div class='remove'>" +
                    "            <input type='button' class='layui-btn' value=' - '>" +
                    "       </div>" +
                    "</div>");
                    layui.use(['form','laydate'], function(){
                        var form = layui.form;
                        form.render();
                        var laydate = layui.laydate;
                        lay('.inTime').each(function() {
                            laydate.render({
                                elem: this //指定元素
                                , type: 'time'
                                , done: function (value, date, endDate) {
                                    console.log(value); //得到日期生成的值，如：2017-08-18
                                    //console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
                                    //console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
                                }
                            });
                        });
                        lay('.outTime').each(function() {
                            laydate.render({
                                elem: this //指定元素
                                , type: 'time'
                                , done: function (value, date, endDate) {
                                    console.log(value); //得到日期生成的值，如：2017-08-18
                                    //console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
                                    //console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
                                }
                            });
                        });
                });
                i++;
            });
            $("body").on("click", ".remove", function (e) { //user click on remove text
                i--;
                $(this).parent('div').remove(); //remove text
            });
        })
    </script>

</head>
<body>

<div style="border: 0px black solid">
        <form class="layui-form" method="post" action="way/create">

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">快运班列：</label>
                <div class="layui-input-inline">
                    <select name="traId" lay-verify="">
                        <option value="">请选择快运班列</option>
                        <c:forEach items="${trainList}" var="train" varStatus="status">
                            <option value="${train.traId}" >${train.traName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="layui-form-mid layui-word-aux">站点请按顺序添加</div>
            </div>


        </form>
</div>
    <br>

    <button class="layui-btn addBtu">添加一个站点</button>

<script>
    layui.use(['element','form','laydate'], function(){
        var element = layui.element;
        var form = layui.form;
        form.render();

        //日期控件
        var laydate = layui.laydate;
        lay('.inTime').each(function() {
            laydate.render({
                elem: this //指定元素
                , type: '#asd'
                , done: function (value, date, endDate) {
                    console.log(value); //得到日期生成的值，如：2017-08-18
                    //console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
                    //console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
                }
            });
        });

    });
</script>
</body>
</html>

