package com.hqyj.wine.controller;

import com.hqyj.wine.entity.User;
import com.hqyj.wine.entity.Wine;
import com.hqyj.wine.service.WineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/wine")
public class WineController {
    @Autowired
    private WineService wineService;

    @RequestMapping("/list") // /虚拟目录/wine/list
    //ModelMap对象就是spring MVC框架给开发者去给jsp页面传值用
    public String list(ModelMap map){
        List<Wine> all = wineService.getAll();
        //将数据库表中查询出来的全部用户数据，传递给后面wineList.jsp页面
        map.addAttribute("wineList", all);
        //spring mvc 会自动查找/WEB-INF/jsp下面的名字叫做userList的jsp文件
        return "wineList";
    }
    @RequestMapping("/querySome")
    //ModelMap对象就是spring MVC框架给开发者去给jsp页面传值用
    //queryString的值就是用户在浏览器中查询框里输入的数据
    public String querySome(String queryString, ModelMap map){
//        System.out.println("queryString=" + queryString);
        List<Wine> some = wineService.getSome(queryString);
        //将数据库表中模糊查询出来的用户数据，传递给后面wineList.jsp页面
        map.addAttribute("wineList", some);
        //spring mvc 会自动查找/WEB-INF/jsp下面的名字叫做wineList的jsp文件
        return "wineList";
    }

    @RequestMapping("/delete")
    @ResponseBody //告诉框架，将Map<String, Object>转换成json格式的字符串
    public Map<String, Object> deleteOne(int id){
//        System.out.println("delete......,id=" + id);
        Map<String, Object> result = new HashMap<>();
        boolean removed = wineService.removeOne(id);
        //{"code": 0, "msg": "删除用户成功"}
        if(removed){
            result.put("code", 0);
            result.put("msg", "删除白酒成功");
        }else {
            result.put("code", -1);
            result.put("msg", "删除白酒失败");
        }
        return result;
    }
    @RequestMapping("/add")
    public String add(){
        //返回用户添加的jsp页面
        return "wineAdd";
    }
    @RequestMapping("/addDone")
    @ResponseBody //ajax请求的控制器方法都得加该注解
    public Map<String, Object> addDone(Wine wine){ //Spring MVC帮开发者封装参数为一个对象
//        System.out.println("addDone..." +wine);
        Map<String, Object> result = new HashMap<>();
        boolean added = wineService.addOne(wine);
        if(added){
            result.put("code", 0);
            result.put("msg", "添加白酒成功");
        }else {
            result.put("code", -1);
            result.put("msg", "添加白酒失败");
        }
        return result;
    }
    @RequestMapping("/edit")
    public String edit(int id, ModelMap map){
        //查询到了一个用户
        Wine one = wineService.getOne(id);
        map.addAttribute("wine", one);
        //返回userEdit.jsp页面
        return "wineEdit";
    }
    @RequestMapping("/editDone")
    @ResponseBody
    public Map<String, Object> editDone(Wine wine){
//        System.out.println("editDone..." + wine);
        Map<String, Object> result = new HashMap<>();
        boolean modified = wineService.modifyOne(wine);
        if(modified){
            result.put("code", 0);
            result.put("msg", "编辑成功");
        }else{
            result.put("code", -1);
            result.put("msg", "编辑失败");
        }
        return result;
    }
}
