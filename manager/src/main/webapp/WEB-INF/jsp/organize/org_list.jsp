<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/15 0015
  Time: 上午 8:59
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
    <title>机构列表</title>
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
                window.location.href = "organize/orglist?pageNum="+pageNum;
            });


            $(".delBtn").click(function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('delId');
                alert("要删除的ID："+id);
                del(id);//真正删除的 逻辑
            });

            function del(id) {
                $.ajax('organize/delete',{           //url      $.ajax(url,options)
                    type:"post",                         //提交方法
                    data:{"orgId":id},                //提交的参数
                    dataType:'json',                     //接受到信息如何处理
                    success:function(data){
                        if(data && data.success){        //success 状态为4  http200
                            alert('删除成功');
                            window.location.href = 'organize/orglist';
                        }else{
                            alert("删除失败");
                        }
                    }
                })
            }

            $('.create').click(function () {
                layui.use(['form', 'layer'], function () {
                    var form = layui.form;
                    form.render();
                    var layer = layui.layer;
                    layer.open({
                        type: 2   //iframe层
                        , content: ['organize/toadd', 'no']  //这里content是一个URL，如果你不想让iframe出现滚动条 加 no
                        , title: '添加机构'
                        , area: ['600px', '200px']            //宽高
                        , btn: ['添加', '关闭']
                        ,success:function (layero, index) {
                            lay
                        }
                        , yes: function (index, layero) { //当前层索引、当前层DOM对象
                            //使用页面的提交按钮提交
                            var body = layer.getChildFrame('body', index);//得到弹出框中页面的body
                            //var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                            //console.log(body.html()) //得到iframe页的body内容
                            body.find('.createBtn').click();
                        }
                        , btn2: function (index, layero) {
                            layer.close(index);
                        }
                    })
                })
            })
        })


    </script>
</head>
<body style="height: 100%">
<table class="layui-table" >
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>序号</th>
        <th>机构名称</th>
        <th>创建时间</th>
        <th>操作
            <button class="layui-btn layui-btn-sm create">
                <i class="layui-icon">&#xe654;</i>
            </button>
        </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${orgList}" var="org" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${org.orgName}</td>
            <td><fmt:formatDate value="${org.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm" onclick="window.location.href='organize/toupdate?orgId=${org.orgId}'">
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                    <button class="layui-btn layui-btn-sm delBtn" delId="${org.orgId}">
                        <i class="layui-icon">&#xe640;</i>
                    </button>
                </div>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div align="center">
<c:if test="${orgList.size()>0}">
    <c:choose>
        <c:when test="${pageNum == 1}">
            <button class="layui-btn">
                上一页
            </button>
        </c:when>
        <c:otherwise>
            <button class="layui-btn" onclick="window.location.href='organize/orglist?pageNum=${pageNum - 1}'">
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
            <button class="layui-btn" onclick="window.location.href='organize/orglist?pageNum=${pageNum+1}'">
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
