<%--
  Created by IntelliJ IDEA.
  User: zjc
  Date: 2021/1/9
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>
        后台管理系统
    </title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js" charset="utf-8"></script>
</head>

<body>
<div class="x-body">
    <form class="layui-form">
        <input type="hidden" name="userId" value="${user.id}">
        <div class="layui-form-item">
            <label for="nickname" class="layui-form-label">
                <span class="x-red">*</span>昵称
            </label>
            <div class="layui-input-inline">
                <input type="text" id="nickname" name="nickname" required="" lay-verify="nickname"
                       value="${user.name}" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>输入用户昵称
            </div>
        </div>
        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="x-red">*</span>登录名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="username" name="username" required="" lay-verify="required" value="${user.username}"
                       autocomplete="off" class="layui-input" disabled="disabled">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>将会成为您唯一的登入名
            </div>
        </div>
        <div class="layui-form-item">
            <label for="phone" class="layui-form-label">
                <span class="x-red">*</span>手机
            </label>
            <div class="layui-input-inline">
                <input type="text" id="phone" value="${user.phone}" name="phone" required="" lay-verify="phone"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>将会成为您唯一的登入名
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_email" class="layui-form-label">
                <span class="x-red">*</span>邮箱
            </label>
            <div class="layui-input-inline">
                <input type="text" id="L_email" name="email" required="" lay-verify="email" value="${user.email}"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="address" class="layui-form-label">
                <span class="x-red">*</span>地址
            </label>
            <div class="layui-input-inline">
                <select id="address" name="address">
                    <!-- 用户jstl标签： if标签来做判断，对user.address-->
                    <option value="">请选择省份</option>
                    <option value="四川" <c:if test="${user.address == '四川'}">selected="selected"</c:if> >四川</option>
                    <option value="云南" <c:if test="${user.address == '云南'}">selected="selected"</c:if>>云南</option>
                    <option value="贵州" <c:if test="${user.address == '贵州'}">selected="selected"</c:if>>贵州</option>
                    <option value="山东" <c:if test="${user.address == '山东'}">selected="selected"</c:if>>山东</option>
                    <option value="重庆" <c:if test="${user.address == '重庆'}">selected="selected"</c:if>>重庆</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_pass" class="layui-form-label">
                <span class="x-red">*</span>密码
            </label>
            <div class="layui-input-inline">
                <input type="password" id="L_pass" name="pass" required="" lay-verify="pass"
                       autocomplete="off" class="layui-input" value="${user.password}">
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
                <input type="password" id="L_repass" name="repass" required="" lay-verify="repass"
                       value="${user.password}" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label for="L_repass" class="layui-form-label">
            </label>
            <button  class="layui-btn" lay-filter="save" lay-submit="">
                保存
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
            nickname: function(value){
                if(value.length < 2){
                    return '昵称至少得2个字符啊';
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
            var nicknameValue = data.field.nickname;
            var passwordValue = data.field.pass;
            var phoneValue = data.field.phone;
            var emailValue = data.field.email;
            var addressValue = data.field.address;
            var idValue = data.field.userId; //input框里面的name属性指定的一个名
            $.ajax({
                url: "${pageContext.request.contextPath}/user/editDone",
                type: "post",
                data: {"name":nicknameValue, "password":passwordValue,
                     "phone": phoneValue, "email":emailValue,
                     "address":addressValue, "id":idValue},
                dataType: "json",
                success : function (result) {
                    if(result.code == 0){
                        layer.alert(result.msg, {icon: 6},function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                            //刷新user列表页面
                            parent.location.reload();
                        });
                    }else{
                        layer.msg(result.msg);
                    }
                },
                error : function (err) {
                    layer.alert(JSON.stringify(err));
                }
            });
            return false;
        });
    });
</script>

</body>

</html>
