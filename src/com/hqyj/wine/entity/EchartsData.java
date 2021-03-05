package com.hqyj.wine.entity;
//返回给前端时，框架直接转成对应于echarts图表要求的json格式
public class EchartsData {
    private String name;
    private String value;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "EchartsData{" +
                "name='" + name + '\'' +
                ", value='" + value + '\'' +
                '}';
    }
}
