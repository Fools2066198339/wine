package com.hqyj.wine.service;

import com.hqyj.wine.entity.User;

import java.lang.reflect.Array;
import java.util.List;

public interface UserService {
     //登录功能
     User login(String username, String password);
     //获取全部用户
     List<User> getAll();
     //根据用户的输入模糊查询获取用户
     List<User> getSome(String queryString);
     //根据user的id来删除一个user,返回操作成功或失败
     boolean removeOne(int userId);
     //添加一个user的数据
     boolean addOne(User user);
     //通过id来获取一个user的信息
     User getOne(int userId);
     //更新user的数据
     boolean modifyOne(User user);
     //按id查密码
     boolean modifyPwd(User user);
     User queryOneByName(String queryString);
     //修改的当前登录用户密码
     boolean upPassword(User user,String oldpassword,String newpassword);
     //批量删除
     boolean deleteSomeById(String[] ids);
}
