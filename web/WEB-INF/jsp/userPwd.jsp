<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 2021/1/12
  Time: 19:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>修改-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>

</head>

<body>
<div class="x-body">
    <form class="layui-form">

<%--        <input type="hidden" name="userId" value="${user.id}">--%>
    <div class="layui-form-item">
        <label for="L_email" class="layui-form-label">
            <span class="x-red">*</span>旧密码
        </label>
        <div class="layui-input-inline">
            <input type="password" id="L_email" name="old" required="" lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-mid layui-word-aux">
            <span class="x-red">*</span>
        </div>
    </div>

    <div class="layui-form-item">
        <label for="L_pass" class="layui-form-label">
            <span class="x-red">*</span>新密码
        </label>
        <div class="layui-input-inline">
            <input type="password" id="L_pass" name="pass" required="" lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-mid layui-word-aux">
            6到16个字符
        </div>
    </div>
    <div class="layui-form-item">
        <label for="L_repass" class="layui-form-label">
            <span class="x-red">*</span>确认密码
        </label>
        <div class="layui-input-inline">
            <input type="password" id="L_repass" name="repass" required="" lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label for="L_repass" class="layui-form-label">
        </label>
        <button  class="layui-btn" lay-filter="save" lay-submit="">
            修改
        </button>
    </div>
    </form>
</div>
<script>
    layui.use(['form','layer'], function(){
        $ = layui.jquery;
        var form = layui.form
            ,layer = layui.layer;

        //自定义验证规则
        form.verify({
            nikename: function(value){
                if(value.length < 5){
                    return '昵称至少得5个字符啊';
                }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,repass: function(value){
                if($('#L_pass').val()!=$('#L_repass').val()){
                    return '两次密码不一致';
                }
            }
        });

        //监听提交
        form.on('submit(save)', function(data){
            console.log(data);
            //发ajax异步请求，把数据提交给java后端
            var oldpasswordValue = data.field.old;
            var passwordValue = data.field.pass;
            var   newpassword= data.field.repass;
            // var idValue = data.field.userId; //input框里面的name属性指定的一个名
            $.ajax({
                url: "${pageContext.request.contextPath}/user/editPwd",
                type: "post",
                data: {"oldpassword":oldpasswordValue, "password":passwordValue,"newpassword":newpassword},
                dataType: "json",
                success : function (result) {
                    if(result.code == 0){
                        layer.alert(result.msg, {icon: 6},function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                            //刷新pwd列表页面
                            parent.location.href="../index.jsp";
                        });
                    }else{
                        layer.msg(result.msg);
                    }
                },
                error : function (err) {
                    layer.alert(JSON.stringify(err));
                }
            });

    //     form.on('submit(edit)', function(data){
    //         console.log(data);
    //         //发异步，把数据提交给php
    //         layer.alert("增加成功", {icon: 6},function () {
    //             // 获得frame索引
    //             var index = parent.layer.getFrameIndex(window.name);
    //             //关闭当前frame
    //             parent.layer.close(index);

            return false;
            });


    });

</script>

</body>

</html>