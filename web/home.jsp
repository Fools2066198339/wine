<%--
  Created by IntelliJ IDEA.
  User: zjc
  Date: 2021/1/7
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>中国白酒数据分析系统</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>


    <style>
        html,body{
            height: 90%;
        }
    </style>

</head>
<body style="height: 100%;" >
<div class="header bg-main" >
    <div class="logo margin-big-left fadein-top" >
        <h1>
            <img src="images/y.jpg" class="radius-circle rotate-hover" height="50" alt="" />
            <!-- 使用el表达试来访问会话域中的变量-->
            ${loginUser.name}
        </h1>

    </div>
    <div class="head-l">
        <a href="javascript:openUrl('${pageContext.request.contextPath}/wineData/view')" class="button button-little bg-green"  >首页</a> &nbsp;&nbsp;
        <a href="javascript:openUrl('${pageContext.request.contextPath}/user/list')" class="button button-little bg-green"  >用户列表</a> &nbsp;&nbsp;
        <a href="javascript:openUrl('${pageContext.request.contextPath}/wine/list')" class="button button-little bg-green" > 白酒列表</a>
        <a href="#" class="button button-little bg-green" onclick="x_admin_show('修改密码','${pageContext.request.contextPath}/user/pwd',500,300)">修改密码 </a> &nbsp;
        <a  href="${pageContext.request.contextPath}/user/logout" class="button button-little bg-red"> 退出登录</a> </div>
</div>

<div style="height: 100%;">
    <iframe scrolling="auto" rameborder="0" src="${pageContext.request.contextPath}/wineData/view" name="right" width="100%" height="100%"></iframe>
</div>

</body>
</html>
<script>
    //打开中间页面
    function openUrl(url){
        $("iframe").attr("src",url)
    }
</script>
