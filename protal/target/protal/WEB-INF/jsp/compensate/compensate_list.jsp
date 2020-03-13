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

    <script>
        $(function () {


            $('body').on('click','.cancelBtn',function () {

                //获取当前点击删除按钮的 id
                var id = $(this).attr('cancelId');
                var status = $(this).attr('status');
                //alert(status);
                if(status == "处理中"){
                    //alert("理赔处理中，无法撤销！");
                    layui.use(['form', 'layer'], function () {
                        var layer = layui.layer;
                        layer.msg('理赔处理中，无法撤销！', {
                            time:1000
                        });
                    })
                }else {
                    cancel(id,this);//真正删除的 逻辑
                }

            })

            function cancel(id,obj) {
                layui.use(['form', 'layer'], function () {
                    var layer = layui.layer;
                    layer.confirm('确认删除？', {
                        btn: ['确定', '取消'] //按钮
                        ,offset:'c'
                    }, function () {
                        $.ajax('compensate/cancel', {           //url      $.ajax(url,options)
                            type: "post",                         //提交方法
                            data: {"orderId": id},                //提交的参数
                            dataType: 'json',                     //接受到信息如何处理
                            success: function (data) {
                                if (data && data.success) {//success 状态为4  http200
                                    layui.use(['form', 'layer'], function () {
                                        var layer = layui.layer;
                                        layer.msg('删除成功', {
                                            icon: 1
                                            ,time:1000
                                        },function () {
                                            //loadPage('compensate/tolist');
                                            //数据库删除成功后 直接删除此表格行  注意node 个数
                                            var i=obj.parentNode.parentNode.parentNode.rowIndex;
                                            console.log(obj);
                                            document.getElementById('compensateTable').deleteRow(i);
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
                            time: 1000, //20s后自动关闭
                        });
                    });
                })
            }

            $('body').on('click','.createBtu',function () {

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
<form class="layui-form searchForm">

    <div class="layui-input-inline" style="width: 300px">
        <input id="searchOrder" type="text" name="orderId" autocomplete="off"
               placeholder="订单号" class="layui-input">
    </div>
    <div class="layui-input-inline " style="width: 200px">
        <button class="layui-btn search" lay-submit  lay-filter="*" style="display: none">
            <i class="layui-icon" style="font-size: 20px; ">&#xe615;</i> 搜索
        </button>
    </div>
    <div class="layui-input-inline " style="width: 200px">
        <button class="layui-btn createBtu" type="button" data-type="reload">
            <i class="layui-icon" style="font-size: 20px; ">&#xe654;</i>我要理赔
        </button>
    </div>
</form>
<table id="compensateTable" class="layui-table" >
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
<div id="page" align="center"></div>
<script>
    var defaultPage;
    var count;
    $(function () {
        defaultPage = 1;
        count = query(defaultPage);//查出数据
        page(count,defaultPage);//layui分页

        //监听表单提交  搜索表单
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
                form.render(); //这里需要再次渲染一次 按条件查时下拉框渲染
                return false;//阻止表单跳转
            })
            $(document).on('input','#searchOrder',function () {
                var name = $('#searchOrder').val();
                //alert(name);
                count = query(1);//根据搜索内容  查出新的数据条数  在分页
                page(count,defaultPage);//layui分页
            })
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
        $.ajax('compensate/compensatelist?pageNum='+page,{
            type:'post',
            cache:false,
            data:$('.searchForm').serialize(),
            dataType:'json',
            async: false,
            success:function(data){
                pageCount =  data.pageCount;
                $(data.compensateList).each(function(index,data){

                    //$('tbody').append("<tr id=\"side"+index+"\"></tr>");
                    //alert($('tbody').html());
                    $(data.compensate).each(function(index1,data1){
                        var compensateTime = getDateTime(data1.compensateTime);

                        //理赔只能申请一次
                        if(index1 == 0){

                            $('tbody').append("<tr>" +
                                "<td rowspan=\""+data.compensate.length+"\">"+(index+1)+"</td>" +
                                "<td rowspan=\""+data.compensate.length+"\">"+data.orderId+"</td>" +
                                "<input type=\"text\" name=\"orderId\" value=\""+data.orderId+"\" hidden>" +
                                "<td>"+data1.compensateName+"</td>\n" +
                                "<td>"+data1.compensateMoney+"</td>\n" +
                                "<td >"+data1.compensateStatus+"</td>\n" +
                                "<td>"+compensateTime+"</td>\n" +
                                "            <td><div class=\"layui-btn-group\">" +
                                "<button class=\"layui-btn layui-btn-sm cancelBtn\" cancelId=\""+data.orderId+"\" status=\""+data1.compensateStatus+"\">\n" +
                                "                        <i class=\"layui-icon\">&#xe640;</i>\n" +
                                "                    </button>" +
                                "</div></td>" +
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
