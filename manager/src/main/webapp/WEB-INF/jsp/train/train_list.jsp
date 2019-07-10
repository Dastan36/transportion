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
    <title>快运班列列表</title>

    <script>
        $(function () {



            $(document).on('click','.delBtn',function(){
                //获取当前点击删除按钮的 id
                var id = $(this).attr('delId');
                //alert("要删除的ID：" + id);
                del(id,this);//真正删除的 逻辑
            });
            function del(id,obj) {
                layui.use(['form', 'layer'], function () {
                    var layer = layui.layer;
                    layer.confirm('确认删除？', {
                        btn: ['确定', '取消'] //按钮
                        ,offset:'c'
                    }, function () {
                        $.ajax('train/delete', {           //url      $.ajax(url,options)
                            type: "post",                         //提交方法
                            data: {"traId": id},                //提交的参数
                            dataType: 'json',                     //接受到信息如何处理
                            success: function (data) {
                                if (data && data.success) {//success 状态为4  http200
                                    layui.use(['form', 'layer'], function () {
                                        var layer = layui.layer;
                                        layer.msg('删除成功', {
                                            icon: 1
                                            ,time:1000
                                        },function () {
                                            //loadPage('train/tolist');
                                            //数据库删除成功后 直接删除此表格行  注意node 个数
                                            var i=obj.parentNode.parentNode.parentNode.rowIndex;
                                            console.log(obj);
                                            document.getElementById('trainTable').deleteRow(i);
                                        });

                                    })
                                } else {
                                    layui.use(['form', 'layer'], function () {
                                        var layer = layui.layer;
                                        layer.msg('删除失败', {
                                            icon: 2
                                            ,time:1000
                                        });

                                    })
                                }
                            }
                        })
                    }, function () {
                        layer.msg('取消操作', {
                            time: 1000, //1s后自动关闭
                        });
                    });
                })
            }

            $('.create').click(function () {
                layui.use(['form', 'layer'], function () {
                    var form = layui.form;
                    form.render();
                    var layer = layui.layer;
                    layer.open({
                        type: 2   //iframe层
                        , content: ['train/toadd', 'no']  //这里content是一个URL，如果你不想让iframe出现滚动条 加 no
                        , title: '添加机构'
                        , area: ['600px', '550px']            //宽高
                        , btn: ['添加', '关闭']
                        , skin: 'to-fix-select'
                        , offset: 't'
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
                var traId = $(this).attr('traId');
                var orgId = $(this).attr('orgId');
                //alert(orderId);
                layui.use(['form', 'layer'], function () {
                    var form = layui.form;
                    form.render();
                    var layer = layui.layer;
                    layer.open({
                        type: 2   //iframe层
                        , content: ['train/toupdate?traId=' + traId + '&orgId=' + orgId, 'no']  //这里content是一个URL，如果你不想让iframe出现滚动条 加 no
                        , title: '添加机构'
                        , area: ['600px', '550px']            //宽高
                        , btn: ['修改', '关闭']
                        , offset: 't'
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

        })

    </script>
</head>
<body style="height: 100%">


<form class="layui-form searchForm">
    <div class="layui-input-inline">
        <input id="searchTrain" type="text" name="traName" autocomplete="off"
               placeholder="快运班列" class="layui-input">
    </div>
    <div class="layui-input-inline">
        <input id="searchOrganize" type="text" name="orgName" autocomplete="off"
               placeholder="所属机构" class="layui-input">
    </div>

</form>
<hr>
<table id="trainTable" class="layui-table">
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>序号</th>
        <th>所属机构</th>
        <th>快运班列</th>
        <th>创建时间</th>
        <th>操作
            <button class="layui-btn layui-btn-sm create">
                <i class="layui-icon">&#xe654;</i>
            </button>
        </th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${organizeList}" var="organize" varStatus="status">
        <tr >
        <c:forEach items="${organize.train}" var="train" varStatus="traStatus">
            <c:if test="${traStatus.index gt 0}">
                <tr>
            </c:if>
            <c:if test="${traStatus.index eq 0}">
                <td rowspan="${organize.train.size()}">${status.count}</td>
                <td rowspan="${organize.train.size()}">${organize.orgName}</td>
            </c:if>
            <td>${train.traName}</td>
            <td><fmt:formatDate value="${train.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm updateBtn" traId=${train.traId} orgId=${organize.orgId}>
                        <i class="layui-icon">&#xe642;</i>
                    </button>
                    <button class="layui-btn layui-btn-sm delBtn" delId="${train.traId}">
                        <i class="layui-icon">&#xe640;</i>
                    </button>
                </div>
            </td>
            <c:if test="${traStatus.index gt 0}">
                </tr>
            </c:if>
        </c:forEach>
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
        $(document).on('input','#searchTrain',function () {
            count = query(1);//根据搜索内容  查出新的数据条数  在分页
            page(count,defaultPage);//layui分页
        })
        $(document).on('input','#searchOrganize',function () {
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
        $.ajax('train/trainlist?pageNum='+page,{
            type:'post',
            cache:false,
            data:$('.searchForm').serialize(),
            dataType:'json',
            async: false,
            success:function(data){
                pageCount =  data.pageCount;
                $(data.organizeList).each(function(index,data){

                    //$('tbody').append("<tr id=\"side"+index+"\"></tr>");
                    //alert($('tbody').html());
                    $(data.train).each(function(index1,data1){
                        var createTime = getDateTime(data1.createTime);
                        if(index1 > 0){
                            $('tbody').append("<tr>" +
                                "<td>"+data1.traName+"</td>\n" +
                                "            <td>"+createTime+"</td>\n" +
                                "            <td>\n" +
                                "                <div class=\"layui-btn-group\">\n" +
                                "                    <button class=\"layui-btn layui-btn-sm updateBtn\" traId="+data1.traId+" orgId="+data.orgId+">\n" +
                                "                        <i class=\"layui-icon\">&#xe642;</i>\n" +
                                "                    </button>\n" +
                                "                    <button class=\"layui-btn layui-btn-sm delBtn\" delId=\""+data1.traId+"\">\n" +
                                "                        <i class=\"layui-icon\">&#xe640;</i>\n" +
                                "                    </button>\n" +
                                "                </div>\n" +
                                "            </td>"+
                                "</tr>");
                        }
                        if(index1 == 0){
                            $('tbody').append("<tr>" +
                                "<td rowspan=\""+data.train.length+"\">"+(index+1)+"</td>" +
                                "<td rowspan=\""+data.train.length+"\">"+data.orgName+"</td>" +
                                "<td>"+data1.traName+"</td>\n" +
                                "            <td>"+createTime+"</td>\n" +
                                "            <td>\n" +
                                "                <div class=\"layui-btn-group\">\n" +
                                "                    <button class=\"layui-btn layui-btn-sm updateBtn\" traId="+data1.traId+" orgId="+data.orgId+">\n" +
                                "                        <i class=\"layui-icon\">&#xe642;</i>\n" +
                                "                    </button>\n" +
                                "                    <button class=\"layui-btn layui-btn-sm delBtn\" delId=\""+data1.traId+"\">\n" +
                                "                        <i class=\"layui-icon\">&#xe640;</i>\n" +
                                "                    </button>\n" +
                                "                </div>\n" +
                                "            </td>"+
                                "</tr>");
                        }
                    });

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
