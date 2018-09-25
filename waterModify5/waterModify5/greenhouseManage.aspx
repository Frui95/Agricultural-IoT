<%@ Page Language="C#" AutoEventWireup="true" CodeFile="greenhouseManage.aspx.cs" Inherits="greenhouseManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>灌溉控制</title>
    <link href="style/easyui/easyui.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/demo.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/icon.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="js/moment.js" type="text/javascript"></script>
    <style type="text/css">
        #fm {
            margin: 0;
            padding: 10px 30px;
        }

        .ftitle {
            font-size: 14px;
            font-weight: bold;
            padding: 5px 0;
            margin-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }

        .fitem {
            margin-bottom: 5px;
        }

            .fitem label {
                display: inline-block;
                width: 80px;
            }
    </style> 
</head>
<body style="margin:0px;padding:0px;">
  
    <div style="margin-top: 0px;width:100%;" align="center">
        <table id="dg" title="操作日志" class="easyui-datagrid" style="width: auto; height: 450px"
            url="ajax/get_ctr.ashx" toolbar="#toolbar" pagination="true"
            rownumbers="true" fitcolumns="true" singleselect="true">
            <thead>
                <tr>
                    
                    <th data-options="field:'日期',width:80">日期</th>
                    <th data-options="field:'阀门开启时刻',width:50">阀门开启时刻</th>
                    <th data-options="field:'阀门关断时刻',width:50">阀门关断时刻</th>
                    <th data-options="field:'灌溉时长',width:25">时长(minutes)</th>
                    <th data-options="field:'操作员',width:30">操作员</th>
                    <th data-options="field:'symbol',width:30">标识</th>
                    

                </tr>
            </thead>
        </table>  
    
    </div>
    <div id="win" class="easyui-window" title="土壤状况" style="width:300px;height:180px;" data-options="modal:false">
	<form style="padding:10px 20px 10px 40px;">
		<p>土壤水分: <input id="water" type="text" disabled="disabled" value="0"/></p>
		<p>电 导 率:&nbsp; <input id="diandao" type="text" disabled="disabled" value="0"/></p>
		<div style="padding:5px;text-align:center;">
			<a id="btn" href="#" class="easyui-linkbutton" icon="icon-ok">Ok</a>
			
		</div>
	</form>
