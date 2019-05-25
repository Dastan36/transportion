<%--
  Created by IntelliJ IDEA.
  User: 朱桓民
  Date: 2019/3/7
  Time: 17:37
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
    <title>用户列表</title>
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
                window.location.href = "user/userlist?pageNum="+pageNum;
            });


            $(".delBtn").click(function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('delId');
                alert("要删除的ID："+id);
                del(id);//真正删除的 逻辑
            });

        })

        function del(id) {
            $.ajax('user/delete',{           //url      $.ajax(url,options)
                type:"post",                         //提交方法
                data:{"userId":id},                //提交的参数
                dataType:'json',                     //接受到信息如何处理
                success:function(data){
                    if(data && data.success){        //success 状态为4  http200
                        alert('删除成功');
                        window.location.href = 'user/userlist';
                    }else{
                        alert("删除失败");
                    }
                }
            })
        }
    </script>
</head>
<body>


<form class="layui-form" action="user/userlist">
    <div class="layui-input-inline">
        <input type="text" name="userName" autocomplete="off"
               placeholder="用户名" class="layui-input">
    </div>
    <div class="layui-input-inline">
        <input type="text" name="telephone" autocomplete="off"
               placeholder="联系电话"  lay-verify="phone" class="layui-input">
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
        <th>用户</th>
        <th>密码</th>
        <th>电话号码</th>
        <th>创建时间</th>
        <th>状态</th>
        <th>操作
            <button onclick="window.location.href='user/toadd'" class="layui-btn layui-btn-sm">
                <i class="layui-icon">&#xe654;</i>
            </button>
        </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${userList}" var="user" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${user.userName}</td>
            <td>${user.password}</td>
            <td>${user.telephone}</td>
            <td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>${user.status}</td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm" onclick="window.location.href='user/toupdate?userId=${user.userId}'">
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                    <button class="layui-btn layui-btn-sm delBtn" delId="${user.userId}">
                        <i class="layui-icon">&#xe640;</i>
                    </button>
                </div>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div align="center">
<c:if test="${userList.size()>0}">
    <c:choose>
        <c:when test="${pageNum == 1}">
            <button class="layui-btn">
                上一页
            </button>
        </c:when>
        <c:otherwise>
            <button class="layui-btn" onclick="window.location.href='user/userlist?pageNum=${pageNum - 1}&userName=${userName}&telephone=${telephone}'">
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
            <button class="layui-btn" onclick="window.location.href='user/userlist?pageNum=${pageNum+1}&userName=${userName}&telephone=${telephone}'">
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
