<%@ page language="C#" autoeventwireup="true" inherits="login" CodeFile="login.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--登陆页面--%>
<html xmlns="http://www.w3.org/1999/xhtml" >
    <%--网页头部，设置CSS样式表文件，设置网页样式--%>
<head id="Head1" runat="server"><%--网页头可以引用脚本、指示浏览器在哪里找到样式表、提供元信息等等。
文档的头部描述了文档的各种属性和信息，包括文档的标题、在 Web 中的位置以及和其他文档的关系等。绝大多数文档头部包含的数据都不会真正作为内容显示给读者。--%>
    <title>温室园艺作物智能化监控平台－登陆</title>
    <link href="style/style.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">/*声明使用CSS样式表*/
    .input_NoBoder/*样式应用到所有的class=input_NoBorder*/
    {
        BACKGROUND-COLOR: transparent;    /*背景颜色 透明*/
        BORDER-BOTTOM: black 1px groove;/*底部边框样式*/
        BORDER-LEFT: medium none;/*左边边框样式*/
        BORDER-RIGHT: medium none;/*右边边框样式*/
        BORDER-TOP: medium none;/*顶部边框样式*/
        FONT-FAMILY: 宋体;/*字体*/
        FONT-SIZE: 10pt;/*字体大小*/
        FONT-WEIGHT: normal;/*字体粗细正常 400*/
        OVERFLOW: visible;/*超出输入范围滚动*/
        POSITION: relative;/*相对定位*/
        text-align: center;/*文档位置*/
        WIDTH: 100pt;/*宽度*/
    }
    .button_Plane/*样式应用到所有button_Plane*/
    {    
        border: 1px solid silver;/*边框样式 */
        BACKGROUND-COLOR: #336699;/*背景蓝色*/
        COLOR: white;/*文字颜色白色*/
        CURSOR: pointer ;/*手型光标*/
        FONT-FAMILY: 宋体;/*字体宋体*/
        FONT-SIZE: 12px;/*字体大小 12号*/
        FONT-WEIGHT: normal;/*字体粗细正常*/
    }
        .auto-style1 {/*所有class=auto-style1*/
            width: 300px;
            height: 37px;
        }
        .auto-style2 {/*所有class=auto-style2*/
            width: 300px;
            height: 8px;
        }
        .auto-style3 {
            width: 315px;
            height: 247px;
            margin-top: 0px;
        }
    </style>
</head>

    <%--网页主体部分，实现网页的功能，采用table布局--%>
<body>
    <form id="form1" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;background: url(images/headerBg.gif)  top left no-repeat ;"><%--背景图像连接到gif文件，图像起始位置左上，重复方式横向--%>
            <tr>
                <td align="center">
                    <table border="0" cellpadding="0" cellspacing="0" style="
                        width: 800px; background-repeat: no-repeat; height: 500px">
                        <tr>
                            <td  colspan="2"; style="height: 180px; ">
                            <div id="logintext" align="center"><br><br>温室园艺作物智能化监控平台</div>
                                &nbsp;</td>
                           <%-- <td style="width: 412px; height: 180px">
                            </td>--%>
                        </tr>
                        <tr>
                            <td style="width: 388px; height: 340px;background-image: url(images/login_left.jpg);" align="center">
                           <%-- <img src="images/loginim.gif"   />--%>
                                <%--<a href="http://www.sjtu.edu.cn/" target="_blank">
                                    <img border="0" src="images/蓝色系校徽标准版.png" width="200" height="200" alt="SJTU" />
                                </a>--%>


                                <img alt="葡萄，樱桃，猕猴桃，橘子树" class="auto-style3" src="images/交大农学院.JPG" align="middle"/></td>
                            <td style="width: 471px; height: 340px; background-image: url(images/login_right.jpg); " align="left" valign="center" >
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 400px; height: 120px">
                                    <tr>
                                        <td style="width: 300px; height: 30px; font-size: 20px; font-family: 宋体;font-weight:bold" align="right">
                                            用 户 名:</td>
                                        <td style="width: 300px; height: 30px;font-size: 20px" align="left">
                                            <asp:TextBox ID="txt_UserName" runat="server" CssClass="input_NoBoder" OnTextChanged="txt_UserName_TextChanged"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="font-size: 20px; font-family: 宋体;font-weight:bold" align="right" class="auto-style1">
                                            密 码:</td>
                                        <td align="left" class="auto-style1" >
                                            <asp:TextBox ID="txt_UserPwd" runat="server" CssClass="input_NoBoder" TextMode="Password" OnTextChanged="txt_UserPwd_TextChanged"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="auto-style2">
                                        <br/>
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button ID="btn_Login" runat="server" Text="登 陆" OnClick="btn_Login_Click" CssClass="button_Plane" Height="22px" Width="51px" />
                                            &nbsp; &nbsp;<asp:Button ID="btn_Reset" runat="server" Text="重 置" OnClick="btn_Reset_Click" CssClass="button_Plane" Height="22px" Width="51px" />
                                        &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 300px; height: 30px" colspan="2" align="center">
                                             <asp:Label ID="lbl_Message" runat="server" Font-Size="Small" ForeColor="Red" > </asp:Label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 388px; height: 120px" colspan ="2" align ="center">
                                上海交通大学农业与生物学院农业部农业(南方)重点实验室<br/>
                                地址：上海市东川路800号 邮编：200240  
                            </td>
                            
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
   
    </form>
</body>
</html>
