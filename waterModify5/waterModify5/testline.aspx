<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testline.aspx.cs" Inherits="testline" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>实时曲线</title>
    <script src="js/jquery-1.10.1.min.js"></script>
        <script src="js/highcharts.js"></script>
        <script src="js/exporting.js"></script>
  
</head>
<body>
    <form id="form1" runat="server">
    <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto">
    
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    $(function () {
        $(document).ready(function () {
            Highcharts.setOptions({
                global: {
                    useUTC: false
                }
            });
            var data = [],
                        time = (new Date()).getTime(),
                        i;
            var chart;
            $('#container').highcharts({
                chart: {
                    type: 'line',
                    animation: Highcharts.svg, // don't animate in old IE
                    marginRight: 10,
                    events: {
                        load: function () {

                            // set up the updating of the chart each second
                            var series = this.series[0];
                            setInterval(function () {
                                var x = (new Date()).getTime(), // current time
                                    y = Math.random();
                                series.addPoint([x, y], true, true);
                            }, 1000);
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
                        text: '温度'
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
                        valueSuffix: '°C'
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
                credits: {  
                    enabled: false     //去掉highcharts网站url  
                },

                series: [{
                    name: '土壤温度',
                    data: (function () {
                        // generate an array of random data
                        //var data = [],
                        //    time = (new Date()).getTime(),
                        //    i;

                        for (i = -19; i <= 0; i++) {
                            data.push({
                                x: time + i * 1000,
                                y: Math.random(20)
                            });
                        }
                        return data;
                    })()
                },
                {
                    name: '空气温度',
                    data: (function () {
                        // generate an array of random data
                        //var data = [],
                        //    time1 = (new Date()).getTime(),
                        //    //j;

                        for (i = -19; i <= 0; i++) {
                            data.push({
                                x: time1 + i * 1000,
                                y: Math.random(20)
                            });
                        }
                        return data;
                    })()
                }]
            });
        });

    });
</script>
