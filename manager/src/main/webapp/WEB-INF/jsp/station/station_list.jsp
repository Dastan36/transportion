<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/27
  Time: 9:48
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
    <title>站点列表</title>
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
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
                window.location.href = "station/stationlist?pageNum="+pageNum;
            });


            $(".delBtn").click(function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('delId');
                alert("要删除的ID："+id);
                del(id);//真正删除的 逻辑
            });

        })

        function del(id) {
            $.ajax('station/delete',{           //url      $.ajax(url,options)
                type:'post',                         //提交方法
                data:{'stationId':id},                //提交的参数
                dataType:'json',                     //接受到信息如何处理
                success:function(data){
                    if(data && data.success){        //success 状态为4  http200
                        alert('删除成功');
                        window.location.href = 'station/stationlist';
                    }else{
                        alert("删除失败");
                    }
                }
            });
        }
    </script>
</head>
<body>


<form class="layui-form" action="station/stationlist">
    <div class="layui-input-inline">
        <input type="text" name="stationName" autocomplete="off"
               placeholder="站点" class="layui-input">
    </div>
    <div class="layui-input-inline " style="width: 200px">
        <button class="layui-btn" type="submit" data-type="reload">
            <i class="layui-icon" style="font-size: 20px; ">&#xe615;</i> 搜索
        </button>
    </div>
</form>
<hr>
<table class="layui-table" >
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>序号</th>
        <th>站点</th>
        <th>经度</th>
        <th>纬度</th>
        <th>城市</th>
        <th>省份</th>
        <th>操作
            <button onclick="window.location.href='station/toadd'" class="layui-btn layui-btn-sm">
                <i class="layui-icon">&#xe654;</i>
            </button>
        </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${stationList}" var="station" varStatus="status">
        <tr >
            <td>${status.count}</td>
            <td>${station.stationName}</td>
            <td>${station.coordinate_l}</td>
            <td>${station.coordinate_r}</td>
            <td>${station.city}</td>
            <td>${station.province}</td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm" onclick="window.location.href='station/toupdate?stationId=${station.stationId}'">
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                    <button class="layui-btn layui-btn-sm delBtn" delId="${station.stationId}">
                        <i class="layui-icon">&#xe640;</i>
                    </button>
                </div>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div align="center">
<c:if test="${stationList.size()>0}">
    <c:choose>
        <c:when test="${pageNum == 1}">
            <button class="layui-btn">
                上一页
            </button>
        </c:when>
        <c:otherwise>
            <button class="layui-btn" onclick="window.location.href='station/stationlist?pageNum=${pageNum - 1}'">
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
            <button class="layui-btn" onclick="window.location.href='station/stationlist?pageNum=${pageNum+1}'">
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
