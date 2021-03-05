package com.hqyj.wine.service;

import com.hqyj.wine.entity.User;
import com.hqyj.wine.entity.Wine;

import java.util.List;

public interface WineService {
    //获取全部用户
    List<Wine> getAll();
    //根据用户的输入模糊查询获取wine
    List<Wine> getSome(String queryString);
    //根据wine的id来删除一个wine,返回操作成功或失败
    boolean removeOne(int wineId);
    //添加一个wine的数据
    boolean addOne(Wine wine);
    //通过id来获取一个wine的信息
    Wine getOne(int wineId);
    //更新wine的数据
    boolean modifyOne(Wine wine);
}
