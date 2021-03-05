package com.hqyj.wine.dao;

import com.hqyj.wine.entity.User;
import com.hqyj.wine.entity.Wine;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

//利用单元测试框架junit测试UserDao对象
//告诉junit测试框架当前测试需要运行再spring框架的环境下
@RunWith(SpringJUnit4ClassRunner.class)
//告诉spring框架，spring的配置文件所在地址
@ContextConfiguration(locations = "classpath:config/spring.xml")
public class UserDaoTest {
    //告诉spring框架自动找一个UserDao的对象来赋值给下面这个userDao变量
    @Autowired
    private UserDao userDao;
    @Autowired
    private WineDao wineDao;

    //表明当前的这个方法是一个测试用例
    @Test
    public void queryAllTest(){
        //鼠标指着方法名上 alt+enter 快捷引入的局部变量；
        List<User> users = userDao.queryAll();
        //控制台打印
        System.out.println(users);
        //分行打印users集合里面的元素
        //集合的遍历
        for(User one:users){
            System.out.println(one);
        }
    }
    @Test
    public void queryAllTest1(){
        //鼠标指着方法名上 alt+enter 快捷引入的局部变量；
        List<Wine> wines = wineDao.queryAll();
        //控制台打印
        System.out.println(wines);
        //分行打印users集合里面的元素
        //集合的遍历
        for(Wine one:wines){
            System.out.println(one);
        }
    }

}
