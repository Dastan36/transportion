<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/15 0015
  Time: 上午 9:32
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
    <title>机构添加</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="Binary/layui-v2.4.5/layui/css/modules/layui.css">
    <script src="Binary/layui-v2.4.5/layui/layui.js"></script>
    <script src="Binary/js/jquery1.9.1.js"></script>
</head>
<body style="height: 100%;padding: 10px">
<br>
<form class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">机构名：</label>
        <div class="layui-input-inline">
            <input id="orgName" type="text" name="orgName" placeholder="请输入" autocomplete="off" required lay-verify="required"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">管辖区域：</label>
        <div class="layui-input-block" id="orgProName">

        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block" hidden>
            <button class="layui-btn createBtn" lay-submit lay-filter="*" >立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>

</form>
</table>
<script>



$(function () {
    var tagData = [{"orgproId": 1, "province": "黑龙江省"}, {"orgproId": 2,"province": "吉林省"},{"orgproId": 3, "province": "辽宁省"},
        {"orgproId": 4, "province": "北京市"}, {"orgproId": 5, "province": "河北省"},{"orgproId": 6, "province": "天津市"},
        {"orgproId": 7, "province": "山西省"}, {"orgproId": 8, "province": "内蒙古自治区"},{"orgproId": 9, "province": "河南省"},
        {"orgproId": 10, "province": "湖北省"}, {"orgproId": 11, "province": "陕西省"},{"orgproId": 12, "province": "山东省"},
        {"orgproId": 13, "province": "上海市"}, {"orgproId": 14, "province": "江苏省"},{"orgproId": 15, "province": "浙江省"},
        {"orgproId": 16, "province": "安徽省"}, {"orgproId": 17, "province": "江西省"},{"orgproId": 18, "province": "福建省"},
        {"orgproId": 19, "province": "湖南省"}, {"orgproId": 20, "province": "广东省"},{"orgproId": 21, "province": "海南省"},
        {"orgproId": 22, "province": "广西壮族自治区"}, {"orgproId": 23, "province": "四川省"},{"orgproId": 24, "province": "重庆市"},
        {"orgproId": 25, "province": "贵州省"}, {"orgproId": 26, "province": "云南省"},{"orgproId": 27, "province": "甘肃省"},
        {"orgproId": 28, "province": "青海省"}, {"orgproId": 29, "province": "宁夏回族自治区"},{"orgproId": 30, "province": "新疆维吾尔自治区"},
        {"orgproId": 30, "province": "西藏自治区"}
    ];

    layui.config({
        base: 'Binary/layui_exts/layui-select-ext/layui_extends/'
    }).extend({
        // selectN: './layui_extends/selectN',  //无线级联
        selectM: 'selectM',  //多选插件
    }).use(['layer', 'form', 'jquery', 'selectM'], function () {
        $ = layui.jquery;
        var form = layui.form
            , selectM = layui.selectM;
        form.render();
        //多选标签-所有配置
        var tagIns = selectM({
            //元素容器【必填】
            elem: '#orgProName'

            //候选数据【必填】
            , data: tagData

            //默认值
            //, selected: ["12", "17"]

            //最多选中个数，默认5
            , max: 6

            //input的name 不设置与选择器相同(去#.)
            //, name: 'tag2'

            //值的分隔符
            , delimiter: ','

            //候选项数据的键名
            , field: {idName: 'orgproId', titleName: 'province'}


        });
        form.on('submit(*)',function (data) {
            //console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
            //console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
            //console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
            //return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
            var orgName = $('#orgName').val();
            //console.log(tagIns.values)
            if (tagIns.values.length==0){
            layui.use(['layer'],function () {
                var layer = layui.layer;
                layer.msg('请选择管辖区域');
            })

            }else{
                $.ajax('organize/saveorg',{
                    type:'POST',
                    traditional:true,
                    data:{'orgName':orgName,'proId':tagIns.values},
                    dataType:'json',
                    async:false,//默认为true异步
                    success:function (data) {
                        //console.log(data);
                        if (data) {
                            layui.use( 'layer', function () {
                                var layer = layui.layer;
                                layer.alert('添加成功', {
                                    skin: 'layui-layer-molv' //样式类名
                                    ,closeBtn: 0
                                    ,anim: 4 //动画类型
                                }, function(){
                                    var index=parent.layer.getFrameIndex(window.name); //父级子级弹窗一起关闭
                                    parent.layer.close(index);
                                    parent.loadPage('organize/tolist');
                                });
                            })
                        }
                    }
                })
            }

            return false;//阻止表单跳转
        })
    })
})
</script>
</body>
</html>
