<%@ page language="C#" autoeventwireup="true" inherits="login" CodeFile="login.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--��½ҳ��--%>
<html xmlns="http://www.w3.org/1999/xhtml" >
    <%--��ҳͷ��������CSS��ʽ���ļ���������ҳ��ʽ--%>
<head id="Head1" runat="server"><%--��ҳͷ�������ýű���ָʾ������������ҵ���ʽ���ṩԪ��Ϣ�ȵȡ�
�ĵ���ͷ���������ĵ��ĸ������Ժ���Ϣ�������ĵ��ı��⡢�� Web �е�λ���Լ��������ĵ��Ĺ�ϵ�ȡ���������ĵ�ͷ�����������ݶ�����������Ϊ������ʾ�����ߡ�--%>
    <title>����԰���������ܻ����ƽ̨����½</title>
    <link href="style/style.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">/*����ʹ��CSS��ʽ��*/
    .input_NoBoder/*��ʽӦ�õ����е�class=input_NoBorder*/
    {
        BACKGROUND-COLOR: transparent;    /*������ɫ ͸��*/
        BORDER-BOTTOM: black 1px groove;/*�ײ��߿���ʽ*/
        BORDER-LEFT: medium none;/*��߱߿���ʽ*/
        BORDER-RIGHT: medium none;/*�ұ߱߿���ʽ*/
        BORDER-TOP: medium none;/*�����߿���ʽ*/
        FONT-FAMILY: ����;/*����*/
        FONT-SIZE: 10pt;/*�����С*/
        FONT-WEIGHT: normal;/*�����ϸ���� 400*/
        OVERFLOW: visible;/*�������뷶Χ����*/
        POSITION: relative;/*��Զ�λ*/
        text-align: center;/*�ĵ�λ��*/
        WIDTH: 100pt;/*���*/
    }
    .button_Plane/*��ʽӦ�õ�����button_Plane*/
    {    
        border: 1px solid silver;/*�߿���ʽ */
        BACKGROUND-COLOR: #336699;/*������ɫ*/
        COLOR: white;/*������ɫ��ɫ*/
        CURSOR: pointer ;/*���͹��*/
        FONT-FAMILY: ����;/*��������*/
        FONT-SIZE: 12px;/*�����С 12��*/
        FONT-WEIGHT: normal;/*�����ϸ����*/
    }
        .auto-style1 {/*����class=auto-style1*/
            width: 300px;
            height: 37px;
        }
        .auto-style2 {/*����class=auto-style2*/
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

    <%--��ҳ���岿�֣�ʵ����ҳ�Ĺ��ܣ�����table����--%>
<body>
    <form id="form1" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;background: url(images/headerBg.gif)  top left no-repeat ;"><%--����ͼ�����ӵ�gif�ļ���ͼ����ʼλ�����ϣ��ظ���ʽ����--%>
            <tr>
                <td align="center">
                    <table border="0" cellpadding="0" cellspacing="0" style="
                        width: 800px; background-repeat: no-repeat; height: 500px">
                        <tr>
                            <td  colspan="2"; style="height: 180px; ">
                            <div id="logintext" align="center"><br><br>����԰���������ܻ����ƽ̨</div>
                                &nbsp;</td>
                           <%-- <td style="width: 412px; height: 180px">
                            </td>--%>
                        </tr>
                        <tr>
                            <td style="width: 388px; height: 340px;background-image: url(images/login_left.jpg);" align="center">
                           <%-- <img src="images/loginim.gif"   />--%>
                                <%--<a href="http://www.sjtu.edu.cn/" target="_blank">
                                    <img border="0" src="images/��ɫϵУ�ձ�׼��.png" width="200" height="200" alt="SJTU" />
                                </a>--%>


                                <img alt="���ѣ�ӣ�ң�⨺��ң�������" class="auto-style3" src="images/����ũѧԺ.JPG" align="middle"/></td>
                            <td style="width: 471px; height: 340px; background-image: url(images/login_right.jpg); " align="left" valign="center" >
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 400px; height: 120px">
                                    <tr>
                                        <td style="width: 300px; height: 30px; font-size: 20px; font-family: ����;font-weight:bold" align="right">
                                            �� �� ��:</td>
                                        <td style="width: 300px; height: 30px;font-size: 20px" align="left">
                                            <asp:TextBox ID="txt_UserName" runat="server" CssClass="input_NoBoder" OnTextChanged="txt_UserName_TextChanged"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="font-size: 20px; font-family: ����;font-weight:bold" align="right" class="auto-style1">
                                            �� ��:</td>
                                        <td align="left" class="auto-style1" >
                                            <asp:TextBox ID="txt_UserPwd" runat="server" CssClass="input_NoBoder" TextMode="Password" OnTextChanged="txt_UserPwd_TextChanged"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="auto-style2">
                                        <br/>
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button ID="btn_Login" runat="server" Text="�� ½" OnClick="btn_Login_Click" CssClass="button_Plane" Height="22px" Width="51px" />
                                            &nbsp; &nbsp;<asp:Button ID="btn_Reset" runat="server" Text="�� ��" OnClick="btn_Reset_Click" CssClass="button_Plane" Height="22px" Width="51px" />
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
                                �Ϻ���ͨ��ѧũҵ������ѧԺũҵ��ũҵ(�Ϸ�)�ص�ʵ����<br/>
                                ��ַ���Ϻ��ж���·800�� �ʱࣺ200240  
                            </td>
                            
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
   
    </form>
</body>
</html>
