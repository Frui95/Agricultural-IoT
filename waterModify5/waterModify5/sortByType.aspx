<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sortByType.aspx.cs" Inherits="sortByType" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>  
    <title>按模块类型统计</title>  
     <link href="style/easyui/easyui.css" rel="stylesheet" />
    <link href="style/easyui/icon.css" rel="stylesheet" />
    <link href="style/easyui/demo.css" rel="stylesheet" />  
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="js/awesomechart.js"></script>
    <link href="style/base.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
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
</head><body>
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
    var markerArr =<%getType();%>;

    var chart1 = new AwesomeChart('chartCanvas1');
    chart1.title = "按模块类型统计";
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
    chart1.labels = ['只报警', '液位及报警'];
    chart1.colors = ['#006CFF', '#FF6600'];
    chart1.randomColors = true;
    chart1.draw();


    var chart2 = new AwesomeChart('chartCanvas2');
    chart2.chartType = "pie";
    chart2.title = "按模块类型统计";
    chart2.data = [j,h];
    chart2.labels = ['只报警', '液位及报警'];
    chart2.colors = chart1.colors;
    chart2.draw();
</script>
