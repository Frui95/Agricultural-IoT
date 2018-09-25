<%@ Page Language="C#" AutoEventWireup="true" CodeFile="查询历史数据.aspx.cs" Inherits="查询历史数据" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>历史数据查询</title>
    <link href="style/easyui/easyui.css" rel="stylesheet" />
    <link href="style/easyui/icon.css" rel="stylesheet" />
    <link href="js/bootstrap.min.css" rel="stylesheet" />
    <link href="js/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="style/easyui/demo.css" rel="stylesheet" />
    <link href="style/buttons.css" rel="stylesheet" />
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bootstrap-datetimepicker.min.js"></script>
    <script src="js/echarts.min.js"></script>
    <style>
     #datetimepicker2{
            cursor:pointer;
        }
     #datetimepicker1{
         cursor:pointer;
     }
     #Select1{
         cursor:pointer;
     }
    </style>
</head>  
<body style="text-align:center">
    <div id="toolbar">
        
        <fieldset style="text-align:match-parent">
            <legend style="text-align:left">历史数据查找</legend>
            
                <label for="datetimepicker1">起始日期:</label><input id="datetimepicker1" class= "easyui-validatebox easyui-textbox" type="text" style="width: 120px"  readonly="true"/>
                <label for="datetimepicker2">截止日期:</label><input id="datetimepicker2"class= "easyui-validatebox easyui-textbox" type="text" style="width: 120px"  readonly="true"/>
                <label for="Select1">数据类型:</label><select id="Select1"  panelheight="auto" style="width: 120px" required="required">
                    <option value="airtemper">空气温度</option>
                    <option value="airhum">空气湿度</option>
                    <option value="landhum">土壤湿度</option>
                    <option value="light">光照强度</option>
                    <option value="conductance">土壤电导率</option>
                </select>
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

                <button id="button" class="button button-glow button-primary button-pill button-tiny " onclick="Button()">查找</button>
        </fieldset>
        <div >
            <div id="main" style="min-width: 700px; height: 400px;"></div>
        </div>
    </div>
   
</body>
</html>
<script type="text/javascript">
   
    $('#datetimepicker1').datetimepicker({
        format: 'yyyy-mm-dd hh:ii'
    });
    $('#datetimepicker2').datetimepicker({ format: 'yyyy-mm-dd hh:ii', todayBtn: true,  });
    var myChart = echarts.init(document.getElementById('main'));
    function Button() {
        var date1 = $('#datetimepicker1').val();
        var date2 = $('#datetimepicker2').val();
        var valdata = $('#Select1').val();
        var nodes_id = $('#Select2').val();
        var textval;
        switch (valdata) {
            case 'airtemper':
                textval = '空气温度（℃）';
                break;
            case 'airhum':
                textval = '空气湿度（%）';
                break;
            case 'landhum':
                textval = '土壤湿度（%）';
                break;
            case 'light':
                textval = '光照强度（Lux）';
                break;
            case 'conductance':
                textval = '土壤电导率（mS/cm）';
                break;
        }
        //alert('请求的数据:' + date1 + ',' + date2 + ',' + valdata);
        url = 'ajax/infosearch.aspx?begintime=' + date1 + '&endtime=' + date2 + '&oneoffivedata=' + valdata+ '&nodes_id=' +nodes_id;
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
                        var time = rows.Column1;
                       // console.log(valdata);
                        var selecdata = rows.col;

                        //console.log(time);
                        //console.log(selecdata);
                        timearray[i] = rows.Column1;
                        dataarray[i] = rows.col;
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
                               textval,
                                   

                          
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
                            end: 10
                        }, {
                            start: 0,
                            end: 10
                        }],
                        series: [
                            {
                                name: '数据',
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