<%--
  Created by IntelliJ IDEA.
  User: win10
  Date: 2021/1/11
  Time: 23:01
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
              <a><cite>首页</cite></a>
              <a><cite>会员管理</cite></a>
              <a><cite>管理员列表</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <form class="layui-form" action="${pageContext.request.contextPath}/wine/querySome" style="width:80%">
        <div class="layui-form-pane" style="margin-top: 15px;">
            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <input type="text" name="queryString"  placeholder="请输入白酒名称或者产地" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-input-inline" style="width:80px">
                    <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
                </div>
            </div>
        </div>
    </form>
    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon">&#xe640;</i>批量删除</button>
        <button class="layui-btn" onclick="admin_add('添加白酒','${pageContext.request.contextPath}/wine/add','600','500')"><i class="layui-icon">&#xe608;</i>添加</button>
        <span class="x-right" style="line-height:40px">共有数据：<span class="layui-badge">${wineList.size()}</span> 条</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <input type="checkbox"  onclick="ckAll()" id="p1"/>
<%--                <input type="checkbox" name="" value="">--%>
            </th>
<%--            <th>--%>
<%--                ID--%>
<%--            </th>--%>
            <th>
                品牌名
            </th>
            <th>
                价格
            </th>
            <th>
                产地
            </th>
            <th>
                类型
            </th>
            <th>
                味道
            </th>
            <th>
                销量
            </th>
            <th>
                操作
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${wineList}" var="one">
        <tr>
            <td>
                <input type="checkbox" name="child" value="${one.id}" onclick="clickChild();"/>
<%--                <input type="checkbox" value="1" name="">--%>
            </td>
<%--            <td>--%>
<%--                ${one.}--%>
<%--            </td>--%>
            <td>
                ${one.wineName}
            </td>
            <td >
                ${one.price}
            </td>
            <td >
                ${one.produceAddress}
            </td>
            <td >
                ${one.wineType}
            </td>
            <td>
                ${one.bouquet}
            </td>
            <td >
                ${one.wineSale}
            </td>
            <td class="td-manage">
<%--                <a style="text-decoration:none" onclick="admin_stop(this,'10001')" href="javascript:;" title="停用">--%>
<%--                    <i class="layui-icon">&#xe601;</i>--%>
<%--                </a>--%>
                <a title="编辑" href="javascript:;" onclick="admin_edit('编辑','${pageContext.request.contextPath}/wine/edit','${one.id}','600','510')"
                   class="ml-5" style="text-decoration:none">
                    <i class="layui-icon">&#xe642;</i>
                </a>
                <a title="删除" href="javascript:;" onclick="admin_del(this,'${one.id}')"
                   style="text-decoration:none">
                    <i class="layui-icon">&#xe640;</i>
                </a>
            </td>
        </tr>
        </tbody>
        </c:forEach>
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
    function delAll () {
        // layer.confirm('确认要删除吗？',{icon:3,title:'提示信息'},function(index){
        //     //捉到所有被选中的，发异步进行删除
        //     layer.msg('删除成功', {icon: 1});
        // });
        var ids=new Array(); //数组，存储选中的id  1,3,5
        //获取选中的复选框的ID
        var childs=document.getElementsByName("child"); //子节点的数组
        for(var i=0;i<childs.length;i++){
            if(childs[i].checked==true){
                var id=childs[i].value; // value被绑定了ID
                ids.push(id);
            }
        }
        if(ids.length>0){
            if(confirm("确定要删除选中的用户吗")){
                //确定要删除
                location.href="UserServlet?action=deleteusers&ids="+ids;
            }
        }else{
            alert("请先选中要删除的用户数据！");
        }

    }
    function ckAll(){
        var status=document.getElementById("p1").checked; //全选按钮的状态
        var childs=document.getElementsByName("child"); //子节点的数组
        for(var i=0;i<childs.length;i++){
            childs[i].checked=status;
        }
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

    // /*启用*/
    // function admin_start(obj,id){
    //     layer.confirm('确认要启用吗？',function(index){
    //         //发异步把用户状态进行更改
    //         $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="admin_stop(this,id)" href="javascript:;" title="停用"><i class="layui-icon">&#xe601;</i></a>');
    //         $(obj).parents("tr").find(".td-status").html('<span class="layui-btn layui-btn-normal">已启用</span>');
    //         $(obj).remove();
    //         layer.msg('已启用!',{icon: 6,time:1000});
    //     });
    // }
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
                url: "${pageContext.request.contextPath}/wine/delete",
                type: "get", //使用http的get请求方式
                data: {"id": id},
                dataType: "json", //期望服务端返回json格式的字符串
                success: function (result) {

                    if(result.code == 0){
                        //{"code": 0, "msg": "删除成功"}
                        //在前端页面删除掉一行
                        $(obj).parents("tr").remove();
                        //弹框提示删除成功
                        layer.msg(result.msg,{icon:1,time:1000});
                    }else{
                        //{"code": -1, "msg": "删除失败"}
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

