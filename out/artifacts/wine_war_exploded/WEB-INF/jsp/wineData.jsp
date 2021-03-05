<%--
  Created by IntelliJ IDEA.
  User: zjc
  Date: 2021/1/10
  Time: 9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>中国白酒数据分析系统</title>
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.1.min.js"></script>
    <script>
        $(window).load(function(){
            $(".loading").fadeOut()
        })
    </script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/map.css">
</head>
<body>
<div class="loading">
    <div class="loadbox"> <img src="${pageContext.request.contextPath}/picture/loading.gif"> 页面加载中... </div>
</div>
<div class="data">
    <div class="data-title">
        <div class="title-center ">中国白酒数据分析概览</div>
    </div>
    <div class="data-content">
        <div class="con-left fl">
            <div class="left-top">
                <div class="info boxstyle" style="height: 200px;">
                    <div class="title">数据统计</div>
                    <div class="info-main" >
                        <ul>
                            <li><img src="${pageContext.request.contextPath}/picture/low.png" alt=""><span>白酒最低价格(元)</span><p>${wineMinPrice}</p></li>
                            <li><img src="${pageContext.request.contextPath}/picture/high.png" alt=""><span>白酒最贵价格(元)</span><p>${wineMaxPrice}</p></li>

                        </ul>
                    </div>
                </div>
                <div class="top-bottom boxstyle" style="height: 300px;">
                    <div class="title">白酒品牌前三占比</div>
                    <div id="echarts_1"  style="height: 300px;"></div>
                </div>
            </div>

        </div>
        <div class="con-center fl">
            <div class="map-num">
                <p>中国白酒产地分布(个)</p>

            </div>
            <div class="cen-top map" id="map"></div>

        </div>
        <div class="con-right fr">
            <div class="right-top boxstyle">
                <div class="title">白酒销售量TOP5</div>
                <div id="echarts_4" class="charts"></div>
            </div>
            <div class="right-center boxstyle">
                <div class="title">白酒价格TOP5</div>
                <div id="echarts_5" class="charts"></div>
            </div>
            <div class="right-bottom boxstyle">
                <div class="title">白酒销售量TOP5</div>
                <div id="echarts_6" class="charts"></div>
            </div>
        </div>
    </div>
</div>
</body>

