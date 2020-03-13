<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/4/8 0008
  Time: 下午 2:40
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
                //alert("sad")
                var id = $(this).attr('cancelId');
                var status = $(this).attr('status');
                var moneyStatus = $(this).attr('moneyStatus');
                if(status == "运输中"){
                    //alert("订单运输中，取消失败！");
                    layui.use(['form', 'layer'], function () {
                        var layer = layui.layer;
                        layer.msg('订单运输中，取消失败！', {
                            time:1000
                        });
                    })
                }else if(status == "已完成"){
                    //alert("订单已完成，取消无效！");
                    layui.use(['form', 'layer'], function () {
                        var layer = layui.layer;
                        layer.msg('订单已完成，取消无效！', {
                            time:1000
                        });
                    })
                }else {

                    if (moneyStatus == "在线支付(已支付)"){
                        //满足撤销订单的条件之后 执行 退款 订单撤销
                        window.location.href = "ali/torefund?orderId="+id;
                    } else{
                        cancel(id,this);//真正删除的 逻辑
                    }
                }

            })
            $('body').on('click','.delBtn',function () {

                //获取当前点击删除按钮的 id
                var id = $(this).attr('delId');
                var status = $(this).attr('status');
                var getStatus = $(this).attr('getStatus');
                //alert(getStatus);
                //alert("要取消订单的ID："+id);
                if(status == "已完成"){
                    if (getStatus == "待领货") {
                        //alert("尚未领货，无法删除!");
                        layui.use(['form', 'layer'], function () {
                            var layer = layui.layer;
                            layer.msg('尚未领货，无法删除!', {
                                time:1000
                            });
                        })
                    }else{
                        del(id,this);//真正删除的 逻辑
                    }

                }else {
                    //alert("订单未完成，无法删除!");
                    layui.use(['form', 'layer'], function () {
                        var layer = layui.layer;
                        layer.msg('订单未完成，无法删除!', {
                            time:1000
                        });
                    })
                }

            })

            function cancel(id,obj) {
                layui.use(['form', 'layer'], function () {
                    var layer = layui.layer;
                    layer.confirm('确认取消订单？', {
                        btn: ['确定', '取消'] //按钮
                        ,offset:'c'
                    }, function () {
                        $.ajax('order/cancel', {           //url      $.ajax(url,options)
                            type: "post",                         //提交方法
                            data: {"orderId": id},                //提交的参数
                            dataType: 'json',                     //接受到信息如何处理
                            success: function (data) {
                                if (data && data.success) {//success 状态为4  http200
                                    layui.use(['form', 'layer'], function () {
                                        var layer = layui.layer;
                                        layer.msg('取消成功', {
                                            icon: 1
                                            ,time:1000
                                        },function () {
                                            //loadPage('order/tolist');
                                            //数据库删除成功后 直接删除此表格行  注意node 个数
                                            var i=obj.parentNode.parentNode.parentNode.rowIndex;
                                            console.log(obj);
                                            document.getElementById('orderTable').deleteRow(i);
                                        });

                                    })
                                } else {
                                    layui.use(['form', 'layer'], function () {
                                        var layer = layui.layer;
                                        layer.msg('取消失败', {
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

            function del(id,obj) {
                layui.use(['form', 'layer'], function () {
                    var layer = layui.layer;
                    layer.confirm('确认删除订单？', {
                        btn: ['确定', '取消'] //按钮
                        ,offset:'c'
                    }, function () {
                        $.ajax('order/delete', {           //url      $.ajax(url,options)
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
                                            //loadPage('order/tolist');
                                            //数据库删除成功后 直接删除此表格行  注意node 个数
                                            var i=obj.parentNode.parentNode.parentNode.rowIndex;
                                            console.log(obj);
                                            document.getElementById('orderTable').deleteRow(i);
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

        })

    </script>
    <style>
        table td{
            table-layout: fixed;
            white-space:nowrap;overflow:hidden;text-overflow: ellipsis;
        }
    </style>
</head>
<body>
<form class="layui-form searchForm ">

    <div class="layui-input-inline" style="width: 300px">
        <input id="searchOrder" type="text" name="orderId" autocomplete="off"
               placeholder="订单号" class="layui-input">
    </div>
    <div class="layui-input-inline " style="width: 200px">
        <%--style="display: none" 隐藏可以站位置  hidden不能--%>
        <button class="layui-btn search" lay-submit  hidden lay-filter="*" style="display: none">
            <i class="layui-icon" style="font-size: 20px; ">&#xe615;</i> 搜索
        </button>
    </div>
    <div class="layui-input-inline " style="width: 200px">
        <i style="color: #c2c2c2">在线支付(待支付)可点击以支付</i>
    </div>
</form>
<table id="orderTable" class="layui-table" >
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>单号</th>
        <th>出发站</th>
        <th>到达站</th>
        <th>运货日期</th>
        <th>付款状态</th>
        <th>线路方案</th>
        <th>运输状态</th>
        <th>创建时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${orderList}" var="order" varStatus="status">
        <tr>
            <td>${order.orderId}</td>
            <td>${order.senderName}</td>
            <td>${order.senderStation}</td>
            <td>${order.receiptName}</td>
            <td>${order.receiptStation}</td>
            <td><fmt:formatDate value="${order.transTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <c:choose>
                <c:when test="${order.moneyStatus eq '在线支付(待支付)'}">
                    <a href="order/toupdatemmonystatus?orderId=${order.orderId}" >${order.moneyStatus}</a>
                </c:when>
                <c:otherwise>
                    ${order.moneyStatus}
                </c:otherwise>
                </c:choose>
            </td>
            <td>${order.lineMatch}</td>
            <td>${order.status}</td>
            <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td>
                <div class="layui-btn-group">
                    <button class="layui-btn layui-btn-sm cancelBtn" cancelId="${order.orderId}" status="${order.status}" moneyStatus="${order.moneyStatus}">
                        <i class="layui-icon">取消</i>
                    </button>
                    <button class="layui-btn layui-btn-sm delBtn" delId="${order.orderId}" status="${order.status}" getStatus="${order.getStatus}">
                        <i class="layui-icon">删除</i>
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
        $(document).on('input','#searchOrder',function () {
            var name = $('#searchOrder').val();
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
        $.ajax('order/orderlist?pageNum='+page,{
            type:'post',
            cache:false,
            data:$('.searchForm').serialize(),
            dataType:'json',
            async: false,
            success:function(data){
                pageCount =  data.pageCount;
                $(data.orderList).each(function(index,data){
                    //console.info(data.createTime);
                    var transTime = getDateTime(data.transTime);
                    var createTime = getDateTime(data.createTime);

                    $("tbody").append(" <tr>\n" +
                        "\n" +
                        "        <td>"+data.orderId+"</td>\n" +
                        "        <td>"+data.senderStation+"</td>\n" +
                        "        <td>"+data.receiptStation+"</td>\n" +
                        "        <td>"+transTime+"</td>\n" +
                        "        <td class='moneyStatus"+index+"'>"+data.moneyStatus+"</td>\n" +
                        "        <td>"+data.lineMatch+"</td>\n" +
                        "        <td>"+data.status+"</td>\n" +
                        "        <td>"+createTime+"</td>\n" +
                        "        <td><div class=\"layui-btn-group\">" +
                        "                    <button class=\"layui-btn layui-btn-sm\" onclick=\"loadPage('order/toupdate?orderId="+data.orderId+"')\">\n" +
                        "                        <i class=\"layui-icon\">&#xe642;</i>\n" +
                        "                    </button>\n" +
                        "                   <button class=\"layui-btn layui-btn-sm cancelBtn\" cancelId=\""+data.orderId+"\" status=\""+data.status+"\" moneyStatus=\""+data.moneyStatus+"\">\n" +
                        "                        <i class=\"layui-icon\"></i>取消\n" +
                        "                    </button>\n" +
                        "                    <button class=\"layui-btn layui-btn-sm delBtn\" delId=\""+data.orderId+"\" status=\""+data.status+"\" getStatus=\""+data.getStatus+"\">\n" +
                        "                        <i class=\"layui-icon\"></i>删除\n" +
                        "                    </button>" +
                        "</div></td>\n" +
                        "    </tr>");
                    if (data.moneyStatus == "在线支付(待支付)"){
                        $('.moneyStatus'+index).html("<a style=\"cursor:pointer\" onclick=\"loadPage('order/toupdatemmonystatus?orderId="+data.orderId+"')\" >"+data.moneyStatus+"</a>") ;
                    }
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

