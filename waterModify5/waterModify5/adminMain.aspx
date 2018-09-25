<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminMain.aspx.cs" Inherits="adminMain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    
    <title>温室园艺作物智能化监控平台</title>
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="js/Accordion.js" type="text/javascript"></script>
    <link href="style/easyui/easyui.css" rel="stylesheet" />
    <link href="style/easyui/icon.css" rel="stylesheet" />
    <link href="style/easyui/demo.css" rel="stylesheet" />
   
    <script src="js/jquery-1.9.1.js" type="text/javascript"></script>
    <script  src="js/jquery.easyui.min.js" type="text/javascript"></script>

    <%--管理员主界面--%>
<script type="text/javascript">


    ddaccordion.init({
        headerclass: "submenuheader", //Shared CSS class name of headers group
        contentclass: "submenu", //Shared CSS class name of contents group
        revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
        mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
        collapseprev: true, //Collapse previous content (so only one open at any time)? true/false 
        defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
        onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
        animatedefault: false, //Should contents open by default be animated into view?
        persiststate: true, //persist state of opened contents within browser session?
        toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
        togglehtml: ["suffix", "<img src='images/plus.png' class='statusicon' />", "<img src='images/minus.png' class='statusicon' />"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
        animatespeed: "fast" //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
        //        oninit: function (headers, expandedindices) { //custom code to run when headers have initalized
        //            mainiframe = window.frames["mainiframe"]
        //            if (expandedindices.length > 0) //if there are 1 or more expanded headers
        //                mainiframe.location.replace(headers[expandedindices.pop()].getAttribute('href')) //Get "href" attribute of final expanded header to load into IFRAME
        //        }
        //        onopenclose: function (header, index, state, isuseractivated) { //custom code to run whenever a header is opened or closed
        //            if (state == "block" && isuseractivated == true) { //if header is expanded and as the result of the user initiated action
        //                mainiframe.location.replace(header.getAttribute('href'))
        //            }
        //        }
    })


</script>
<style type="text/css">

.glossymenu{
padding: 0;
width: 100%; /*width of menu*/
cursor:pointer;
}

.glossymenu a.menuitem{
background:  url(images/NavBarBg.gif) repeat-x bottom left;
font-family:Tahoma;
font-size:13px;
color: #283B56;
display: block;
position: relative; /*To help in the anchoring of the ".statusicon" icon image*/
width: auto;
margin:0 0 1px 0;
padding-left: 10px;
padding-top: 6px;
text-decoration: none;
border:1px solid #AECAF0;
height:20px;
cursor:pointer;
}


.glossymenu a.menuitem:visited, .glossymenu .menuitem:active{
color: white ;
cursor:pointer;
}

.glossymenu a.menuitem .statusicon{ /*CSS for icon image that gets dynamically added to headers*/
position: absolute;
top: 5px;
right: 5px;
border: none;
cursor:pointer;
}

.glossymenu a.menuitem:hover{
background-image: url(images/NavBarHoverBg.gif);
cursor:pointer;
}

.glossymenu div.submenu{ /*DIV that contains each sub menu*/
background: #F2F8FF;
cursor:pointer;
}

.glossymenu div.submenu ul{ /*UL of each sub menu*/
list-style-type: none;
margin: 0;
padding: 0;
cursor:pointer;
}

.glossymenu div.submenu ul li
{
    border-style:solid;
    border-width:0px 1px 1px 1px;
    border-color:#AECAF0;
    cursor:pointer;
}

.glossymenu div.submenu ul li a{
display: block;
font: normal 13px "Lucida Grande", "Trebuchet MS", Verdana, Helvetica, sans-serif;
color: #283B56;
text-decoration: none;
padding: 2px 0;
padding-left: 10px;
height:20px;
cursor:pointer;
}

.glossymenu div.submenu ul li a:hover{
background: #FFEC8B;
cursor:pointer;
}

.glossymenu div.submenu ul li a:visited{
    color:gray;
}



</style>
</head>
<body style="width: 100%;height:auto; background-color: #BDBDBD;overflow :scroll;margin:0px;padding:0px;">
    <form id="form1" runat="server" style="width: 100%;height:100%;">
    <div style="width:100%;height:100%;" >
        <div style="border-bottom: 3px solid #FF8C00; height: 92px; width: 100%; background-color: #F0F0F0; clear: both;">
            <div style="background-image: url(images/repeat.png); background-position: 0px -91px; height: 60px; width: 100%; clear: both;">

                <div style="float: left; border-left: 0px hidden #3362A6; border-right: 0px outset #3362A6; border-top: 0px hidden #3362A6; border-bottom: 1px hidden #4F94CD; height: 60px; width: 100%; background-color:#3b5998 !important;">
                    <span style="float: left; display: inline-block; padding: 10px; height: 60px; overflow: hidden; color: #FFFFFF; font-size: 40px; font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif; font-weight: bold; vertical-align: middle; font-style: oblique; width: 172px; text-align: center; position: absolute;">
                    SJTU</span>
                    
                    <span style="float: left; display: inline-block; padding: 10px; height: 60px; overflow: hidden; color: #FFFFFF; font-size: 40px; font-family: 宋体; font-weight: bold; vertical-align: middle; width: 1078px; text-align: center; position: absolute; top: -1px; left: 173px;">温 室 园 艺 作 物 智 能 化 监 控 平 台</span>


                </div>


            </div>
            <div style="padding: 5px; border: 0px solid #ddd; margin:auto; height: 25px; background: url(images/toolbar.png)  repeat;"data-options="region:'north'">
                <div style="float: left; vertical-align: super; padding: 3px">
                    <a href="SuperMain.aspx" class="easyui-linkbutton" data-options="plain:true" style="color:white;font-size:larger; font-family: 宋体; font-weight: bold;">Ⅰ回到首页</a>
                    <%--<a href="addnodeinformation.aspx"target="_blank"  class="easyui-linkbutton" data-options="plain:'true',iconCls:'icon-edit'" style="color:white">Ⅱ节点信息管理</a>--%>
                    <a href="videocam.aspx" target="iframe_a" class="easyui-linkbutton" data-options="plain:'true'," style="color:white;font-size:larger; font-family: 宋体; font-weight: bold;">Ⅱ视频监视</a>
                    <a href="userhelp.aspx" class="easyui-linkbutton" data-options="plain:true" style="color:white;font-size:larger; font-family: 宋体; font-weight: bold;">Ⅲ使用说明</a>
                    <a href="查询历史数据.aspx" target="iframe_a" class="easyui-linkbutton" data-options="plain:true" style="color:white;font-size:larger; font-family: 宋体; font-weight: bold;">Ⅳ历史数据查询</a>
                    <a href="#" target="iframe_a" class="easyui-linkbutton" data-options="plain:true" style="color:white;font-size:larger; font-family:'Times New Roman'; font-weight: bold;">Leap Motion</a> 
                </div>
                <div style="float: right; vertical-align: super; padding: 3px"><a href="login.aspx" class="easyui-linkbutton" data-options="plain:'true',iconCls:'icon-edit'" style="color:white;font-size:larger; font-family: 宋体; font-weight: bold;">注销登录</a></div>
            </div>
           
            <%--<div style="width: 100%; height: 35px; background-color: #F0F0F0; border-bottom-style: outset; border-bottom-width: 3px; border-bottom-color: #FF7F24; padding-top: 3px;">  </div>--%>
            <%--下半部窗口--%>
            <div id="downbox" style="height:600px; clear: both;" class="easyui-layout">
                <%--左侧导航栏--%>
                <div id="cebian" style="width: 210px; vertical-align: top; display: inline-block; height: 80%; padding: 4px; background: #F2F8FF;overflow-x:hidden"data-options="region:'west',split:true" >
                    <div class="glossymenu">
                        <a class="menuitem submenuheader">温室概况</a>
                        <div class="submenu">
                            <ul>
                                <li><a href="金山温室图.aspx" target="iframe_a">温室地图概览</a></li>
                            </ul>
                        </div>
                        <a class="menuitem submenuheader">温室环境信息</a>
                        <div class="submenu">
                            <ul>
                                <li><a href="查看当日光照.aspx" target="iframe_a">光强</a></li>
                                <li><a href="查询当日气温.aspx" target="iframe_a">温室温度</a></li>                          
                                <li><a href="查看空气水分含量.aspx" target="iframe_a">空气湿度</a></li>
                                <li><a href="查看土壤水分含量.aspx" target="iframe_a">土壤湿度</a></li>                               
                                <li><a href="查看土壤盐分.aspx" target="iframe_a">电导率</a></li>                               
                            </ul>
                        </div>
                        <a class="menuitem submenuheader">温室环境统计</a>
                        <div class="submenu">
                            <ul>
                                <li><a href="KLineLight.aspx" target="iframe_a">光强K线</a></li>
                                <li><a href="KLineAirTemper.aspx" target="iframe_a">温度K线</a></li>                                
                                 <li><a href="KLineHumAir.aspx" target="iframe_a">空气湿度K线</a></li>
                                <li><a href="KLineHumLand.aspx" target="iframe_a">土壤湿度K线</a></li>
                                <li><a href="KLineCon.aspx" target="iframe_a">电导率K线</a></li>
                            </ul>
                        </div>
                        <a class="menuitem submenuheader">温室控制</a>
                        <div class="submenu">

                            <ul>
                                <li><a href="greenhouseManage.aspx" target="iframe_a">温室控制</a></li>
                                <%--<li><a href="testnewline.aspx" target="iframe_a">空气温度</a></li>
            <li><a href="wateringcontrol.aspx" target="iframe_a">土壤温度</a></li>--%>
                                <%--<li><a name="sortByTime.aspx" >按丢失时间统计</a></li>--%>
                                <%--<li><a href="humidity.aspx" target="iframe_a">土壤湿度</a></li>--%>
                            </ul>
                        </div>

                        <%--  <a class="menuitem submenuheader">权限管理</a>
    <div class="submenu">
	    <ul>
	    <li><a name="testline.aspx">权限管理</a></li>
	    </ul>
    </div>--%>

                        <%--<a class="menuitem submenuheader">权限管理</a>--%>
                        <div class="submenu">
                            <ul>
                                <li><a href="roleManage.aspx" target="iframe_a">权限管理</a></li>
                            </ul>
                        </div>

                        <%-- <a class="menuitem submenuheader" >系统复位</a>
    <div class="submenu">
	    <ul>
	    <li><a name="Check.aspx">系统自检</a></li>
        <li><a name="Reset.aspx">异常井盖复位</a></li>
	    </ul>
    </div>--%>


                        <asp:Calendar ID="Calendar1" runat="server" BackColor="#99CCFF" BorderColor="#3399FF" CellPadding="4" DayNameFormat="Full" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px" CssClass="statusicon">
                            <DayHeaderStyle BackColor="#3399FF" Font-Bold="True" Font-Size="7pt" BorderColor="White" ForeColor="Black" />
                            <DayStyle BackColor="#CCFFFF" BorderColor="#66FFCC" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <OtherMonthDayStyle ForeColor="#808080" />
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <WeekendDayStyle BackColor="#FFFFCC" />
                        </asp:Calendar>
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <!--Lable和Timer控件必须都包含在UpdatePanel控件中 -->
                                <asp:Label ID="Label1" runat="server" Text="Label" Font-Size="Large"></asp:Label>
                                <!--用于显示时间-->
                                <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick"></asp:Timer>
                                <!-- 用于更新时间，每1秒更新一次-->
                            </ContentTemplate>
                        </asp:UpdatePanel>


                    </div>
                </div>
                <%-- 右侧iframe嵌入窗口--%>
                <%--<div id="youbian" style="display: initial; float: initial; position: absolute; width: 1059px; height: 90%; padding: 3px; background: #F0F0F0; border-left: 1px solid #6F7E93; top: 99px; left: 208px;"data-options="region:'center'">
                    <iframe id="mainiframe" name="iframe_a" src="金山温室图.aspx" style="border-style: none; border-color: inherit; border-width: medium; width: 100%; height: 89%; margin-left: 11px;" marginheight='0' marginwidth='0' scrolling="no"></iframe>
                </div>--%>
                <div id="youbian" data-options="region:'center'" style="overflow:hidden">
                    <iframe id="mainiframe" name="iframe_a" src="地图OverLay.aspx" style="padding:0; border-style: none; border-color: inherit; border-width: medium; width:100%; height:100%; margin-left:0px;" marginheight='0' marginwidth='0' scrolling="no"></iframe>
                </div>
                <%--<div data-options="region:'center',iconCls:'icon-ok'" title="Center"style="width:724px">--%>
                <div data-options="region:'south'" style="overflow:hidden">
                    <table style="width: 100%; height: 35px">
                        <tr>
                            <td valign="middle" align="center" bgcolor="#3366CC" height="60"><font face="宋体" style="font-size: large">
                                <table id="Table7" cellspacing="3" cellpadding="0" border="0">
                                    <tr>
                                        <td class="declear">上海交通大学农业与生物学院 Copyright(C)2016</td>
                                    </tr>
                                    <tr>
                                        <td class="declear">地址：上海市闵行区东川路800号 电话：021-34206075</td>
                                    </tr>
                                </table>
                            </font>
                            </td>
                        </tr>
                    </table>
                </div>


            </div>
        </div>        
    </div>  
    </form>
    <script type="text/javascript">
        $(function () {
            $("li a").click(function () {
                //                alert($(this).attr("name"));
                var test = "" + $(this).attr("name");
                mainiframe.location.replace(test);
            })
        })

        $("#Button1").click(function () {

            mainiframe.location.replace("important.aspx");
        })

        //$("#Button2").click(function () {


        //})
    </script>
</body>
</html>

