<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/4/25
  Time: 20:11
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
    <title>我的订单</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
    <script>
        $(function () {

            //跳转页面
            $("#toPageBtn").click(function(){

                //跳转到xxx页

                var pageNum = parseInt($("#pageNumInp").val());
                if(pageNum<=0 || pageNum> ${pageCount}){
                    alert("没有"+pageNum+"页");
                    return;
                }
                window.location.href = "order/orderlist?pageNum="+pageNum;
            });

            $(".cancelBtn").click(function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('cancelId');
                var status = $(this).attr('status');
                //alert("要取消订单的ID："+id);
                if(status == "处理中"){
                    alert("理赔处理中，无法撤销！");
                }else {
                    cancel(id);//真正删除的 逻辑
                }

            })

            function cancel(id) {

                $.ajax('compensate/cancel',{           //url      $.ajax(url,options)
                    type:"post",                         //提交方法
                    data:{"orderId":id},                //提交的参数
                    dataType:'json',                     //接受到信息如何处理
                    success:function(data){
                        if(data && data.success){        //success 状态为4  http200
                            alert('取消理赔成功');
                            window.location.href = 'compensate/compensatelist';
                        }else{
                            alert("取消理赔失败");
                        }
                    }
                })
            }
            function del(id) {

                $.ajax('order/delete',{           //url      $.ajax(url,options)
                    type:"post",                         //提交方法
                    data:{"orderId":id},                //提交的参数
                    dataType:'json',                     //接受到信息如何处理
                    success:function(data){
                        if(data && data.success){        //success 状态为4  http200
                            alert('删除订单成功');
                            window.location.href = 'order/orderlist';
                        }else{
                            alert("删除订单失败");
                        }
                    }
                })
            }

            $('.createBtu').click(function () {
                layui.use(['form','layer'],function () {
                    var form = layui.form;
                    form.render();
                    var layer = layui.layer;
                    layer.open({
                        type:2   //iframe层
                        ,content:['compensate/tocreate','no']  //这里content是一个URL，如果你不想让iframe出现滚动条 加 no
                        ,title:'理赔申请'
                        ,area: ['800px', '400px']            //宽高
                        ,btn: ['申请','关闭']
                        ,yes:function (index, layero) { //当前层索引、当前层DOM对象
                             //使用页面的提交按钮提交
                            var body = layer.getChildFrame('body', index);//得到弹出框中页面的body
                            //var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                            //console.log(body.html()) //得到iframe页的body内容
                            body.find('.btnCompensate').click();
                        }
                        ,btn2: function(index, layero){
                            layer.close(index);
                        }
                    })
                })
            })

        })
    </script>
    <style>
        table td{
            table-layout: fixed;
            white-space:nowrap;overflow:hidden;text-overflow: ellipsis;
        }
    </style>
</head>
<body style="height: 100%">
<form class="layui-form" action="order/orderlist">

    <div class="layui-input-inline" style="width: 300px">
        <input type="text" name="orderId" autocomplete="off"
               placeholder="订单号" class="layui-input">
    </div>
    <div class="layui-input-inline " style="width: 200px">
        <button class="layui-btn" type="submit" data-type="reload">
            <i class="layui-icon" style="font-size: 20px; ">&#xe615;</i> 搜索
        </button>
    </div>
    <div class="layui-input-inline " style="width: 200px">
        <button class="layui-btn createBtu" type="button" data-type="reload">
            <i class="layui-icon" style="font-size: 20px; ">&#xe654;</i>我要理赔
        </button>
    </div>
</form>
<table class="layui-table" >
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>序号</th>
        <th>订单号</th>
        <th>理赔方</th>
        <th>索赔金额</th>
        <th>理赔状态</th>
        <th>理赔时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${compensateList}" var="order" varStatus="status">
        <tr >
        <c:forEach items="${order.compensate}" var="compensate" varStatus="compensateStatus">
            <c:if test="${compensateStatus.index gt 0}">
                <tr>
            </c:if>
            <c:if test="${compensateStatus.index eq 0}">
                <td rowspan="${order.compensate.size()}">${status.count}</td>
                <td rowspan="${order.compensate.size()}">${order.orderId}</td>
            </c:if>
            <td>${compensate.compensateName}</td>
            <td>${compensate.compensateMoney}</td>
            <td>${compensate.compensateStatus}</td>
            <td><fmt:formatDate value="${compensate.compensateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm cancelBtn" cancelId="${order.orderId}" status="${compensate.compensateStatus}">
                        <i class="layui-icon">&#xe640;</i>
                    </button>
                </div>
            </td>
            <c:if test="${complaintStatus.index gt 0}">
                </tr>
            </c:if>
        </c:forEach>
        </tr>

    </c:forEach>
    </tbody>
</table>
<div align="center">
    <c:if test="${compensateList.size()>0}">
        <c:choose>
            <c:when test="${pageNum == 1}">
                <button class="layui-btn">
                    上一页
                </button>
            </c:when>
            <c:otherwise>
                <button class="layui-btn" onclick="window.location.href='compensate/compensatelist?pageNum=${pageNum - 1}&orderId=${orderId}'">
                    上一页
                </button>
            </c:otherwise>
        </c:choose>
        &nbsp;
        <c:choose>
            <c:when test="${pageNum  == pageCount}">
                <button class="layui-btn">
                    下一页
                </button>
            </c:when>
            <c:otherwise>
                <button class="layui-btn" onclick="window.location.href='compensate/compensatelist?pageNum=${pageNum+1}&orderId=${orderId}'">
                    下一页
                </button>
            </c:otherwise>
        </c:choose>
    </c:if>
    &nbsp;&nbsp;
    当前第${pageNum}页,共${pageCount}页
    &nbsp;
    跳转到<input type="text" size="3" id="pageNumInp" value="${pageNum}">
    <button id="toPageBtn" class="layui-btn" >跳转</button>
</div>
</body>
</html>
