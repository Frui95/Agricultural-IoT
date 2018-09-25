<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testLevel.aspx.cs" Inherits="testLevel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>井盖液位信息显示</title>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
    <script src="js/json2.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <fieldset>
        <legend>井盖液位信息显示 </legend>
        <div>
            <div id="containerliuliang">
            </div>
        </div>
    </fieldset>
    </form>
</body>
</html>
<script type="text/javascript">
    levelshow();
    setInterval("levelshow();", 10000);

    /*获取json数据开始*/
    //定义变量

    function levelshow() {
        var jsonXData = [];
        var jsonyD1 = [];
        var jsonyD2 = [];

        //获取数据
        $.ajax({
            type: "post",   //请求的方法 
            url: 'ajax/leveldata.ashx',
            cache: false,
            async: false,
            success: function (data) {
                var json = eval("(" + data + ")");
                if (json.length > 0) {
                    for (var i = 0; i < json.length; i++) {
                        var rows = json[i];
                        var ID ="第" +rows.well_ID+"个监控点";
                        var level = rows.well_lev;

                        jsonXData.push(ID); //赋值
                        //jsonXData.push(parseInt(ID)); //赋值
                        //jsonyD1.push(parseInt(ID));
                        jsonyD2.push(parseInt(level));
                    } //for
                    var chart;
                    chart = new Highcharts.Chart({
                        chart: {
                            renderTo: 'containerliuliang',          //放置图表的容器
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            defaultSeriesType: 'column'   //图表类型line, spline, area, areaspline, column, bar, pie , scatter 
                        },
                        title: {
                            text: '液位信息显示'
                        },
                        xAxis: {//X轴数据
                            categories: jsonXData,
                            lineWidth: 2,
                            labels: {
                                rotation: -45, //字体倾斜
                                align: 'right',
                                style: { font: 'normal 13px 宋体' }
                            }
                        },
                        yAxis: {//Y轴显示文字
                            lineWidth: 2,
                            title: {
                                text: '液位高度/cm'
                            }
                        },
                        tooltip: {
                            formatter: function () {
                                return '<b>' + this.x + '</b><br/>' +
        this.series.name + ': ' + Highcharts.numberFormat(this.y, 0);
                            }
                        },
                        plotOptions: {
                            column: {
                                dataLabels: {
                                    enabled: true
                                },
                                enableMouseTracking: true//是否显示title
                            }
                        },
                        series: [
                        //    {
                        //    name: '总流量',
                        //    data: jsonyD1
                        //},
                        {
                            name: '液位高度',
                            data: jsonyD2
                        }]
                    });
                    //$("tspan:last").hide(); //把广告删除掉
                } //if
            }, //失败情况下的处理 


            error: function () {
                alert("Ajax请求数据失败!");
            }
        });
    }

            </script>
