package com.hqyj.wine.dao;

import com.hqyj.wine.entity.User;
import com.hqyj.wine.entity.Wine;
import org.apache.ibatis.annotations.Param;

import java.util.List;

//接口文件，行为（方法）的定义
public interface WineDao {
    List<Wine> queryAll();
    //根据酒的输入模糊查询获取信息
    List<Wine> getSome(String queryString);
    //定义删除某个wine的操作, 使用id唯一确定一个wine
    //返回值的含义，影响了几行数据，这里只会有0或1
    int deleteOneById(int id);
    //插入一个wine的数据到数据库，这里只会返回0或者1
    int insertOne(Wine wine);
    //通过wine的id去查询该用户的所有信息
    Wine queryOneById(int id);
    //更新操作,使用wine对象的id的值去识别待编辑的wine数据，使用wine对象的
    // 其他成员变量去更新数据库表对应的记录
    int updateOne(Wine wine);
}
