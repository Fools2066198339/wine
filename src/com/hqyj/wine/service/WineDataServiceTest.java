package com.hqyj.wine.service;

import com.hqyj.wine.entity.EchartsData;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

//利用单元测试框架junit测试UserService对象
//告诉junit测试框架当前测试需要运行再spring框架的环境下
@RunWith(SpringJUnit4ClassRunner.class)
//告诉spring框架，spring的配置文件所在地址
@ContextConfiguration(locations = "classpath:config/spring.xml")
public class WineDataServiceTest {
    @Autowired
    private WineDataService wineDataService;

    @Test
    public void test1(){
        List<EchartsData> data = wineDataService.getUserDataGroupByAddress();
        System.out.println(data);
    }

    @Test
    public void test2(){
        List<EchartsData> data = wineDataService.getTopNAddress(2);
        System.out.println(data);
    }
    @Test
    public void test3(){
        List<EchartsData> data = wineDataService.queryMaxPrice();
        System.out.println(data);
    }
    @Test
    public void test4(){
        List<EchartsData> data = wineDataService.queryMinPrice();
        System.out.println(data);
    }
    @Test
    public void test5(){
        List<EchartsData> data = wineDataService.queryTopNSale(10);
        System.out.println(data);
    }
    @Test
    public void test6(){
        List<EchartsData> data = wineDataService.queryTopNSale(10);
        System.out.println(data);
    }
}
