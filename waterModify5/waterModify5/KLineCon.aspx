<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KLineCon.aspx.cs" Inherits="KLineCon" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>电导率K线图</title>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
    <script src="js/echarts.js"></script>
    <script src="js/echarts.min.js"></script>
    <script src="js/dark.js"></script>
    <script src="js/infographic.js"></script>
    <script src="js/macarons.js"></script>
    <script src="js/roma.js"></script>
    <script src="js/shine.js"></script>
    <script src="js/vintage.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="container" style="min-width: 700px; height: 400px;"></div>  
    </div>
    </form>
</body>
</html>
<script type="text/javascript">

    // 开盘，收盘，最低，最高
    var myChart = echarts.init(document.getElementById('container'), 'roma');
    var DATA = new Array;
    myChart.showLoading();//加载动画
    $.ajax({
        type: "post",   //请求的方法 
        url: "ajax/KLineConductance.ashx",
        cache: false,
        success: function (data) {

            var jsonD = eval("(" + data + ")");
            //var DATA = new Array;

            for (var i = 0; i < jsonD.length; i++) {

                var dat = Date.parse(jsonD[i]['日期']);
                var date = new Date(parseInt(dat));
                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();
                var dateT = year + "/" + month + "/" + day;
                //var date = jsonD[i]['日期'];
                var Open_Con = jsonD[i]['Open_Con'];
                var Close_Con = jsonD[i]['Close_Con'];
                var Min_Con = jsonD[i]['Min_Con'];
                var Max_Con = jsonD[i]['Max_Con'];
                var avg = jsonD[i]['avg'];
                var Con = new Array;
                Con[0] = dateT;
                Con[1] = Open_Con;
                Con[2] = Close_Con;
                Con[3] = Min_Con;
                Con[4] = Max_Con;
                Con[5] = avg;
                DATA.push(Con);
            }
            var data0 = splitData(DATA);
            function splitData(rawData) {
                var categoryData = [];
                var values = [];
                var avg = [];
                for (var i = 0; i < rawData.length; i++) {
                    categoryData.push(rawData[i].splice(0, 1)[0]);
                    values.push(rawData[i].splice(0, 4));
                    avg.push(rawData[i]);
                }
                return {
                    categoryData: categoryData,
                    values: values,
                    avg: avg
                };
            }
            console.log(data0);
            myChart.hideLoading();//取消动画
            myChart.setOption({
                title: {
                    text: '电导率K线图',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'line'
                    }
                },
                grid: {
                    left: '10%',
                    right: '10%',
                    bottom: '15%'
                },
                xAxis: {
                    type: 'category',
                    data: data0.categoryData,

                    scale: true,
                    boundaryGap: false,
                    axisLine: { onZero: false },
                    splitLine: { show: false },
                    splitNumber: 20,
                    min: 'dataMin',
                    max: 'dataMax'
                },
                yAxis: {
                    scale: true,
                    splitArea: {
                        show: true
                    }
                },
                dataZoom: [
                    {
                        type: 'inside',
                        start: 50,
                        end: 100
                    },
                    {
                        show: true,
                        type: 'slider',
                        y: '90%',
                        start: 50,
                        end: 100
                    }
                ],
                series: [
                    {
                        name: '电导率(mS/cm)',
                        type: 'candlestick',
                        data: data0.values

                    },
                    {
                        name: '平均电导率',
                        type: 'line',
                        data:data0.avg
                    }
                ]
            });

            function formatDate(data) {
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];
                    var date = new Date(item[0].replace('-', '/'));
                    item[0] = +date;
                }
                return data;
            }




        }, error: function () { alert("AJAX请求服务器失败！"); }

    });
</script>
