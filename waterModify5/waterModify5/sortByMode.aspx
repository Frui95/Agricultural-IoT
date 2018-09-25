<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sortByMode.aspx.cs" Inherits="sortByMode" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   
    <title>按模块是否运行正常统计</title>  
    <link href="style/easyui/easyui.css" rel="stylesheet" />
    <link href="style/easyui/icon.css" rel="stylesheet" />
    <link href="style/easyui/demo.css" rel="stylesheet" />    
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="js/awesomechart.js"></script>
    <link href="style/base.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 102px;
        }

        body{
                background: #fff;
                color: #333;
            }
            
            a, a:visited, a:link, a:active{
                color: #333;
            }
            
            a:hover{
                color: #00f;
            }
        
            .charts_container{
                width: 820px;
                height: 420px;
                margin: 10px auto;
            }
            
            .chart_container_centered{
                text-align: center;
                width: 800px;
                height: 420px;
                margin: 10px auto;
            }
            
            .chart_container{
                width: 288px;
                height: 300px;
                margin: 0px 25px 0px 46px;
                float: left;
            }
            
            .footer{
                font-size: small;
                text-align: right;
            }


    </style>
</head>
<body>
   
     <div class="charts_container">
            <div class="chart_container">

                <canvas id="chartCanvas1" width="400" height="400">
                    Your web-browser does not support the HTML 5 canvas element.
                </canvas>

            </div>

            <div class="chart_container">

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <canvas id="chartCanvas2" width="400" height="400">
                    Your web-browser does not support the HTML 5 canvas element.
                </canvas>

            </div>
        </div>
   
</body>
</html>
<script>

    var markerArr =<%getStatus();%>;

    var chart1 = new AwesomeChart('chartCanvas1');
    chart1.title = "井盖模块运行情况统计";
    var j=0;
    var h=0;
    for (var i = 0; i < markerArr.length; i++)
    {
        var json=markerArr[i];
        if (json==0)
        {
            j++;
        }
        else
        {h++;}
               
    }



    chart1.data =[j,h]; 
    chart1.labels = ['正常', '异常'];
    chart1.colors = ['#00CC99', '#FF0000'];
    chart1.randomColors = true;
    chart1.draw();


    var chart2 = new AwesomeChart('chartCanvas2');
    chart2.chartType = "pie";
    chart2.title = "井盖模块运行情况统计";
    chart2.data = [j,h];
    chart2.labels = ['正常', '异常'];
    chart2.colors = chart1.colors;
    chart2.draw();



    var date1 = '1990-1-1';//定义初始时间
    //定义日期格式
    function myformatter(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        date1 = y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
    }
    //定义日期参数的格式
    function myparser(s) {
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0], 10);
        var m = parseInt(ss[1], 10);
        var d = parseInt(ss[2], 10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
            return new Date(y, m - 1, d);
        } else {
            return new Date();
        }
    }

    //定义选择日期函数
    function onSelect(date) {
        //date1 = date;

    }
 
</script>

      <%--页面中用到的CSS样式表--%>
    <style type="text/css">  
        #fm{  
        margin:0;  
        padding:10px 30px;  
        }  
    .ftitle{  
        font-size:14px;  
        font-weight:bold;  
        padding:5px 0;  
        margin-bottom:10px;  
        border-bottom:1px solid #ccc;  
    }  
    .fitem{  
        margin-bottom:5px;  
    }  
    .fitem label{  
        display:inline-block;  
        width:80px;  
    }  
        #cc {
        height: 15px;
        width: 119px;
        }
        #Text1 {
        height: 14px;
        width: 120px;
        }
    </style> 
