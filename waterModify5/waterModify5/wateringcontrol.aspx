<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wateringcontrol.aspx.cs" Inherits="wateringcontrol" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>环境参数修改—土壤湿度</title>
    <link href="style/easyui/easyui.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/demo.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/icon.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
</head>
<body style="margin:0px;padding :0px;">
    <form id="form1" runat="server"></form>
    <div style ="margin-top:0px;width :100%";align="center;">
        <table id="topdg" title="灌溉计划配置表" class ="easyui-datagrid" style="width:1000px;height :450px;" url="#" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
            <thead>
                <tr>
                    <th data-options ="field:'start_Time',width:80">预设浇水开始时间</th>
                    <th data- options="field:'end_Time',width:80">预设浇水结束时间</th>
                    <th data- options="field:'control_Model',witdh:80">灌溉模型</th>
                </tr>
            </thead>
        </table>
     </div>
    <div id="toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添  加</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编  辑</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删  除</a>
    </div>
       
        <div id="dg" class="easyui-dialog" style ="height :330px;width :420px;padding:10px 20px"closed="true" buttons="#dlg-buttons">
            <div class="ftitle">湿度控制配置单</div>
            <form id="fm" method="post" novalidate >
                <div class ="fitem">
                    <label>预设浇水开始时间</label>
                    <input name="start_Time" class ="easyui-datetimebox" data-options="required:true,showSeconds:false">

                </div>
                <div class ="fitem ">
                    <label>预设浇水结束时间</label>
                    <input name ="end_Time" class ="easyui-datetimebox" data-options="required:true,showSeconds:false" >
                 </div>
                <div class ="fitem ">
                    <label>灌溉控制模型</label>
                    <select class ="easyui-combobox" panelHeight="auto" name="control_Model" required ="true">
                        <option value ="0">不应用模型</option>
                        <option value ="1">应用模型</option>
                     </select>
                    </div>
            </form>
        </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
    
</body>
    
    <%--网页中用到的函数的js文件--%>
    <div  id="myDiv"> </div>
    <%--页面加载时间--%>
    <body>
       <script type="text/javascript">
           $(function () {
               $('#topdg').datagrid('load', {
                   timestamp: new Date().getTime()
               });
           })


           var url;
           function newUser() {
               $('#dg').dialog('open').dialog('setTitle', '添加新配置');
               $('#fm').form('clear');
               url = 'ajax/save_user.aspx?mode=0'; //mode=0为新建配置
           }

           function editUser() {

               var row = $('#dg').datagrid('getSelected');
               if (row) {
                   $('#dlg').dialog('open').dialog('setTitle', '编辑配置信息');
                   $('#fm').form('load', row);
                   url = 'ajax/save_user.aspx?mode=1&userid=' + row.user_Name;
               }
           }


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





           function destroyUser() {
               var row = $('#dg').datagrid('getSelected');
               if (row) {
                   $.messager.confirm('确认', '确定删除选中行?', function (r) {
                       if (r) {
                           $.get('ajax/save_user.aspx', { userid: row.user_Name, mode: '2' }, function (result) {
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
  </body>  
<head>
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
    </head>
</html>
