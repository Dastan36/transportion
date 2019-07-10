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
    <script>
        $(function () {

            $('.create').click(function () {
                layui.use(['form', 'layer'], function () {
                    var form = layui.form;
                    form.render();
                    var layer = layui.layer;
                    layer.open({
                        type: 2   //iframe层
                        , content: ['user/toadd', 'no']  //这里content是一个URL，如果你不想让iframe出现滚动条 加 no
                        , title: '添加用户'
                        , area: ['600px', '400px']            //宽高
                        , btn: ['添加', '关闭']
                        , offset:'c'
                        , yes: function (index, layero) { //当前层索引、当前层DOM对象
                            var form = layer.getChildFrame('form', index);//得到弹出框中页面的body
                            //var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                            //console.log(body.html()) //得到iframe页的body内容
                            form.find('.createBtn').click();
                        }
                        , btn2: function (index, layero) {
                            layer.close(index);
                        }
                    })
                })
            })
            $(document).on('click','.updateBtn',function () {
                var userId = $(this).attr('userId');
                layui.use(['form', 'layer'], function () {
                    var form = layui.form;
                    form.render();
                    var layer = layui.layer;
                    layer.open({
                        type: 2   //iframe层
                        , content: ['user/toupdate?userId=' + userId, 'no']  //这里content是一个URL，如果你不想让iframe出现滚动条 加 no
                        , title: '修改用户'
                        , area: ['600px', '350px']            //宽高
                        , btn: ['修改', '关闭']
                        ,offset:'c'
                        , yes: function (index, layero) { //当前层索引、当前层DOM对象
                            var form = layer.getChildFrame('form', index);//得到弹出框中页面的body
                            //var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                            //console.log(body.html()) //得到iframe页的body内容
                            form.find('.update').click();
                        }
                        , btn2: function (index, layero) {
                            layer.close(index);
                        }
                    })
                })
            })


            $(document).on('click','.delBtn',function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('delId');
                //alert("要删除的ID："+id);
                del(id,this);//真正删除的 逻辑
            });

            function del(id,obj) {

                    layer.confirm('确认删除？', {
                        btn: ['确定', '取消'] //按钮
                        ,offset:'c'
                    }, function () {
                        $.ajax('user/delete', {           //url      $.ajax(url,options)
                            type: "post",                         //提交方法
                            data: {"userId": id},                //提交的参数
                            dataType: 'json',                     //接受到信息如何处理
                            success: function (data) {
                                if (data && data.success) {//success 状态为4  http200

                                        layer.msg('删除成功', {
                                            icon: 1
                                            ,time:1000
                                        },function () {
                                            //window.location.href = 'user/tolist';
                                            //loadPage('user/tolist')  删除完直接重新加载页面
                                            //数据库删除成功后 直接删除此表格行  注意node 个数
                                            var i=obj.parentNode.parentNode.parentNode.rowIndex;
                                            console.log(obj);
                                            document.getElementById('userTable').deleteRow(i)
                                        });


                                } else {

                                        layer.msg('删除失败', {
                                            icon: 2
                                            ,time:1000
                                        });

                                }
                            }

                    }, function () {
                        layer.msg('取消操作', {
                            time: 1000, //20s后自动关闭
                        });
                    });
                })
            }

        })


    </script>
</head>
<body>


<form class="layui-form searchForm">
    <div class="layui-input-inline">
        <input id="searchName" type="text" name="userName" autocomplete="off"
               placeholder="用户名" class="layui-input">
    </div>
    <div class="layui-input-inline">
        <input id="searchPhone" type="text" name="telephone" autocomplete="off"
               placeholder="联系电话"   class="layui-input">
    </div>

</form>
    <hr>
