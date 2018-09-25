<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addinfor.aspx.cs" Inherits="addinfor" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>井盖信息</title>
    <script src="../js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../js/Accordion.js" type="text/javascript"></script>
    <meta charset="UTF-8">
   
  <link href="style/easyui/easyui.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/demo.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/icon.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
</head>
<body>
    
    
    
    <div style="margin-top: 0px;width:100%; height: 269px;" align="center">
    <table id="dg" title="井盖信息列表" class="easyui-datagrid" style="width:800px;height:270px"  
            url="ajax/get_wellinfo.aspx"  toolbar="#toolbar" pagination="true"  
            rownumbers="true" fitColumns="true" singleSelect="true">  
        <thead>
            <tr>
                <th field="well_ID" width="50">井盖编号</th>
                <th field="longitude" width="50">经度</th>
                <th field="latitude" width="50">纬度</th>
                <th field="well_Address" width="50">井盖短地址</th>
                <th field="well_Type" width="50">井盖类型</th>
                <th field="well_Status" width="50">井盖状态</th>
                <th field="well_lev" width="50">液位信息</th>
            </tr>
        </thead>
    </table>
        </div>
    <div id="toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加信息</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑信息</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除信息</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px;height:360px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
        <div class="ftitle">井盖信息</div>
        <form  id="fm" method="post" novalidate>
             
        
             <div class="fitem">
                <label>井盖编号:</label>
                <input name="well_ID" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>经度:</label>
                <input name="longitude" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>纬度:</label>
                <input name="latitude" class="easyui-validatebox" required="true">
            </div>
            <div class="fitem">
                <label>井盖短地址:</label>
                <input name="well_Address" class="easyui-validatebox" required="true">
            </div>
             <div class="fitem">  
                <label>井盖类型:</label>  
                 <select class="easyui-combobox"  panelHeight="auto" name="well_Type" style="width:130px;class: "easyui-validatebox" required="true"> 
                     <option value="0">只报警</option>  
                     <option value="1">液位及报警</option>   
                 </select>  
             </div>
             <div class="fitem">  
                <label>模块状态:</label>  
                 <select class="easyui-combobox"  panelHeight="auto" name="well_Status" style="width:130px;class:"easyui-validatebox" required="true"> 
                     <option value="0">正常</option>  
                     <option value="1">异常</option>  
                 </select>  
             </div>
               <div class="fitem">
                <label>液位（无此信息请填-1）</label>
                <input name="well_lev" class="easyui-validatebox" required="true">
            </div> 
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
   
   
    <script type="text/javascript">
        $(function () {
            $('#dg').datagrid('load', {
                timestamp: new Date().getTime()
            });
        })


        var url; //定义地址备用
        
        function newUser() {
            $('#dlg').dialog('open').dialog('setTitle', '添加新井盖');
            $('#fm').form('clear');
            url = 'ajax/save_wellinfo.aspx?mode=0'; //mode=0为新建井盖
        }
        //编辑井盖信息
        function editUser() {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                $('#dlg').dialog('open').dialog('setTitle', '编辑井盖信息');
                $('#fm').form('load', row);
                url = 'ajax/save_wellinfo.aspx?mode=1&userid=' + row.well_ID;
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
                        $.get('ajax/save_wellinfo.aspx', { userid: row.well_ID, mode: '2' }, function (result) {
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



     
    
