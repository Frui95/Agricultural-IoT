<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testSortByTime.aspx.cs" Inherits="testSortByTime" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>按丢失时间统计</title>
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
<script type="text/javascript">

    var chart1 = new AwesomeChart('chartCanvas1');
    chart1.title = "按丢失时间统计";
    chart1.data = [51.62, 31.3, 10.06, 4.27, 1.96, 0.78];
    chart1.labels = ['0:00-4:00', '4:00-8:00', '20:00-24:00', '16:00-20:00', '8:00-12:00', '12:00-16:00'];
    chart1.colors = ['#006CFF', '#FF6600', '#34A038', '#945D59', '#93BBF4', '#F493B8'];
    chart1.randomColors = true;
    chart1.draw();



   

    var chart7 = new AwesomeChart('chartCanvas2');
    chart7.chartType = "ring";
    chart7.title = "按丢失时间统计";
    chart7.data = [51.62, 31.3, 10.06, 4.27, 1.96, 0.78];
    chart7.labels = ['0:00-4:00', '4:00-8:00', '20:00-24:00', '16:00-20:00', '8:00-12:00', '12:00-16:00'];
    chart7.colors = chart1.colors;
    chart7.randomColors = true;
    chart7.draw();

</script>

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
