<%@ Page Language="C#" AutoEventWireup="true" CodeFile="airtemper.aspx.cs" Inherits="get_airtemper" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <title>温室温度实时曲线</title>
    <script src="js/jquery-1.10.1.min.js"></script>
        <script src="js/highcharts.js"></script>
        <script src="js/exporting.js"></script>
        <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
        <script src="js/Accordion.js" type="text/javascript"></script>
        <link href="style/easyui/easyui.css" rel="stylesheet" />
        <link href="style/easyui/icon.css" rel="stylesheet" />
        <link href="style/easyui/demo.css" rel="stylesheet" />
        <script src="js/jquery-1.9.0.min.js"></script>
        <script src="js/jquery.easyui.min.js"></script>
  
    <style type="text/css">
        #max {
            height: 147px;
        }
        #Text1 {
            height: 20px;
        }
        #maxmum {
            height: 35px;
        }
        #Text3 {
            width: 100px;
        }
        #Text4 {
            height: 15px;
        }
        #Text5 {
            height: 17px;
        }
        #Text6 {
            width: 107px;
        }
        #mini {
            height: 87px;
        }
        #Button1 {
            height: 45px;
            width: 113px;
        }
        #Button2 {
            height: 43px;
            width: 124px;
        }
    </style>
  
</head>
<body>
    <form id="form1" runat="server">
    <div id="container" style="min-width:700px;height:400px"></div>
    <div id ="container2" style ="height :808px; min-width :700px;  ">
        <div style="height: 400px; width : 350px; float:left; padding:30px 60px" id="container3" class="easyui-panel" title ="分析">
            <div style="margin-bottom :20px"> 
                <div>当天最高温度：</div>
                <input class ="easyui-textbox" data-options="prompt:'XX℃，XX时XX分XX秒'" style ="width :100%;height :32px">
                </div>
            <div style ="margin-bottom :20px">
                <div>当天最低温度：</div>
                <input class ="easyui-textbox" data-options="prompt:'XX℃，XX时XX分XX秒'"   style ="width :100%;height :32px">
                </div>          
        </div>
        
    </div>
    </form>
</body>
</html>
<script type="text/javascript">

    
    setInterval("airtempershow();", 1000);
    Highcharts.setOptions({ global: {useUTC:false}});



            function airtempershow(){
                //获取JSON数据：
                var jsonXData = [];
                var jsonyD1 = [];
                var jsonyD2 = [];
                var temperdata = [];
                var time = [];
                $.ajax({
                    type: "get",   //请求的方法 
                    url: 'ajax/get_airtemper.ashx',
                    cache: false,
                    async: true ,
                    //dataType:'json',
                    success: function (data) {
                        var json = eval("(" + data + ")");
                        if (json.length > 0) {
                            for (var i = 0; i < json.length; i++) {
                                var rows = json[i];
                                var Airtemper =  rows.airtemper ;
                                //var level = rows.well_lev;

                                jsonXData.push(Airtemper); //赋值
                                //jsonXData.push(parseInt(ID)); //赋值
                                //jsonyD1.push(parseInt(ID));
                                //jsonyD2.push(parseInt(level));
                            }
                            jsonyD1.push(json[json.length - 1].airtemper);

                            for (var a = 0; a < json.length; i++) {
                                 time = (new Date()).getTime();
                                var temper = json[i].airtemper;
                                 temperdata = [];
                                temperdata.push({x:time,y:temper});
                                    
                            }
                            alert(temperdata);
                            
                        }
                       

                        var chart;
                        chart = new Highcharts.Chart({
                            chart: {
                                renderTo: 'container',
                                type: 'spline',
                                animation: Highcharts.svg,
                                // don't animate in old IE               
                                marginRight: 10,
                                events: {
                                    load: function () {
                                        var series = this.series[0];                                     
                                        setInterval(function () {
                                            var x = (new Date()).getTime(),
                                                y = jsonyD1                                         
                                            series.addPoint([x, y], true, true);
                                            
                                        }, 5000);
                                    }
                                }
                            },
                            title: {
                                text: '温室温度的实时监测'
                            },
                            xAxis: {
                                type: 'datetime',
                                tickPixelInterval: 150
                            },
                            yAxis: {
                                title: {
                                    text: '空气温度(℃)'
                                },
                                plotLines: [{
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }]
                            },
                
                            tooltip: {
                                formatter: function () {
                                    return '<b>' + this.series.name + '</b><br/>' +
                                    Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                                    Highcharts.numberFormat(this.y, 2);
                                    valueSuffix: '℃'
                                }
                            },
                            legend: {
                                layout: 'vertical',
                                align: 'right',
                                verticalAlign: 'middle',
                                borderWidth: 0
                            },
                            exporting: {
                                enabled: false
                            },
                            series: [{
                                name: '空气温度',
                                //data: jsonXData
                                data: 
                                    (function () {
                                    var data=[],
                                    time = (new Date()).getTime(),
                                    i;

                                    for (i=-19;i<=0;i++){
                                        data.push({
                                            //x:time + i*5000,
                                            x:temperdata.x,
                                            //y:jsonXData
                                            y:temperdata.y
                                        });
                                    }
                                    
                                    return data;
                                   
                                })()
                            }]
                
                        }); // set up the updating of the chart each second   highchart的管辖范围   
                    },
                    error: function () {
                        alert("Ajax请求数据失败!");
                    }
                });//for ajax的管辖范围
            };
            
            
           
       
</script>
