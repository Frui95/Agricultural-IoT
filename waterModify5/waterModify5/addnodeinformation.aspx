<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addnodeinformation.aspx.cs" Inherits="addnodeinformation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>节点信息管理</title>
    <script src="../js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../js/Accordion.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
</head>
<body>
    <form id="form1" runat="server"></form>
    <div>
    </div>
    <table id ="node" title ="节点信息" class ="easyui-datagrid" style ="width:1000px;height :400px;"url="ajax/leveldata.ashx" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="BarCode" width="30" rowspan ="2">节点编号</th>
                <th field="BarCode" width="30"rowspan="2">节点类型</th>
                <th colspan ="2">位置信息</th>
                <th field="Boolean" width="30" rowspan ="2">工作状况</th>
            </tr>
            <tr>
                <th field="Longitude" width="30">经度</th>
                <th field="Latitude" width="30">纬度</th>
                
             </tr>
            </thead>
    </table>
    <div id ="toolbar">
        <a href ="javascript:void(0)" class ="easyui-linkbutton" iconCls="icon-edit" plain="true"onclick="newUser()">添加节点信息</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑信息</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除信息</a>
        
    </div>
    <div id ="dlg" class="easyui-dialog" style ="width:400px;height:250px;padding :10px 20px;"closed="true"buttons="#dlg-buttons">
        <div class ="ftitle">节点信息管理:</div>
        <form id="fm" method ="post" novalidate>
            <div class ="fitem">
                <label>节点编号：</label>
                <input name ="BarCode" class ="easyui-validatebox" require="true">
             </div>
            <div class ="fitem">
                <label>节点类型：</label>
                <input name ="BarCode" class ="easyui-validatebox" require="true">
             </div>
            <div  class ="fitem">
                <label>经度：</label>
                <input name ="longitude" class="easyui-validatebox" require="true">
                </div>
            <div class ="fitem">
                <label>纬度：</label>
                <input name ="latitude" class ="easyui-validatebox" require="true">
                </div>
            <div class="fitem">
                <label>工作状况：</label>
                <input name ="Location" class ="easyui-validatebox" require="true">
                </div>
            </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
    <script type ="text/javascript" >
        var url; //定义地址备用
        $(function () {
            $('#node').datagrid('load', { timestamp: new Date().getTime() });
        })

        function newUser() {
            $('#dlg').dialog('open').dialog('setTitle', '添加新的节点信息');
            $('#fm').form('clear');
            url = 'ajax/save_wellinfo.aspx?mode=0'; //mode=0为新建节点
        }
        function editUser() {
            var row = $('#dg').datagrid('getSelected');//返回第一个被选择的行记录
            if (row) {
                $('#dlg').dialog('open').dialog('setTitle', '编辑节点信息');
                $('#fm').form('load', row);
                url = 'ajax/save_wellinfo.aspx?mode=1&userid=' + row.BarCode;
            }
        }
        //保存用户函数
        function saveUser() {
            $('#fm').form('submit', {
                url: url,
                onSubmit: function () {
                    return $(this).form('validate');
                },
                success: function (result) {
                    if (result == "0") {

                        $.messager.alert('提示', '已成功保存!');

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
        //删除用户信息函数
        function destroyUser() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $.messager.confirm('确认', '确定删除选中行?', function (r) {
                    if (r) {
                        $.get('ajax/save_wellinfo.aspx', { userid: row.BarCode, mode: '2' }, function (result) {
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
    </style> 
    </body>
</html>
</body>
</html>
