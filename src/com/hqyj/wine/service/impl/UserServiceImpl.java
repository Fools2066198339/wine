package com.hqyj.wine.service.impl;

import com.hqyj.wine.dao.UserDao;
import com.hqyj.wine.entity.User;
import com.hqyj.wine.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.sql.Array;
import java.util.ArrayList;
import java.util.List;

//告诉spring框架，UserServiceImpl是一个service层的组件
@Service
public class UserServiceImpl implements UserService {
    //告诉spring框架，自动找一个UserDao对象来装备到下面的userDao成员变量中
    @Autowired
    private UserDao userDao;

    //ctrl+i 快速生成一个空的实现方法
    @Override
    public User login(String username, String password) {
        //如果入参username和password为空，直接返回null
        if(username == null || password == null){
            return null;
        }
        //直接调用userDao对象的查询方法来实现login业务
        return userDao.queryByUsernameAndPassword(username, password);
    }

    //ctrl + i快捷实现方法
    @Override
    public List<User> getAll() {
        return userDao.queryAll();
    }

    @Override
    public List<User> getSome(String queryString) {
        //定义一个新的字符串
        String newQueryString;
        if(queryString == null){
            //如果用户没有输入或输入错误的情况，返回查询全部的结果
            newQueryString = "%";
        }else{
            //前后补上模糊匹配要用到的%
            newQueryString = "%" + queryString + "%";
        }
        return userDao.querySome(newQueryString);
    }

    //ctrl + i
    @Override
    public boolean removeOne(int userId) {
        int result = userDao.deleteOneById(userId);
        //1 > 0 = true， 0 > 0 =false
        return result > 0;
    }



    @Override
    public boolean addOne(User user) {
        int result = 0;
        if(user  == null){
            return false;
        }
        //捕获数据库的数据访问异常
        try{
           result =  userDao.insertOne(user);
        }catch (DataAccessException e){
            //捕获到异常，控制台打印trace
            e.printStackTrace();
        }
        return result >0;
    }

    @Override
    public User getOne(int userId) {
        return userDao.queryOneById(userId);
    }

    @Override
    public boolean modifyOne(User user) {
        if(user == null){
            return false;
        }
        int result = userDao.updatePwdById(user.getId(),"");
        //1>0 = true, 0>0 = false
        return result > 0;
    }

    @Override
    public boolean modifyPwd(User user) {
        if(user == null){
            return false;
        }
        int result = userDao.updatePwdById(user.getId(),"");
        //1>0 = true, 0>0 = false
        return result > 0;
    }

    @Override
    public User queryOneByName(String queryString) {
        return userDao.queryOneByName(queryString);
    }

    @Override
    public boolean upPassword(User user, String oldpassword, String newpassword) {

        if (user.getPassword().equals(oldpassword)){
            userDao.updatePwdById(user.getId(),newpassword);
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteSomeById(String[] ids) {

        if(ids!= null){
            userDao.deleteSomeById(ids);
            return true;
        }
        return false;
    }
}
