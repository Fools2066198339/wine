package com.hqyj.wine.controller;

import com.hqyj.wine.entity.User;
import com.hqyj.wine.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.ImageProducer;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@Controller注解：明确的告诉Spring框架UserController是一个控制器
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    //注解在类上的@RequestMapping的值和注解在方法上的@RequestMapping的值拼在一起
    // "/user/login" 将是完整的访问控制器方法的url路径
    @RequestMapping("/login")
    @ResponseBody //就是告诉spring MVC当前返回为一个json格式的字符串
    public Map<String, Object> login(String username, String password, HttpSession httpSession, HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> result = new HashMap<>();
        User loginUser = userService.login(username, password);
        if(loginUser == null){
            result.put("code", -1); //code为-1含义是业务失败：登录失败
            result.put("msg", "用户账号或密码错误");
        }else{
            httpSession.setAttribute("loginUser", loginUser);
            result.put("code", 0); //code为0含义是业务成功：登录成功
            result.put("msg", "登录成功");
        }
//        {"code":0, "msg": "登录成功"}
//        {"code":-1, "msg": "用户账号或密码错误"}

        return result;
    }

    @RequestMapping("/logout")
    public String logout(HttpSession httpSession){
//        System.out.println("logout......");
        //删除掉会话域中的登陆用户信息
        httpSession.removeAttribute("loginUser");
        //跳转登陆页面,使用相对路径来查找index.jsp
        // /虚拟目录/user/logout ->  /虚拟目录/index.jsp
        return "redirect:../index.jsp";
    }

    @RequestMapping("/list") // /虚拟目录/user/list
    //ModelMap对象就是spring MVC框架给开发者去给jsp页面传值用
    public String list(ModelMap map){
        List<User> all = userService.getAll();
        //将数据库表中查询出来的全部用户数据，传递给后面userList.jsp页面
        map.addAttribute("userList", all);
        //spring mvc 会自动查找/WEB-INF/jsp下面的名字叫做userList的jsp文件
        return "userList";
    }

    @RequestMapping("/querySome")
    //ModelMap对象就是spring MVC框架给开发者去给jsp页面传值用
    //queryString的值就是用户在浏览器中查询框里输入的数据
    public String querySome(String queryString, ModelMap map){
//        System.out.println("queryString=" + queryString);
        List<User> some = userService.getSome(queryString);
        //将数据库表中模糊查询出来的用户数据，传递给后面userList.jsp页面
        map.addAttribute("userList", some);
        //spring mvc 会自动查找/WEB-INF/jsp下面的名字叫做userList的jsp文件
        return "userList";
    }

    @RequestMapping("/delete")
    @ResponseBody //告诉框架，将Map<String, Object>转换成json格式的字符串
    public Map<String, Object> deleteOne(int id){
//        System.out.println("delete......,id=" + id);
        Map<String, Object> result = new HashMap<>();
        boolean removed = userService.removeOne(id);
        //{"code": 0, "msg": "删除用户成功"}
        if(removed){
            result.put("code", 0);
            result.put("msg", "删除用户成功");
        }else {
            result.put("code", -1);
            result.put("msg", "删除用户失败");
        }
        return result;
    }

    @RequestMapping("/add")
    public String add(){
        //返回用户添加的jsp页面
        return "userAdd";
    }

    @RequestMapping("/addDone")
    @ResponseBody //ajax请求的控制器方法都得加该注解
    public Map<String, Object> addDone(User user){ //Spring MVC帮开发者封装参数为一个对象
//        System.out.println("addDone..." +user);
        Map<String, Object> result = new HashMap<>();
        boolean added = userService.addOne(user);
        if(added){
            result.put("code", 0);
            result.put("msg", "添加用户成功");
        }else {
            result.put("code", -1);
            result.put("msg", "添加用户失败");
        }
        return result;
    }

    @RequestMapping("/edit")
    public String edit(int id, ModelMap map){
        //查询到了一个用户
        User one = userService.getOne(id);
        map.addAttribute("user", one);
        //返回userEdit.jsp页面
        return "userEdit";
    }

    @RequestMapping("/editDone")
    @ResponseBody
    public Map<String, Object> editDone(User user){
//        System.out.println("editDone..." + user);
        Map<String, Object> result = new HashMap<>();
        boolean modified = userService.modifyOne(user);
        if(modified){
            result.put("code", 0);
            result.put("msg", "编辑用户成功");
        }else{
            result.put("code", -1);
            result.put("msg", "编辑用户失败");
        }
        return result;
    }

    @RequestMapping("/pwd")
    public String pwd(HttpServletRequest request,ModelMap map){
//        String name = request.getParameter("username");
//        //查询到了一个用户
//        User one = userService.queryOneByName(name);
//        map.addAttribute("user", one);
//        System.out.println(one);
        //返回userEdit.jsp页面
        return "userPwd";
    }

    @RequestMapping("/editPwd")
    @ResponseBody
    public Map<String, Object> pwd(User user,String oldpassword,String newpassword,HttpSession httpSession,ModelMap map){
//        System.out.println("pwd..." + user);
        Map<String,Object> result = new HashMap<>();
        user=(User) httpSession.getAttribute("loginUser");
        boolean up = userService.upPassword(user,oldpassword,newpassword);
        if(!up){
            result.put("code", -1);
            result.put("msg","修改密码错误");
        }else {
            result.put("code", 0);
            result.put("msg","修改密码成功");
            httpSession.removeAttribute("loginUser");
        }
        return result;
    }

    @RequestMapping("/deletes")
    @ResponseBody //告诉框架，将Map<String, Object>转换成json格式的字符串
    public Map<String, Object> deleteSome(String[] ids){
//        System.out.println("delete......,id=" + id);
        Map<String, Object> result = new HashMap<>();
        boolean removed = userService.deleteSomeById(ids);
        //{"code": 0, "msg": "删除用户成功"}
        if(removed){
            result.put("code", 0);
            result.put("msg", "删除用户成功");
        }else {
            result.put("code", -1);
            result.put("msg", "删除用户失败");
        }
        return result;
    }
//    @ResponseBody
//    @RequestMapping(value="/resertAlertid")
//    public int resertAlertid(User ipo,HttpServletRequest request,String str){
//        int res =0;
//        List<Integer> idarr = new ArrayList<Integer>();
//        String[] getstr = str.split(",");
//        for(int i=0;i<getstr.length;i++){
//            idarr.add(Integer.parseInt(getstr[i]));
//        }
//        ipo.setIds(idarr);
//        res = userService.deleteSomeById(ipo);
//        return res;
//    }
}