</div>



        <div id="toolbar">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-add" plain="true" onclick="newCtr()">添  加</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-edit" plain="true" onclick="editCtr()">编  辑</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-remove" plain="true" onclick="destroyCtr()">删  除</a>
        </div>
         <%--添加用户信息--%>
    <div id="dlg" class="easyui-dialog" style="width:420px;height:330px;padding:10px 20px"  
            closed="true" buttons="#dlg-buttons">  

        <div class="ftitle">操作表</div>  
         <form id="fm" method="post" novalidate="novalidate">
             <%--<div class="fitem">  
                <label>用户编号：</label>  
                <input name="user_Name" class="easyui-validatebox" required="true">  
            </div> --%>
             <%--<div class="fitem">
                 <label>电导率:</label>
                 <input name="user_Name" class="easyui-validatebox" required="true" />
             </div>--%>  

            <div class="fitem">  
                <label>日 期:</label>  
                <input name="ctr_Date" id="dd" type="text" class="easyui-datebox" required="required" />
                <%-- <select class="easyui-combobox"  panelHeight="auto" name="Role" style="width:130px;class= "easyui-validatebox" required="true"> 
                     <option value="0">系统管理员</option>  
                     <option value="1">普通用户</option>  
                     <option value="2">超级用户</option>  
                      
                 </select>  --%>

               
            </div>

            <div class="fitem">  
                <label>阀门开启时刻:</label>  
                <input name="ctr_Start" id="ss" class="easyui-timespinner" style="width: 119px;" required="required" data-options="min:'01:00',showSeconds:true" />
            </div>  
            
            <div class="fitem">  
                <label>阀门关断时刻:</label>  
                <input name="ctr_Close" id="ss1" class="easyui-timespinner" style="width: 119px;" required="required" data-options="min:'01:00',showSeconds:true" />
            </div>

            <div class="fitem">  
                <label>时 长(min):<br />
                <br />
                </label>  
                &nbsp;<input id="drag" name="ctr_Temperal" class="easyui-slider" value="10" style="width:300px" data-options="min:0,max:60,step:1, showTip:true,rule:[0,'|',60],tipFormatter:function(value){return value+'分钟';},onChange: function(value){
                  var p = moment().add('minutes',value).format('HH:mm:ss'); 
                    $('#ss1').timespinner('setValue',p);
                      }" />
                <br />
                <br />
            </div>  
              
            <div class="fitem">  
                <label>操作员:</label>  
                <input name="ctr_User" class="easyui-validatebox" required="required"/>  
            </div> 
             </form> 
         </div>
    <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCtr()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>  
    </div>  
             
   <%--网页中用到的函数的js文件--%>
    <div  id="myDiv"> </div>
    <%--页面加载时间--%>
    <script type="text/javascript">
        $(function () {
            $('#dg').datagrid('load', {
                timestamp: new Date().getTime()
            });
        })

        $.fn.datebox.defaults.formatter = function(date){
            	var y = date.getFullYear();
            	var m = date.getMonth()+1;
            	var d = date.getDate();
            	return y+'-'+m+'-'+d;
        }

        $(function () {
            var now=moment().format('HH:mm:ss'); //2014-09-24 23:36:09 
            $('#ss').timespinner('setValue', now);
            //alert($('#drag').slider('getValue'));
        })

        //function addTime(){
        //    var per = $('#drag').slider('getValue');
        //    alert(per);
        //    var p = moment().add('minutes',per).format('HH:mm:ss'); 
        //    $('#ss1').timespinner('setValue', '17:45');  // set timespinner value
        //}
       


        var url;
        function newCtr() {
            $('#dlg').dialog('open').dialog('setTitle', '添加新操作');
            $('#fm').form('clear');
            url = 'ajax/process_ctr.aspx?mode=0'; //mode=0为新建
        }


        function saveCtr() {
            $('#fm').form('submit', {
                url: url,
                onSubmit: function () {
                    return $(this).form('validate');
                   
                },
                success: function (result) {
                    if (result == "0") {

                        $.messager.alert('提示', '已成功保存!');
                        setctrl();
                        $('#dlg').dialog('close');      // close the dialog  
                        $('#dg').datagrid('load', {
                            timestamp: new Date().getTime()
                        });


                        //                        $('#dg').datagrid('reload');    // reload the user data  
                    }
                    else {
                        $.messager.alert('错误', '保存出现错误!');
                    }
                }
            });
        }

        

        function destroyCtr() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $.messager.confirm('确认', '确定删除选中行?', function (r) {
                    if (r) {
                        $.get('ajax/process_ctr.aspx', { symbol: row.symbol, mode: '2' }, function (result) {
                            if (result == "1") {

                                $.messager.alert('提示', '已成功删除!');
                                $('#dg').datagrid('load', {
                                    timestamp: new Date().getTime()
                                });
                            }
                            else {
                                $.messager.alert('错误', '删除出现错误!');
                            }
                        });
                    }
                });
            }
        }
        function setctrl() {
            //var opentime = new String;
             var opentime = document.getElementById('ss').value;
            //var constime = new String;
              var constime = document.getElementById('drag').value;
            $.post(
                url = 'ajax/UDPSenderHandler.ashx',
                {opt:opentime,cons:constime}

            );
            alert(opentime);
        }


        function editCtr() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $('#dlg').dialog('open').dialog('setTitle', '修改控制日志');
                $('#fm').form('load', row);
                url = 'ajax/process_ctr.aspx?mode=1&symbol=' + row.symbol;
            }
        }
        setInterval(myfunc(),50000);
        function myfunc() {
            $.ajax({
                type: 'post',
                url: 'ajax/get_HumLand.ashx',
                cache: false,
                success: function (data) {
                    var jsonD = eval("(" + data + ")");
                    var lasthum = new Number;
                    if (jsonD.length > 0) {
                        lasthum = jsonD[jsonD.length - 1].landhum;
                    }
                    document.getElementById('water').value = lasthum + '%';
                }, error: function () { document.getElementById('water').value = "请求失败！"; }
            })
            $.ajax({
                type: 'post',
                url: 'ajax/get_conductance.ashx',
                cache: false,
                success: function (data) {
                    var jsonD = eval("(" + data + ")");
                    if (jsonD.length > 0) {
                        lastcon = jsonD[jsonD.length - 1].conductance;
                    }
                    document.getElementById('diandao').value = lastcon + 'mS/cm';
                }, error: function () { document.getElementById('diandao').value = "请求失败！"; }
            })
        }


        $(function () {

            $('#btn').bind('click', function () {
               
                $('#win').window('close');
            });


        })

    </script>
</body>
</html>
