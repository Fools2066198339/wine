package com.hqyj.wine.dao;

import com.hqyj.wine.entity.EchartsData;

import java.util.List;

public interface WineDataDao {
    //按照address(省份)分组查询用户的统计数量
     List<EchartsData> queryGroupByAddress();
     //按照address(省份)分组查询用户的统计数量，只返回最多的n个省份的数据
     List<EchartsData> queryTopNAddress(int n);
     //查询年龄最小的n个用户的数据（名字、年龄）
     List<EchartsData> queryTopNPrice(int n);
     //获取最高价格
     List<EchartsData> queryMaxPrice();
     //获取最低价格
     List<EchartsData> queryMinPrice();
     //获取销量前10
     List<EchartsData> queryTopNSale(int n);

}
