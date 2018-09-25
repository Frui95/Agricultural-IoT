<%@ Page Language="C#" AutoEventWireup="true" CodeFile="光照强度曲线.aspx.cs" Inherits="光照强度曲线" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
    <title>光照强度曲线</title>
    <style type="text/css">
        #Text3 {
            width: 91px;
        }
        #Text6 {
            width: 99px;
        }
        #Button1 {
            height: 44px;
            width: 104px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="container" style="min-width:700px;height:400px"></div>
     <div id="container2" style="min-width :700px;height:300px">
          <div style="height: 250px; width : 350px; float:left; " id="container3" class="maxDate">
            <div>光照强度：</div>
            <div id="light1" >
             <div id="max-block" style="height: 66px">
               <div id="maxmum">
                <asp:Label id="Label1" display="inline-block" runat="server" Text="当天最高：" Font-Size="Medium"></asp:Label>
                <input id="Text1" type="text" display="inline-block"/>
               </div>
                <div id="maxmum-info" style="height: 30px">


                    <asp:Label ID="Label2" runat="server" Font-Size="Small" Text="时间："></asp:Label>
                    <input id="Text2" type="text" />
                    <asp:Label ID="Label3" runat="server" Font-Size="Small" Text="光强："></asp:Label>
                    <input id="Text3" type="text" />

                </div>
              </div>
                <div id="mini">
                <div id="minimum" style="height: 33px">

                    <asp:Label ID="Label4" runat="server" Text="当天最低："></asp:Label>
                    <input id="Text4" type="text" />

                </div>
                <div id ="mini-info" style="height: 33px">

                    <asp:Label ID="Label5" runat="server" Text="时间：" Font-Size="Small"></asp:Label>
                    <input id="Text5" type="text" display="inline-block"/><asp:Label ID="Label6" runat="server" Font-Size="Small" Text="光强："></asp:Label>
                    <input id="Text6" type="text" />

                </div>
                </div>
            <div style="height: 47px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input id="Button1" type="button" value="查看历史" /></div>
                
            </div>
            
        </div>
     </div>
    
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
            var chart;
            chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'container',
                    type: 'line',
                    animation: Highcharts.svg,
                    // don't animate in old IE               
                    marginRight: 10,
                    events: {
                        load: function () { }
                    }
                },
                title: {
                    text: '光照强度实时监测'
                },
                xAxis: {
                    type: 'datetime',
                    tickPixelInterval: 150
                },
                yAxis: {
                    title: {
                        text: '光照强度'
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
                        //valueSuffix: '°C'
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
                    name: '光照强度',
                    data: (function () { // generate an array of random data                             
                        var data = [],
                        time = (new Date()).getTime(),
                        i;
                        for (i = -19; i <= 0; i++) {
                            data.push({
                                x: time + i * 1000,
                                y: parseInt(Math.random() * (40 - 20 + 1) + 20)
                            });
                        }
                        return data;
                    })()
                }]
            }); // set up the updating of the chart each second                     
            var series = chart.series[0];

            setInterval(function () {
                var x = (new Date()).getTime(),
                // current time         
                y = parseInt(Math.random() * (40 - 20 + 1) + 20);
                series.addPoint([x, y], true, true);

            },
            1000);
        });
    });
</script>

