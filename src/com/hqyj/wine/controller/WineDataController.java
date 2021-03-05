package com.hqyj.wine.controller;

import com.hqyj.wine.entity.EchartsData;
import com.hqyj.wine.service.WineDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller //告诉spring框架，当前类为一个控制器Controller
@RequestMapping("/wineData")
public class WineDataController {
    @Autowired
    private WineDataService wineDataService;

    @RequestMapping("/view")
    public String wineDataView(ModelMap map){
        //给浏览器返回wineData.jsp
        List<EchartsData> MaxPrice = wineDataService.queryMaxPrice();
        map.addAttribute("wineMaxPrice",MaxPrice.get(0).getValue());
        List<EchartsData> MinPrice = wineDataService.queryMinPrice();
        map.addAttribute("wineMinPrice",MinPrice.get(0).getValue());
        return "wineData";
    }

    @RequestMapping("/queryByAddress")
    @ResponseBody
    public Map<String, Object> queryByAddress(){
        Map<String, Object> result = new HashMap<>();
        List<EchartsData> data = wineDataService.getUserDataGroupByAddress();
        result.put("code", 0);
        result.put("msg", "查询数据成功");
        result.put("data", data);
        System.out.println("queryByAddress.." + data);
        // {"code":0 , "msg": "查询数据成功", "data": [{"name":"四川", "value":"2"},{},{}]}
        return result;
    }

    @RequestMapping("/queryTop3Address")
    @ResponseBody
    public Map<String, Object> queryTop3Address(){
        Map<String, Object> result = new HashMap<>();
        List<EchartsData> data = wineDataService.getTopNAddress(3);
        result.put("code", 0);
        result.put("msg", "查询数据成功");
        List<String> names = getEchartsDataName(data);
        System.out.println(names);
        result.put("legend", names);
        result.put("data", data);
        System.out.println("queryByAddress.." + data);
        // {"code":0 , "msg": "查询数据成功","legend":["重庆","四川"], "data": [{"name":"四川", "value":"2"},{},{}]}
        return result;
    }
    //重新组装EchartsData的数据结构，返回是一个字符串数组，
    // 里面装的是EchartsData对象的name成员变量值
    private List<String> getEchartsDataName(List<EchartsData> data){
        //创建一个空数组
        List<String> result = new ArrayList<>();
        //循环遍历data集合，将每个元素里面的name成员变量数据拿出来扔给result数组
        for(EchartsData one:data){
            String name = one.getName();
            result.add(name);
        }
        return result;
    }

    //重新组装EchartsData的数据结构，返回是一个字符串数组，
    // 里面装的是EchartsData对象的value成员变量值
    private  List<String> getEchartsDataValue(List<EchartsData> data){
        List<String> result = new ArrayList<>();
        for(EchartsData item:data){
            result.add(item.getValue());
        }
        return result;
    }

    @RequestMapping("/queryTopNPrice")
    @ResponseBody
    public Map<String, Object> queryTopNPrice(int n){
        Map<String, Object> result = new HashMap<>();
        List<EchartsData> data = wineDataService.queryTopNPrice(n);
//        System.out.println(data);
        result.put("code", 0);
        result.put("msg", "获取数据成功");
        result.put("data",getEchartsDataValue(data));
        result.put("xAxis", getEchartsDataName(data));
        //{"code":0, "msg":"获取数据成功", "data":["18","28"], "xAxis": ["翠花","张三"]}
        return result;
    }

    @RequestMapping("/queryTopPrice")
    @ResponseBody
    public Map<String, Object> queryTopPrice(int n){
        Map<String, Object> result = new HashMap<>();
        List<EchartsData> data = wineDataService.queryMaxPrice();
//        System.out.println(data);
        result.put("code", 0);
        result.put("msg", "获取数据成功");
        result.put("data",getEchartsDataValue(data));
        result.put("xAxis", getEchartsDataName(data));
        //{"code":0, "msg":"获取数据成功", "data":["18","28"], "xAxis": ["翠花","张三"]}
        return result;
    }
    @RequestMapping("/queryMinPrice")
    @ResponseBody
    public Map<String, Object> queryMinPrice(int n){
        Map<String, Object> result = new HashMap<>();
        List<EchartsData> data = wineDataService.queryMinPrice();
//        System.out.println(data);
        result.put("code", 0);
        result.put("msg", "获取数据成功");
        result.put("data",getEchartsDataValue(data));
        result.put("xAxis", getEchartsDataName(data));
        //{"code":0, "msg":"获取数据成功", "data":["18","28"], "xAxis": ["翠花","张三"]}
        return result;
    }

    @RequestMapping("/queryTop5Sale")
    @ResponseBody
    public Map<String, Object> queryTop5Sale(int n){
        Map<String, Object> result = new HashMap<>();
        List<EchartsData> data = wineDataService.queryTopNSale(5);
//        System.out.println(data);
        result.put("code", 0);
        result.put("msg", "获取数据成功");
        result.put("data",data);
        //{"code":0, "msg":"获取数据成功", "data":["18","28"], "xAxis": ["翠花","张三"]}
        return result;
    }

    @RequestMapping("/queryTop10Sale")
    @ResponseBody
    public Map<String, Object> queryTop10Sale(int n){
        Map<String, Object> result = new HashMap<>();
        List<EchartsData> data = wineDataService.queryTopNSale(10);
//        System.out.println(data);
        result.put("code", 0);
        result.put("msg", "获取数据成功");
        result.put("data",getEchartsDataValue(data));

        result.put("xAxis",getEchartsDataName(data));
        //{"code":0, "msg":"获取数据成功", "data":["18","28"], "xAxis": ["翠花","张三"]}
        return result;
    }
}
