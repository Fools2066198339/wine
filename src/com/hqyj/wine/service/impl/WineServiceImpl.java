package com.hqyj.wine.service.impl;


import com.hqyj.wine.dao.WineDao;
import com.hqyj.wine.entity.User;
import com.hqyj.wine.entity.Wine;
import com.hqyj.wine.service.WineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import java.util.List;

//告诉spring框架，UserServiceImpl是一个service层的组件
@Service
public class WineServiceImpl implements WineService {
    @Autowired
    private WineDao wineDao;

    @Override
    public List<Wine> getAll() {
        return wineDao.queryAll();
    }

    @Override
    public List<Wine> getSome(String queryString) {
        String newQueryString;
        if(queryString == null){
            //如果用户没有输入或输入错误的情况，返回查询全部的结果
            newQueryString = "%";
        }else{
            //前后补上模糊匹配要用到的%
            newQueryString = "%" + queryString + "%";
        }
        return wineDao.getSome(newQueryString);
    }

    @Override
    public boolean removeOne(int wineId) {
        int result = wineDao.deleteOneById(wineId);
        //1 > 0 = true， 0 > 0 =false
        return result > 0;
    }

    @Override
    public boolean addOne(Wine wine) {
        int result = 0;
        if(wine  == null){
            return false;
        }
        //捕获数据库的数据访问异常
        try{
            result =  wineDao.insertOne(wine);
        }catch (DataAccessException e){
            //捕获到异常，控制台打印trace
            e.printStackTrace();
        }
        return result >0;
    }

    @Override
    public Wine getOne(int wineId) {
        return wineDao.queryOneById(wineId);
    }

    @Override
    public boolean modifyOne(Wine wine) {
        if(wine == null){
            return false;
        }
        int result = wineDao.updateOne(wine);
        //1>0 = true, 0>0 = false
        return result > 0;
    }

}

