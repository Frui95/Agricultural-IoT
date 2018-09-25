<%@ Page Language="C#" AutoEventWireup="true" CodeFile="levelsearch.aspx.cs" Inherits="levelsearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     
    <title>液位信息查询查询</title>  
    <link href="style/easyui/easyui.css" rel="stylesheet" />
    <link href="style/easyui/icon.css" rel="stylesheet" />
    <link href="style/easyui/demo.css" rel="stylesheet" />  
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/jquery.easyui.min.js" type="text/javascript"></script>
</head>
<body>
    <div style="margin-top: 0px;width:100%;" align="center">
    <table id="dg" title="液位查询" class="easyui-datagrid" style="width:750px;height:600px"  
            url="ajax/searchlev.aspx"  toolbar="#toolbar" pagination="true"  
            rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="well_Address" width="50">井盖短地址</th>
                <th field="levInfo" width="50">液位信息</th>
                <th field="Datetime" width="50">信息添加时间</th>
                <th field="well_Status" width="50">井盖状态</th>
            </tr>
        </thead>
    </table>
    </div>
     <%--自定义的工具栏，包括相应的查询条件--%>
    <div id="toolbar">  
        井盖短地址:<input id="Text1" type="text" style="width:120px"/>
        液位信息:<input id="Text2" type="text" style="width:120px"/>
        井盖故障状态: <select id="Select1" class="easyui-combobox" panelHeight="auto" style="width:120px">
            <option value="">全部</option>
            <option value="0">正常</option>  
            <option value="1">故障</option>  

            </select>

        <div>  
           
            <%--开始时间: <input id="dateBegin" class="easyui-datebox" data-options="onSelect:onSelect,formatter:myformatter,parser:myparser" style="width:120px">--%>  
            最后更新时间: <input id="Datetime" class="easyui-datebox" data-options="onSelect:onSelect,formatter:myformatter,parser:myparser" style="width:120px">&nbsp;&nbsp;&nbsp;&nbsp; 

        <%--搜索按钮--%>
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" dir="ltr" id="search" >查找</a>  
        </div>  
    </div> 
    
    <script type="text/javascript">

        var date1 = '1990-1-1';

        function myformatter(date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            date1 = y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
            return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
        }
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
            //DateBegin = date;

        }
        //定义选择按钮点击事件的响应函数
        $("#search").click(function () {
            //定义相关的查询参数
            var well_Address = $("#Text1").val();
            var levInfo = $("#Text2").val();
            var well_Status = $("#Select1").combobox("getValue");
            //var DateBegin = $("#dateBegin").datebox('getValue');
            var Datetime = $('#Datetime').datebox('getValue');
            //var Datetime = $('#Datetime').val();
           
            //alert(Datetime);
            //alert(DateBegin);

            //$('#dg').datagrid('options').pageNumber = 1;
            //$('#dg').datagrid('getPager').pagination({ pageNumber: 1 });


            $('#dg').datagrid('options').url = 'ajax/searchlev.aspx?well_Address=' + well_Address + '&levInfo=' + levInfo + '&well_Status=' + well_Status + '&Datetime=' + Datetime;
            // $('#dg').datagrid('options').url = 'ajax/get_faultInfo.aspx?faultID='+faultID+'&devType=' + devType + '&devID=' + devID + '&faultTypeCode=' + faultTypeCode + '&faulPartCode=' + faulPartCode + '&faultModeCode=' + faultModeCode + '&isAnalysised=' + isAnalysised + '&rcdDate=' + date1;
            $("#dg").datagrid("reload");//重新加载数据


            //$('#dg').datagrid('options').pageNumber = 1;
            //$('#dg').datagrid('getPager').pagination({ pageNumber: 1 });
            //$('#dg').datagrid('options').url = 'ashx/DepartmentsManagerService.ashx?action=search&hospName=' + hoistalName + '&depName=' + depName;
            //$('#dg').datagrid("reload");
        })



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
    
     
</body>
</html>
