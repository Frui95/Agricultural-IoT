<%@ Page Language="C#" AutoEventWireup="true" CodeFile="humidity.aspx.cs" Inherits="humidity" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>温室湿度实时曲线</title>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
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
        #Text31 {
            height: 11px;
            width: 92px;
        }
        #Text61 {
            width: 110px;
        }
        #Button2 {
            height: 42px;
            width: 128px;
        }
    </style>
</head>
<body>
     <div id="container" style="min-width:700px;height:400px"></div>
     <div id="container2" style="min-width :700px;height:300px">
          <div style="height: 250px; width : 350px; float:left; " id="container3" class="maxDate">
            <div>土壤湿度：</div>
            <div id="hum1" >
             <div id="max-block" style="height: 66px">
               <div id="maxmum">
                <asp:Label id="Label1" display="inline-block" runat="server" Text="当天最高：" Font-Size="Medium"></asp:Label>
                <input id="Text1" type="text" display="inline-block"/>
               </div>
                <div id="maxmum-info" style="height: 30px">


                    <asp:Label ID="Label2" runat="server" Font-Size="Small" Text="时间："></asp:Label>
                    <input id="Text2" type="text" />
                    <asp:Label ID="Label3" runat="server" Font-Size="Small" Text="湿度："></asp:Label>
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
                    <input id="Text5" type="text" /><asp:Label ID="Label6" runat="server" Font-Size="Small" Text="湿度："></asp:Label>
                    <input id="Text6" type="text" />

                </div>
                </div>
            <div style="height: 47px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input id="Button1" type="button" value="查看历史" /></div>
                
            </div>
            
        </div>
         <div style="float:right">
            <div style="height: 400px; width : 350px; " id="container4" class="maxDate">
                <div>空气湿度：</div>
            <div id="Form2">
             <div id="max-block2" style="height: 66px">
               <div id="maxmum1">
                <asp:Label id="Label7" display="inline-block" runat="server" Text="当天最高：" Font-Size="Medium"></asp:Label>
                <input id="Text11" type="text" display="inline-block"/>
               </div>
                <div id="maxmum-info1" style="height: 30px">


                    <asp:Label ID="Label8" runat="server" Font-Size="Small" Text="时间："></asp:Label>
                    <input id="Text21" type="text" />
                    <asp:Label ID="Label9" runat="server" Font-Size="Small" Text="温度："></asp:Label>
                    <input id="Text31" type="text" />

                </div>
              </div>
                <div id="mini1">
                <div id="minimum1" style="height: 33px">

                    <asp:Label ID="Label10" runat="server" Text="当天最低："></asp:Label>
                    <input id="Text41" type="text" />

                </div>
                <div id ="mini-info1" style="height: 33px">

                    <asp:Label ID="Label11" runat="server" Text="时间：" Font-Size="Small"></asp:Label>
                    <input id="Text51" type="text" display="inline-block"/><asp:Label ID="Label12" runat="server" Font-Size="Small" Text="温度："></asp:Label>
                    <input id="Text61" type="text" />

                </div>
                </div>
            <div style="height: 47px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input id="Button2" type="button" value="查看历史" /></div>
                
            </div>
            
        </div>
        </div>
     </div>
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
            //获取数据
            //$.ajax({
            //    type: "post",   //请求的方法 
            //    url: 'ajax/point.aspx',
            //    cache: false,
            //    async: false,
            //    success: function (data) {
            //        var json = eval("(" + data + ")");
            //        if (json.length > 0) {
            //            for (var i = 0; i < json.length; i++) {
            //                var rows = json[i];
            //                var ID = "第" + rows.well_ID + "个监控点";
            //                var level = rows.well_lev;

            //                jsonXData.push(ID); //赋值
            //                jsonXData.push(parseInt(ID)); //赋值
            //                jsonyD1.push(parseInt(ID));
            //                jsonyD2.push(parseInt(level));
            //            }
            //        }
            //    }
            //});//for
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
                    text: '温室湿度实时监测'
                },
                xAxis: {
                    type: 'datetime',
                    tickPixelInterval: 150
                },
                yAxis: [{
                    title: {
                        text: '土壤湿度'
                    },
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
            {
                title: {
                    text: '空气湿度'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            }],
                   
                
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
                    name: '土壤湿度',
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
                }, {
                    name: '空气湿度',
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
            var series1 = chart.series[1];
            setInterval(function () {
                var x = (new Date()).getTime(),
                // current time         
                y = parseInt(Math.random() * (40 - 20 + 1) + 20);
                y1 = parseInt(Math.random() * (40 - 20 +1 ) + 20);
                series.addPoint([x, y], true, true);
                series1.addPoint([x, y1], true, true);
            },
            1000);
        });
    });
</script>
