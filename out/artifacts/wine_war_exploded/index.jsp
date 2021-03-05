<%--
  Created by IntelliJ IDEA.
  User: zjc
  Date: 2021/1/5
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>后台登录-X-admin2.0</title>
  <meta name="renderer" content="webkit|ie-comp|ie-stand">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
  <meta http-equiv="Cache-Control" content="no-siteapp" />

  <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
  <link rel="stylesheet" href="./css/font.css">
  <link rel="stylesheet" href="./css/xadmin.css">
  <script type="text/javascript" src="./js/jquery.min.js"></script>
  <script src="./lib/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="./js/xadmin.js"></script>

</head>
<body class="login-bg">

<div class="login">
  <div class="message">用户登录</div>
  <div id="darkbannerwrap"></div>


  <hr class="hr15">
 <!-- a标签，超链接-->
<%--  <a href="http://www.baidu.com">跳百度</a>--%>
  <form method="get" class="layui-form" id="user" >
    <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
    <hr class="hr15">
    <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
    <hr class="hr15">
    <input value="登录" lay-submit lay-filter="userLogin" style="width:100%;" type="submit">
    <hr class="hr20" >
  </form>



</div>

<script>
  layui.use('form', function(){
    var form = layui.form;
    //监听提交
    form.on('submit(userLogin)', function(data){

      // layer.alert(JSON.stringify(data.field), {
      //   title: '点击确定进入后台'
      // },function  () {
      //   location.href = "./index.html";
      // })
      //从layui框架的回调方法给的参数中取出用户的输入值
      var usernameValue = data.field.username;
      var passwordValue = data.field.password;
      //使用ajax技术来发送请求到java后端
      $.ajax({
        //el表达式取出当前web应用的虚拟目录“wine_war_exploded”
        url: "${pageContext.request.contextPath}/user/login",
        type: "post", //post应对提交大量数据的场景，具有稍高安全性
        data: {"username":usernameValue, "password":passwordValue},
        dataType: "json", //ajax请求期望服务端返回json格式的字符串
        success: function (result) {
          if(result.code == 0){
            //        {"code":0, "msg": "登录成功"}
             layui.layer.msg(result.msg, {time:1000,icon:1}, function () {
              //延时1秒钟跳转主页面
              location.href = "./home.jsp";
            })
          }else{
            //        {"code":-1, "msg": "用户账号或密码错误"}
            layui.layer.msg(result.msg);
          }
        },
        error: function (err) {
            layui.layer.alert(JSON.stringify(err)); //将err这个js对象转成字符串，弹框显示出来。
        }
      });

      return false;
    });
  });


</script>

</body>
</html>
