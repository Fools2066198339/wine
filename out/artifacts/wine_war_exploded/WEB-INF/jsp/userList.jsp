<%--
  Created by IntelliJ IDEA.
  User: zjc
  Date: 2021/1/7
  Time: 15:39
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
<div class="x-nav">
            <span class="layui-breadcrumb">
              <a ><cite>首页</cite></a>
              <a><cite>会员管理</cite></a>
              <a><cite>管理员列表</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <form class="layui-form" action="${pageContext.request.contextPath}/user/querySome" style="width:80%">
        <div class="layui-form-pane" style="margin-top: 15px;">
            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <input type="text" name="queryString"  placeholder="请输入昵称或手机号" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-input-inline" style="width:80px">
                    <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
                </div>
            </div>
        </div>
    </form>
    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="deletePtag()"><i class="layui-icon">&#xe640;</i>批量删除</button>
        <button class="layui-btn" onclick="admin_add('添加用户','${pageContext.request.contextPath}/user/add','600','500')"><i class="layui-icon">&#xe608;</i>添加</button>
        <span class="x-right" style="line-height:40px">共有数据：<span class="layui-badge">${userList.size()}</span> 条</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>

                <input type="checkbox"  onclick="ckAll()" id="chek_all"/>
<%--                <input type="checkbox" name="" value="">--%>
<%--    <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>--%>

            </th>
            <th>
                ID
            </th>
            <th>
                昵称
            </th>
            <th>
                账号
            </th>
            <th>
                手机
            </th>
            <th>
                邮箱
            </th>
            <th>
                地址
            </th>
            <th>
                加入时间
            </th>
            <th>
                状态
            </th>
            <th>
                操作
            </th>
        </tr>
        </thead>
        <tbody>
        <!-- JSTL jsp标准标签库 -->
        <!--c:forEach标签专门用户循环控制 items指定要循环的集合， var指定循环的循环变量-->
        <c:forEach items="${userList}" var="one">
        <tr>
            <td>
                <input type="checkbox" name="check" value="${one.id}" onclick="clickChild();"/>
<%--                <input type="checkbox" value="1" name="">--%>
            </td>
            <td>
                ${one.id}
            </td>
            <td>
                ${one.name}
            </td>
            <td>
                ${one.username}
            </td>
            <td >
                ${one.phone}
            </td>
            <td >
                ${one.email}
            </td>
            <td >
                ${one.address}
            </td>
            <td>
                ${one.createTime}
            </td>
            <td class="td-status">

                <!-- 利用jstl if标签做逻辑判断 -->
                <!-- if标签的test属性中使用el表达式来获得一个true/false的条件，进而判断
                   标签体里面的内容是否保留-->
                    <c:if test="${one.isValid == 1}">
                            <span class="layui-btn layui-btn-normal ">
                                已启用
                            </span>
                    </c:if>
                <c:if test="${one.isValid == 0}">
                            <span class="layui-btn layui-btn-disabled ">
                                已停用
                            </span>
                </c:if>
            </td>
            <td class="td-manage">
                <a style="text-decoration:none" onclick="admin_stop(this,'10001')" href="javascript:;" title="停用">
                    <i class="layui-icon">&#xe601;</i>
                </a>
                <a title="编辑" href="javascript:;" onclick="admin_edit('编辑','${pageContext.request.contextPath}/user/edit',${one.id},'600','510')"
                   class="ml-5" style="text-decoration:none">
                    <i class="layui-icon">&#xe642;</i>
                </a>
                <a title="删除" href="javascript:;" onclick="admin_del(this,${one.id})"
                   style="text-decoration:none">
                    <i class="layui-icon">&#xe640;</i>
                </a>
            </td>

        </tr>
        </c:forEach>
        </tbody>
    </table>

    <div id="page"></div>
</div>