<script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
<script src="${pageContext.request.contextPath}/js/china.js"></script>
<script src="${pageContext.request.contextPath}/js/echarts.js"></script>
<script>
    $(function () {
        //显示地图
        showMap();
        //显示左下角的饼图
        showTop3Address();
        //显示右侧的柱状图
        showTop5Price();
        //显示右上角饼图
        showTop5Sale();
        //显示右下角折线图
        showTop10Sale();
    });

    function showMap(){
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('map'));


        var option = {

            title: {
                text: '',
                textStyle:{color:'#fff'},
                //subtext: '纯属虚构',
                x:'center'
            },
            tooltip : {
                trigger: 'item'
            },
            visualMap: {
                show : false,
                x: 'left',
                y: 'bottom',
                //layoutCenter:['30%','30%'],
                splitList: [
                    {start: 0, end:100},
                    {start: 100, end: 300},

                    {start: 1500, end: 5000}
                ],
                color: ['#00FF00']
            },
            series: [{
                name: '',
                type: 'map',
                mapType: 'china',
                roam: true,
                label: {
                    normal: {
                        show: true
                    },
                    emphasis: {
                        show: false
                    }
                },
                data:[]  //初始化为空数组
            }]
        };
        //ajax请求服务端，拿取真实数据，分省份统计用户的个数
        $.ajax({
            url: "${pageContext.request.contextPath}/wineData/queryByAddress",
            type: "get",
            dataType: "json",
            success: function (result) {
                // {"code":0 , "msg": "查询成功", "data": [{"name":"四川", "value":"2"},{},{}]}
                myChart.setOption({series:
                        {data:result.data}
                });
            },
            error:function (err) {
                alert(JSON.stringify(err));
            }

        });

        //调用echarts的setOption方法来让图标生效
        myChart.setOption(option);
        window.addEventListener("resize",function(){
            myChart.resize();
        });
    }

    function showTop3Address(){
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('echarts_1'));


        option = {
            backgroundColor: 'rgba(0,0,0,0)',
            tooltip: {
                trigger: 'item',
                formatter: "{b}: <br/>{c} ({d}%)"
            },
            color: [ '#4169E1', '#6495ED', '#B0C4DE'],
            legend: { //图例组件，颜色和名字
                x: '70%',
                y: 'center',
                orient: 'vertical',
                itemGap: 12, //图例每项之间的间隔
                itemWidth: 10,
                itemHeight: 10,
                icon: 'rect',
                data: [],
                textStyle: {
                    color: [],
                    fontStyle: 'normal',
                    fontFamily: '微软雅黑',
                    fontSize: 12,
                }
            },
            series: [{
                name: '白酒品牌前三占比',
                type: 'pie',
                clockwise: false, //饼图的扇区是否是顺时针排布
                minAngle: 20, //最小的扇区角度（0 ~ 360）
                center: ['35%', '50%'], //饼图的中心（圆心）坐标
                radius: [40, 60], //饼图的半径
                //  avoidLabelOverlap: true, ////是否启用防止标签重叠
                itemStyle: { //图形样式
                    normal: {
                        borderColor: 'transparent',
                        borderWidth: 2,
                    },
                },
                label: { //标签的位置
                    normal: {
                        show: true,
                        position: 'inside', //标签的位置
                        formatter: "{d}%",
                        textStyle: {
                            color: '#fff',
                        }
                    },
                    emphasis: {
                        show: true,
                        textStyle: {
                            fontWeight: 'bold'
                        }
                    }
                },
                data: []
            }, {
                name: '',
                type: 'pie',
                clockwise: false,
                silent: true,
                minAngle: 20, //最小的扇区角度（0 ~ 360）
                center: ['35%', '50%'], //饼图的中心（圆心）坐标
                radius: [0, 40], //饼图的半径
                itemStyle: { //图形样式
                    normal: {
                        borderColor: '#1e2239',
                        borderWidth: 1.5,
                        opacity: 0.21,
                    }
                },
                label: { //标签的位置
                    normal: {
                        show: false,
                    }
                },
                data: []
            }]
        };

        //ajax请求服务端，拿取真实数据，分省份统计用户的个数
        $.ajax({
            url: "${pageContext.request.contextPath}/wineData/queryTop3Address",
            type: "get",
            dataType: "json",
            success: function (result) {
                // {"code":0 , "msg": "查询成功", "data": [{"name":"四川", "value":"2"},{},{}]}
                myChart.setOption({
                    legend:{data:result.legend},
                    series: [{data:result.data},{data:result.data}]
                });
            },
            error:function (err) {
                alert(JSON.stringify(err));
            }

        });

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        window.addEventListener("resize",function(){
            myChart.resize();
        });
    }

    function showTop5Price(){
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('echarts_5'));

        var option = {
            backgroundColor: "#141f56",

            tooltip: {
                show: "true",
                trigger: 'item',
                backgroundColor: 'rgba(0,0,0,0.4)', // 背景
                padding: [8, 10], //内边距
                // extraCssText: 'box-shadow: 0 0 3px rgba(255, 255, 255, 0.4);', //添加阴影
                formatter: function(params) {
                    if (params.seriesName != "") {
                        return params.name + ' ：  ' + params.value;
                    }
                },

            },
            grid: {
                borderWidth: 0,
                top: 10,
                bottom: 35,
                left:60,
                right:10,
                textStyle: {
                    color: "#fff"
                }
            },
            xAxis: [{
                type: 'category',

                axisTick: {
                    show: false
                },

                axisLine: {
                    show: true,
                    lineStyle: {
                        color:'rgba(255,255,255,0.2)',
                    }
                },
                axisLabel: {
                    inside: false,
                    textStyle: {
                        color: '#bac0c0',
                        fontWeight: 'normal',
                        fontSize: '12',
                    },
                    // formatter:function(val){
                    //     return val.split("").join("\n")
                    // },
                },
                data: [],
            }],
            yAxis: {
                min:0,
                type: 'value',
                axisTick: {
                    show: false
                },
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: 'rgba(255,255,255,0.2)',
                    }
                },
                splitLine: {
                    show: true,
                    lineStyle: {
                        color: 'rgba(255,255,255,0.1)',
                    }
                },
                axisLabel: {
                    textStyle: {
                        color: '#bac0c0',
                        fontWeight: 'normal',
                        fontSize: '12',
                    },
                    formatter: '{value}',
                },
            },
            series: [{
                type: 'bar',
                itemStyle: {
                    normal: {
                        show: true,
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                            offset: 0,
                            color: '#8A2BE2'
                        }, {
                            offset: 1,
                            color: '#4B0082'
                        }]),
                        barBorderRadius: 50,
                        borderWidth: 0,
                    },
                    emphasis: {
                        shadowBlur: 15,
                        shadowColor: 'rgba(105,123, 214, 0.7)'
                    }
                },
                zlevel: 2,
                barWidth: '20%',
                data: [],
            }
            ]
        }
        //ajax请求服务端，拿取真实数据，分省份统计用户的个数
        $.ajax({
            url: "${pageContext.request.contextPath}/wineData/queryTopNPrice",
            type: "get",
            data: {"n":5},
            dataType: "json",
            success: function (result) {
                //{"code":0, "msg":"获取数据成功", "data":["18","28"], "xAxis": ["翠花","张三"]}
                myChart.setOption({
                    xAxis:{data:result.xAxis},
                    series:{data:result.data}
                });
            },
            error:function (err) {
                alert(JSON.stringify(err));
            }

        });

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }

    function showTop5Sale() {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('echarts_4'));

        option = {

            tooltip : {
                trigger: 'item',
                formatter: "{b}: <br/>  {c} ({d}%)"
            },

            toolbox: {
                show : false,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    magicType : {
                        show: true,
                        type: ['pie', 'funnel']
                    },
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            calculable : true,
            series : [

                {
                    name:'排名',
                    type:'pie',
                    color: ['#228B22', '#7FFF00', '#20b9cf', '#2089cf', '#205bcf'],
                    radius : [20, 70],
                    center : ['50%', '55%'],
                    roseType : 'area',
                    data:[]
                }
            ]
        };
        //ajax请求服务端，拿取真实数据，分省份统计用户的个数
        $.ajax({
            url: "${pageContext.request.contextPath}/wineData/queryTop5Sale",
            type: "get",
            data: {"n":5},
            dataType: "json",
            success: function (result) {
                //{"code":0, "msg":"获取数据成功", "data":["18","28"], "xAxis": ["翠花","张三"]}
                myChart.setOption({
                    series:{data:result.data}
                });
            },
            error:function (err) {
                alert(JSON.stringify(err));
            }

        });
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        window.addEventListener("resize",function(){
            myChart.resize();
        });

    }

    function showTop10Sale() {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('echarts_6'));

        option = {


            tooltip: {
                show: "true",
                trigger: 'item',
                backgroundColor: 'rgba(0,0,0,0.4)', // 背景
                padding: [8, 10], //内边距
                // extraCssText: 'box-shadow: 0 0 3px rgba(255, 255, 255, 0.4);', //添加阴影
                formatter: function(params) {
                    if (params.seriesName != "") {
                        return params.name + ' ：  ' + params.value;
                    }
                },

            },
            grid: {
                borderWidth: 0,
                top: 10,
                bottom: 35,
                left:60,
                right:10,
                textStyle: {
                    color: "#fff"
                }
            },
            xAxis: {
                type: 'category',
                data: [],
                axisLabel: {
                    inside: false,
                    textStyle: {
                        color: '#bac0c0',
                        fontWeight: 'normal',
                        fontSize: '12',
                    },
                },
            },
            yAxis: {
                type: 'value',
                axisLabel: {
                    inside: false,
                    textStyle: {
                        color: '#bac0c0',
                        fontWeight: 'normal',
                        fontSize: '12',
                    },
                },
            },
            series: [{
                data: [],
                type: 'line'
            }]
        };
        //ajax请求服务端，拿取真实数据，分省份统计用户的个数
        $.ajax({
            url: "${pageContext.request.contextPath}/wineData/queryTop10Sale",
            type: "get",
            data: {"n":10},
            dataType: "json",
            success: function (result) {
                //{"code":0, "msg":"获取数据成功", "data":["18","28"], "xAxis": ["翠花","张三"]}
                myChart.setOption({
                    xAxis:{data:result.xAxis},
                    series:{data:result.data}
                });
            },
            error:function (err) {
                alert(JSON.stringify(err));
            }
        });
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        window.addEventListener("resize",function(){
            myChart.resize();
        });



    }

</script>
</html>
