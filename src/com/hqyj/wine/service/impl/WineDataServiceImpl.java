package com.hqyj.wine.service.impl;

import com.hqyj.wine.dao.WineDataDao;
import com.hqyj.wine.entity.EchartsData;
import com.hqyj.wine.service.WineDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WineDataServiceImpl implements WineDataService {
    @Autowired
    private WineDataDao wineDataDao;

    @Override
    public List<EchartsData> getUserDataGroupByAddress() {
        return wineDataDao.queryGroupByAddress();
    }

    @Override
    public List<EchartsData> getTopNAddress(int n) {
        return wineDataDao.queryTopNAddress(n);
    }

    @Override
    public List<EchartsData> queryTopNPrice(int n) {
        return wineDataDao.queryTopNPrice(n);
    }

    @Override
    public List<EchartsData> queryMaxPrice() {
        return wineDataDao.queryMaxPrice();
    }

    @Override
    public List<EchartsData> queryMinPrice() {
        return wineDataDao.queryMinPrice();
    }

    @Override
    public List<EchartsData> queryTopNSale(int n) {
        return wineDataDao.queryTopNSale(n);
    }
}
