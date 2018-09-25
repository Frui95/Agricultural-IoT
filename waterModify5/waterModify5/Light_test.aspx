<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Light_test.aspx.cs" Inherits="Light_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>光照强度实时曲线</title>
    <link href="style/buttons.css" rel="stylesheet" />
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
</head>
<body>
    <fieldset style="text-align:match-parent">
            <legend style="text-align:left">选择节点</legend>
            <label for="Select2">节点编号：</label><select id="Select2" style="width:60px" required="required">
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
        <div id="container" style="min-width:700px;height:400px"></div>
    </div>
    
</body>
</html>
<script type="text/javascript">
    
        
            Highcharts.setOptions({ global: { useUTC: false } });
            function Button() {
                var nodes_id = $("#Select2").val();
                //function get_temper() {
                var LightSeries = new Array();
                var lastlight = new Number;
                lastTimeDate = new String;

                $.ajax({
                    type: "post",   //请求的方法 
                    url: "ajax/get_Light.ashx?nodes_id=" + nodes_id,
                    cache: false,
                    //async: true,
                    //dataType:'json',
                    success: function (data) {
                        var jsonD = eval("(" + data + ")");

                        if (jsonD.length > 0) {
                            for (var i = 0; i < jsonD.length; i++) {
                                var rows = jsonD[i];
                                var Light = rows.light;
                                //var TimeDate = rows.time;
                                datestring = new String;
                                datestring = rows.time;
                                var d = Date.parse(datestring);


                                //var currentTime0 = (new Date()).getTime();
                                var lightplot = new Array();
                                //temperplot[0] = currentTime0;
                                lightplot[0] = d;
                                lightplot[1] = Light;
                                LightSeries.push(lightplot);

                            }
                            lastlight = jsonD[jsonD.length - 1].light;
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
                                                    y = lastlight;
                                                series.addPoint([x, y], true, true);

                                            }, 500);
                                        }
                                    }
                                },
                                title: {
                                    text: '光照强度实时监测'
                                },
                                subtitle: { text: 'Source:Green House Of SJTU' },
                                xAxis: {
                                    type: 'datetime',
                                    tickPixelInterval: 150
                                },
                                yAxis: {
                                    title: {
                                        text: '光照强度指数'
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
                                        valueSuffix: 'lux'
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
                                    name: '光照强度指数',
                                    //data: jsonXData
                                    data: LightSeries,
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
