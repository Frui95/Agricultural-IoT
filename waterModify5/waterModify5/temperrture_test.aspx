<%@ Page Language="C#" AutoEventWireup="true" CodeFile="temperrture_test.aspx.cs" Inherits="temperrture_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <title>温室温度实时曲线</title>
    <script src="js/jquery-1.10.1.min.js"></script>
    <link href="style/easyui/easyui.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/demo.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/icon.css" rel="stylesheet" type="text/css" />
    <link href="style/buttons.css" rel="stylesheet" />
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
    
    
    
   
    <style type="text/css">
        #max {
            height: 147px;
        }
        #Text1 {
            height: 20px;
            width: 71px;
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
            width: 71px;
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
   
        <fieldset style="text-align:left">
            <legend style="text-align:left">温室内空气温度</legend>
             <label for="Select2">节点编号：</label>
            <select id="Select2" style="width:60px;" required="required">
                <option value="1">01</option>
                <option value="2">02</option>
                <option value="3">03</option>
                <option value="4">04</option>
                <option value="5">05</option>
                <option value="6">06</option>
                <option value="7">07</option>
                <option value="8">08</option>
                <option value="9">09</option>
                <option value="10">10</option>

              </select>
            <button id="button" class="button button-glow button-primary button-pill button-tiny " onclick="Button()">查看</button>
        </fieldset>
    <div>
        <div id="container" style="min-width: 700px; height: 400px"></div>
        <div></div>


    </div>

               
    
</body>
</html>
<script type="text/javascript">
   
        
                Highcharts.setOptions({ global: { useUTC: false } });

                //function get_temper() {
                function Button() {
                    var nodes_id = $('#Select2').val();
                    var TemperSeries = new Array();
                    var lasttemper = new Number;
                    lastTimeDate = new String;
                    $.ajax({
                        type: "post",   //请求的方法 
                        url: "ajax/get_airtemper.ashx?nodes_id=" + nodes_id,
                        cache: false,
                        async: false,
                        //dataType:'json',
                        success: function (data) {
                            var jsonD = eval("(" + data + ")");
                            console.log(jsonD);
                            if (jsonD.length > 0) {
                                for (var i = 0; i < jsonD.length; i++) {
                                    var rows = jsonD[i];
                                    var Airtemp = rows.airtemper;
                                    //var TimeDate = rows.time;
                                    datestring = new String;
                                    datestring = rows.time;
                                    //var d = Date.parse(datestring);
                                    var d = datestring;
                                    console.log(d);

                                    //var currentTime0 = (new Date()).getTime();
                                    var temperplot = new Array();
                                    //temperplot[0] = currentTime0;
                                    temperplot[0] = d;
                                    temperplot[1] = Airtemp;
                                    TemperSeries.push(temperplot);

                                }
                                lasttemper = jsonD[jsonD.length - 1].airtemper;
                                lastTimeDate = jsonD[jsonD.length - 1].time;
                                var Dt = Date.parse(lastTimeDate);

                                //alert(TemperSeries[0][0]+"+"+TemperSeries[0][1]+","+TemperSeries[1][0]+"+"+TemperSeries[1][1]+" \\\ "+TemperSeries[55][0]+"+"+TemperSeries[55][1]);
                                //alert(lasttemper);
                                var chart;
                                chart = new Highcharts.Chart({
                                    chart: {
                                        renderTo: 'container',
                                        type: 'line',
                                        animation: Highcharts.svg,
                                        // don't animate in old IE               
                                        marginRight: 10,
                                        events: {
                                            load: function () {
                                                var series = this.series[0];
                                                setInterval(function () {
                                                    var x = Dt,
                                                        y = lasttemper;
                                                    series.addPoint([x, y], true, true);

                                                }, 300);
                                            }
                                        }
                                    },
                                    title: {
                                        text: '温室温度的实时监测'
                                    },
                                    subtitle: { text: 'Source:Green House Of SJTU' },
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
                                        data: TemperSeries,
                                        //(function () {
                                        //    var data = [],
                                        //    time = (new Date()).getTime(),
                                        //    i;

                                        //    for (i = -19; i <= 0; i++) {
                                        //        data.push({
                                        //            //x:time + i*5000,
                                        //            x: temperdata.x,
                                        //            //y:jsonXData
                                        //            y: temperdata.y
                                        //        });
                                        //    }

                                        //    return data;

                                        //})()
                                    }]

                                });//chart
                            }

                        }, error: function () { alert("AJAX请求服务器失败！"); }
                    });
                    //alert(lasttemper);
                }





         
    
</script>