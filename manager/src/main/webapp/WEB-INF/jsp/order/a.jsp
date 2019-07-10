<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/6/26 0026
  Time: 上午 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <title>Document</title>
    <style>

    </style>
</head>
<body>
<div class="railway_list">
    <div class="w1">
        <div>
            <input type='radio' name='linematch' value='"+line[i].traName+"'>
        </div>
    </div>
    <div class="w2">
        <div>
            <strong>
                line[i].outTime
            </strong>
        </div>

        <div>
            <i class="shi_icon">始</i>
            <span>line[i].startStation</span>
        </div>
    </div>

    <div class="w4">
        <div class="haoshi">
            line[i].time<i class="icon-sfz"></i>
        </div>
        <div class="line">
            <i class="shi guo"></i>
            <i class="zhong"></i>
        </div>
    </div>

    <div class="w3">
        <div>
            <label>
                <strong>
                    line[i].inTime
                </strong>
                <i>
                </i>
            </label>
        </div>
        <div>
            <i class="zhong_icon">终</i>
            <span>line[i].endStation</span>
        </div>
    </div>
</div>
</body>
</html>

