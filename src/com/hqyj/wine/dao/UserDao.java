package com.hqyj.wine.dao;

import com.hqyj.wine.entity.User;
import org.apache.ibatis.annotations.Param;

import java.sql.Array;
import java.util.List;

//接口文件，行为（方法）的定义
public interface UserDao {
     //查询全部的用户，将之存储在一个List集合里面
     List<User> queryAll();
     //定义通过用户账号和密码进行查询，返回一个User对象，如果查不到，返回null对象
     User queryByUsernameAndPassword(
             @Param("username") String username, @Param("password")String password);
     //定义一个模糊查询，根据用户的昵称和手机号来模糊匹配软件用户的输入
     List<User> querySome(String queryString);

     //定义删除某个user的操作, 使用id唯一确定一个user
     //返回值的含义，影响了几行数据，这里只会有0或1
     int deleteOneById(int id);
     //插入一个user的数据到数据库，这里只会返回0或者1
     int insertOne(User user);

     //通过user的id去查询该用户的所有信息
      User queryOneById(int id);
      //更新操作,使用user对象的id的值去识别待编辑的user数据，使用user对象的
     // 其他成员变量去更新数据库表对应的记录
      int updateOne(User user);
      User deleteAllById(int id);
      //按id查密码并修改
      int updatePwdById(@Param("id")int id,@Param("password")String newpassord);

      User  queryOneByName(String queryString);

      int deleteSomeById(String[] ids);

}