<script>
    layui.use(['layer'], function(){
        $ = layui.jquery;//jquery

        layer = layui.layer;//弹出层

        //以上模块根据需要引入

    });

    //批量删除提交
    function delAll (obj,ptag_ids) {
        layer.confirm('确认要删除吗？',{icon:3,title:'提示信息'},function(index){
           //捉到所有被选中的，发异步进行删除
           //  layer.msg('删除成功', {icon: 1});

                $.ajax({
                    url: "${pageContext.request.contextPath}/user/delete",
                    type: "get", //使用http的get请求方式
                    data: {"ids": ptag_ids.toString()},
                    dataType: "json", //期望服务端返回json格式的字符串
                    success: function (result) {

                        if(result.code == 0){
                            //{"code": 0, "msg": "删除用户成功"}
                            //在前端页面删除掉一行
                            $(obj).parents("tr").remove();
                            //弹框提示删除成功
                            layer.msg(result.msg,{icon:1,time:1000});
                        }else{
                            //{"code": -1, "msg": "删除用户失败"}
                            layer.msg(result.msg,{icon:5,time:1000});
                        }
                    },
                    error: function (err) {
                        //弹框显示错误信息
                        layui.layer.alert(JSON.stringify(err));
                    }
                });
            });
    }
    //全选
    function ckAll(){
        var flag=document.getElementById("chek_all").checked;
        var cks=document.getElementsByName("check");
        for(var i=0;i<cks.length;i++){
            cks[i].checked=flag;
        }
    }

    function batchDelete() {
        var ptag_ids = new Array(); //定义一个数组存储id

        // 循环获取选中的checkbox
        $("#ptagTbody input[type='checkbox']:checked").each(function() {
            if (!isNaN($(this).val())) {
                ptag_ids.push($(this).val()); // 把值push进入数组里面
            }
        });
        if(ptag_ids.length ==0){
            alert('请选择至少一条记录删除');
            return false;
        }
        //调用删除函数
        deletePtag(ptag_ids);
    }

    function deletePtag(ptag_ids){
        layer.confirm('确认要删除吗？',{icon:3,title:'提示信息'},function(index){
            $.ajax({
                type : "post",
                url : "{:U('batchDeletePtag')}",
                data : { "ptag_ids" : ptag_ids.toString() },  //数组.toString();转成字符串，号隔开的
                dataType : "json",
                success : function(data) {
                    console.info(data);
                    if(data["code"] > 0 ){
                        $("#chek_all").prop("checked", false);//成功后把全选按钮设置成不选中，其他下面刷新了，要不要都可以的
                        alert(data.msg);
                        location.reload();
                    }else{
                        alert(data.msg);
                    }
                },
                error: function (err) {
                //弹框显示错误信息
                layui.layer.alert(JSON.stringify(err));
            }
            });
        });
    }




    /*添加*/
    function admin_add(title,url,w,h){
        x_admin_show(title,url,w,h);
    }

    /*停用*/
    function admin_stop(obj,id){
        layer.confirm('确认要停用吗？',function(index){
            //发异步把用户状态进行更改
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="admin_start(this,id)" href="javascript:;" title="启用"><i class="layui-icon">&#xe62f;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="layui-btn layui-btn-disabled">已停用</span>');
            $(obj).remove();
            layer.msg('已停用!',{icon: 5,time:1000});
        });
    }

    /*启用*/
    function admin_start(obj,id){
        layer.confirm('确认要启用吗？',function(index){
            //发异步把用户状态进行更改
            $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="admin_stop(this,id)" href="javascript:;" title="停用"><i class="layui-icon">&#xe601;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="layui-btn layui-btn-normal">已启用</span>');
            $(obj).remove();
            layer.msg('已启用!',{icon: 6,time:1000});
        });
    }
    //编辑
    function admin_edit (title,url,id,w,h) {
        var newUrl = url + "?id=" + id;
        x_admin_show(title,newUrl,w,h);
    }
    /*删除*/
    function admin_del(obj,id){
        layer.confirm('确认要删除吗？',{icon:3,title:'提示信息'},function(index){
            //发异步删除数据
            $.ajax({
                url: "${pageContext.request.contextPath}/user/delete",
                type: "get", //使用http的get请求方式
                data: {"id": id},
                dataType: "json", //期望服务端返回json格式的字符串
                success: function (result) {

                    if(result.code == 0){
                        //{"code": 0, "msg": "删除用户成功"}
                        //在前端页面删除掉一行
                        $(obj).parents("tr").remove();
                        //弹框提示删除成功
                        layer.msg(result.msg,{icon:1,time:1000});
                    }else{
                        //{"code": -1, "msg": "删除用户失败"}
                        layer.msg(result.msg,{icon:5,time:1000});
                    }
                },
                error: function (err) {
                    //弹框显示错误信息
                    layui.layer.alert(JSON.stringify(err));
                }
            });
        });
    }




</script>

</body>
</html>

