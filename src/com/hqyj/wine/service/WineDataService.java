package com.hqyj.wine.service;

import com.hqyj.wine.entity.EchartsData;

import java.util.List;

public interface WineDataService {
    //按照address(省份)分组查询用户的统计数量
    List<EchartsData> getUserDataGroupByAddress();
    //按照address(省份)分组查询用户的统计数量，只返回最多的n个省份的数据
    List<EchartsData> getTopNAddress(int n);
    //获取价格排名
    List<EchartsData> queryTopNPrice(int n);
    //获取最高价格
    List<EchartsData> queryMaxPrice();
    //获取最低价格
    List<EchartsData> queryMinPrice();
    //获取销量前10
    List<EchartsData> queryTopNSale(int n);
}
