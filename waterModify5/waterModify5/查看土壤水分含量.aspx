<%@ Page Language="C#" AutoEventWireup="true" CodeFile="查看土壤水分含量.aspx.cs" Inherits="查看土壤水分含量" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>当日土壤水分</title>
    <link href="style/easyui/easyui.css" rel="stylesheet" />
    <link href="style/easyui/icon.css" rel="stylesheet" />
    <link href="js/bootstrap.min.css" rel="stylesheet" />
    <link href="js/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="style/easyui/demo.css" rel="stylesheet" />
    <link href="style/buttons.css" rel="stylesheet" />
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bootstrap-datetimepicker.min.js"></script>
    <script src="js/echarts.min.js"></script>
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
    <fieldset style="text-align: left">
        <legend style="text-align: left">室内空气温度</legend>
        <label for="Select2">节点编号：</label>
        <select id="Select2" style="width: 60px;" required="required">
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
    var myChart = echarts.init(document.getElementById('container'));
    function Button() {
        var nodes_id = $('#Select2').val();
        var textval;

        //alert('请求的数据:' + date1 + ',' + date2 + ',' + valdata);
        url = 'ajax/get_HumLand.ashx?nodes_id=' + nodes_id;
        myChart.showLoading();
        $.ajax({
            type: "get",
            url: url,
            cache: false,
            success: function (data) {
                if (data) {
                    //console.log(data);
                    myChart.hideLoading();
                }
                var jsonD = eval("(" + data + ")");
                //console.log(jsonD);
                //console.log('json数组长度:'+jsonD.length);
                if (jsonD.length > 0) {
                    var timearray = new Array();
                    var dataarray = new Array();
                    for (i = 0; i < jsonD.length; i++) {
                        var rows = jsonD[i];
                        var time = rows.time;
                        // console.log(valdata);
                        //var selecdata = rows.col;

                        //console.log(time);
                        //console.log(selecdata);
                        timearray[i] = rows.time;
                        dataarray[i] = rows.landhum;
                    }
                    //console.log(timearray);
                    //console.log(dataarray);
                    option = {
                        tooltip: {
                            trigger: 'axis',
                            position: function (pt) {
                                return [pt[0], '10%'];
                            }
                        },
                        title: {
                            left: 'center',
                            //text: '大数据量折线图',
                            text:
                               '当日土壤水分',



                        },
                        legend: {
                            top: 'bottom',
                            data: ['意向']
                        },
                        toolbox: {
                            show: true,
                            feature: {
                                dataView: { show: true, readOnly: false },
                                magicType: { show: true, type: ['line', 'bar', 'stack', 'tiled'] },
                                restore: { show: true },
                                saveAsImage: { show: true }
                            }
                        },
                        xAxis: {
                            type: 'category',
                            boundaryGap: false,
                            data: timearray
                        },
                        yAxis: {
                            type: 'value',
                            boundaryGap: [0, '100%']
                        },
                        dataZoom: [{
                            type: 'inside',
                            start: 0,
                            end: 100
                        }, {
                            start: 0,
                            end: 10
                        }],
                        series: [
                            {
                                name: '土壤水分(%)',
                                type: 'line',
                                smooth: true,
                                symbol: 'none',
                                sampling: 'average',
                                itemStyle: {
                                    normal: {
                                        color: 'rgb(255, 70, 131)'
                                    }
                                },
                                areaStyle: {
                                    normal: {
                                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                            offset: 0,
                                            color: 'rgb(255, 158, 68)'
                                        }, {
                                            offset: 1,
                                            color: 'rgb(255, 70, 131)'
                                        }])
                                    }
                                },
                                data: dataarray
                            }
                        ]
                    };
                    myChart.setOption(option);
                }
            }, error: function () { alert("404 请求服务失败！"); }

        });
    }
</script>
