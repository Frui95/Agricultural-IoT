<%@ Page Language="C#" AutoEventWireup="true" CodeFile="roleManage.aspx.cs" Inherits="grid" %>
<%--用户权限管理页面--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <%--采用easyui开源代码，在head中引入需要引用的js文件--%>
<head>  
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>   
    <title>权限管理</title>  
    <link href="style/easyui/easyui.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/demo.css" rel="stylesheet" type="text/css" />
    <link href="style/easyui/icon.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
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
    <%--body中编写详细的网页显示内容，并对相应的函数进行实例编写--%>
<body  style="margin:0px;padding:0px;">  
     <%--网页的头部div显示页面位置和网页标题--%>
   <%-- <div style="border-bottom: 1px solid #A3B4C8;height:35px;background-image: url(images/top_bg.gif)">
        <img src="images/navigation-right.png" style="height: 26px; width: 24px; overflow:hidden"/>&nbsp;
         <span style="padding-bottom:10px">用户权限管理</span>
	</div>--%>

    <%--页面主体，通过url="ajax/get_users.aspx"加载json数据，填充datagrid内容--%>
     <div style="margin-top: 0px;width:100%;" align="center">
    <table id="dg" title="用户列表" class="easyui-datagrid" style="width:auto;height:500px"  
            url="ajax/get_users.aspx"  toolbar="#toolbar" pagination="true"  
            rownumbers="true" fitColumns="true" singleSelect="true">  
        <thead>  
            <tr>  
                <%--<th data-options="field:'user_ID',width:80">用户编号</th>--%>
				<th data-options="field:'user_Name',width:80">用户名</th>
				<th data-options="field:'Role',width:100">权限</th>
                <th data-options="field:'user_PWD',width:80">密码</th>
                <th data-options="field:'user_phone',width:80">电话</th>
				<th data-options="field:'user_company',width:100">公司</th>
                <th data-options="field:'user_email',width:80">邮箱</th>

            </tr>  
        </thead>  
    </table>  
    </div>
    <div id="toolbar">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添  加</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编  辑</a>  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删  除</a>  
   </div>

      <%--添加用户信息--%>
    <div id="dlg" class="easyui-dialog" style="width:420px;height:330px;padding:10px 20px"  
            closed="true" buttons="#dlg-buttons">  

        <div class="ftitle">用户信息</div>  
         <form id="fm" method="post" novalidate="novalidate">
             <%--<div class="fitem">  
                <label>用户编号：</label>  
                <input name="user_Name" class="easyui-validatebox" required="true">  
            </div> --%>
            <div class="fitem">  
                <label>用户名:</label>  
                <input name="user_Name" class="easyui-validatebox" required="true"/>  
            </div>  

            <div class="fitem">  
                <label>权限:</label>  
                 <select class="easyui-combobox"  panelHeight="auto" name="Role" style="width:130px;class= "easyui-validatebox" required="true"> 
                     <option value="0">系统管理员</option>  
                     <option value="1">普通用户</option>  
                     <option value="2">超级用户</option>  
                      
                 </select>  

               
            </div>

            <div class="fitem">  
                <label>密  码:</label>  
                <input name="user_PWD" class="easyui-validatebox" required="true"/>  
            </div>  
            
            <div class="fitem">  
                <label>电  话:</label>  
                <input name="user_phone"/>  
            </div>

            <div class="fitem">  
                <label>公  司:</label>  
                <input name="user_company" class="easyui-validatebox"/>  
            </div>  
              
            <div class="fitem">  
                <label>邮  箱:</label>  
                <input name="user_email" class="easyui-validatebox" validType="email"/>  
            </div>  
             </form>
    </div>  
    <div id="dlg-buttons">  
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>  
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


           var url;
           function newUser() {
               $('#dlg').dialog('open').dialog('setTitle', '添加新用户');
               $('#fm').form('clear');
               url = 'ajax/save_user.aspx?mode=0'; //mode=0为新建用户
           }

           function editUser() {

               var row = $('#dg').datagrid('getSelected');
               if (row) {
                   $('#dlg').dialog('open').dialog('setTitle', '编辑用户信息');
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
 <%--<style type="text/css">  
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
    </style> --%>
</html>