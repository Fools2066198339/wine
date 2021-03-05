<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 2021/1/12
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <div class="layui-form-item">
            <label for="wineName" class="layui-form-label">
                <span class="x-red">*</span>品牌名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="wineName" name="wineName" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>请输入白酒的品牌
            </div>
        </div>
        <div class="layui-form-item">
            <label for="price" class="layui-form-label">
                <span class="x-red">*</span>价格
            </label>
            <div class="layui-input-inline">
                <input type="text" id="price" name="price" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>请输入白酒的价格
            </div>
        </div>
        <div class="layui-form-item">
        <label for="address" class="layui-form-label">
            <span class="x-red">*</span>产地
        </label>
        <div class="layui-input-inline" >
            <select id="address" name="address">
                <option value="">请选择省份</option>
                <option value="四川">四川</option>
                <option value="云南">云南</option>
                <option value="贵州">贵州</option>
                <option value="山东">山东</option>
                <option value="重庆">重庆</option>
                <option value="北京">北京</option>
                <option value="山西">山西</option>
            </select>
        </div>
    </div>
        <div class="layui-form-item">
            <label for="wineClass" class="layui-form-label">
                <span class="x-red">*</span>类型
            </label>
            <div class="layui-input-inline">
                <input type="text" id="wineClass" name="wineClass" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="smell" class="layui-form-label">
                <span class="x-red">*</span>味道
            </label>
            <div class="layui-input-inline">
                <input type="text" id="smell" name="smell" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="sale" class="layui-form-label">
                <span class="x-red">*</span>销量
            </label>
            <div class="layui-input-inline">
                <input type="text" id="sale" name="sale" required="" lay-verify="required"
                       autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">
            </div>
        </div>
<%--        <div class="layui-form-item">--%>
<%--            <label for="L_repass" class="layui-form-label">--%>
<%--                <span class="x-red">*</span>确认密码--%>
<%--            </label>--%>
<%--            <div class="layui-input-inline">--%>
<%--                <input type="password" id="L_repass" name="repass" required="" lay-verify="repass"--%>
<%--                       autocomplete="off" class="layui-input">--%>
<%--            </div>--%>
<%--        </div>--%>
        <div class="layui-form-item">
            <label class="layui-form-label">
            </label>
            <button  class="layui-btn" lay-filter="add" lay-submit="">
                增加
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
                if(value.length < 6){
                    return '酒名至少得2个字符啊';
                }
            }
            // ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            // ,repass: function(value){
            //     if($('#L_pass').val()!=$('#L_repass').val()){
            //         return '两次密码不一致';
            //     }
            // }
        });

        //监听提交
        form.on('submit(add)', function(data){
            console.log(data);
            //发ajax异步请求，把数据提交给java后端
            //取出用户在输入框中输入的数据
            var wineNameValue = data.field.wineName;
            var priceValue = data.field.price;
            var addressValue = data.field.address;
            var wineClassValue = data.field.wineClass;
            var smellValue = data.field.smell;
            var saleValue = data.field.sale;


            $.ajax({
                url: "${pageContext.request.contextPath}/wine/addDone",
                type: "post", //提交的数据比较多得情况下选post请求方式
                //给服务端传值，注意这里的key的名字要和后端接受的User对象里面的成员变量名一致
                data: {"wineName":wineNameValue, "price":priceValue,
                    "produceAddress":addressValue, "wineType":wineClassValue,
                    "bouquet":smellValue, "wineSale":saleValue},
                dataType: "json", //期望服务器返回json格式的字符串
                success: function (result) {
                    //{"code":0, "msg":"添加用户成功"}
                    if(result.code == 0){
                        layer.alert(result.msg, {icon: 6},function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                            //刷新用户列表界面
                            parent.location.reload();
                        });
                    }else{
                        layer.msg(result.msg);
                    }
                },
                error: function (err) {
                    layer.alert(JSON.stringify(err));
                }
            });
            return false;
        });
    });
</script>

</body>

</html>