<table id="userTable" class="layui-table">
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
            <button  class="layui-btn layui-btn-sm create">
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
                    <button class="layui-btn layui-btn-sm updateBtn" userId=${user.userId}>
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
<div id="page" align="center"></div>
<script>
    var defaultPage;
    var count;
    $(function () {
        defaultPage = 1;
        count = query(defaultPage);//查出数据
        page(count,defaultPage);//layui分页

        //监听表单提交
        layui.use(['form', 'layer'], function () {
            var form = layui.form;
            form.render();
            form.on('submit(*)',function (data) {
                //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
                //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
                //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
                //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
                //alert(count)
                count = query(1);//根据搜索内容  查出新的数据条数  在分页
                page(count,defaultPage);//layui分页
                return false;//阻止表单跳转
            })
        })

        $(document).on('input','#searchName',function () {
            var name = $('#searchName').val();
            //alert(name);
            count = query(1);//根据搜索内容  查出新的数据条数  在分页
            page(count,defaultPage);//layui分页
        })

        $(document).on('input','#searchPhone',function () {
            var name = $('#searchName').val();
            //alert(name);
            count = query(1);//根据搜索内容  查出新的数据条数  在分页
            page(count,defaultPage);//layui分页
        })
    })

    //layui 的 分页
    function page(count,defaultPage) {
        layui.use('laypage', function() {
            //alert("laypage"+pageCount)
            var laypage = layui.laypage;
            laypage.render({
                elem: 'page',
                count: count, //总条数
                limit: 9,//每页条数  和后台控制条数的数据一样 为了简便一些没有用传参的方式
                layout: ['prev', 'page', 'next', 'skip'],
                curr: defaultPage,  //当前页码
                theme: '#00A0E9',
                jump:function(obj,first) {//回调该展示数据的方法,数据展示
                    if (!first) {
                        //第一次不执行,一定要记住,这个必须有,要不然就是死循环

                        //console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                        //console.log(obj.limit); //得到每页显示的条数

                        // 更改存储变量容器中的数据,是之随之更新数据
                        defaultPage = obj.curr;
                        count = query(defaultPage);
                    }
                }
            })
        })
    }

    //
    function query(page){
        var pageCount;  //总条数

        $("table tr").each(function(index,tr){
            if(index>0){
                $(tr).remove();
            }
        });
        $.ajax('user/userlist?pageNum='+page,{
            type:'post',
            cache:false,
            data:$('.searchForm').serialize(),
            dataType:'json',
            async: false,
            success:function(data){
                pageCount =  data.pageCount;
                $(data.userList).each(function(index,data){
                    //console.info(data.createTime);
                    var createTime = getDateTime(data.createTime);

                    $("tbody").append(" <tr>\n" +
                        "\n" +
                        "        <td>"+(index+1)+"</td>\n" +
                        "        <td>"+data.userName+"</td>\n" +
                        "        <td>"+data.password+"</td>\n" +
                        "        <td>"+data.telephone+"</td>\n" +
                        "        <td>"+createTime+"</td>\n" +
                        "        <td>"+data.status+"</td>\n" +
                        "        <td><div class=\"layui-btn-group\">\n" +
                        "                    <button class=\"layui-btn layui-btn-sm updateBtn\" userId=\""+data.userId+"\">\n" +
                        "                        <i class=\"layui-icon\">&#xe642;</i>\n" +
                        "                    </button>\n" +
                        "                    <button class=\"layui-btn layui-btn-sm delBtn\" delId=\""+data.userId+"\">\n" +
                        "                        <i class=\"layui-icon\">&#xe640;</i>\n" +
                        "                    </button>\n" +
                        "                </div></td>\n" +
                        "    </tr>")
                });
            }
        });
        return pageCount;
    }

    /* ajax日期时间格式转换*/

    function getDateTime(date) {
        var date = new Date(parseInt(date, 10));

        var year = date.getFullYear();

        var month = date.getMonth() + 1;

        var day = date.getDate();

        var hh = date.getHours();

        var mm = date.getMinutes();

        var ss = date.getSeconds();

        return year + "-" + month + "-" + day + " " + hh + ":" + mm + ":" + ss;
    }

</script>
</body>
</html>
