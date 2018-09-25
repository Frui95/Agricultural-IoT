using System;
using System.Web.Profile;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using waterModify;

public partial class login : Page, IRequiresSessionState
{
    //登陆按钮的事件函数
    protected void btn_Login_Click(object sender, EventArgs e)
    {

        string userName = this.txt_UserName.Text.Trim();//定义用户名字符串，获得网页上上Text控件的内容
        string strText = this.txt_UserPwd.Text.Trim();//定义密码字符串，获得网页上上Text控件的内容
        //用户名为空时提示错误
        if ((userName.Length == 0) || (strText.Length == 0))
        {
            this.lbl_Message.Text = "用户名或密码为空！";
        }
        else
        {
            //string userPwd = new DataEncrypt().DesEncrypt(strText, "ohmygod!");//用户密码加密

            //CheckUser user = new CheckUser(userName, userPwd);//检查用户名和密码是否一致
            CheckUser user = new CheckUser(userName, strText);//检查用户名和密码是否一致
            Session["user_Name"] = userName.ToString();
            if (user.IsValid)
            {    //当用户名和密码不为空时，且一致时，根据用户类别所具有权限的不同返回相应的页面
                base.Application.Add("user", userName);
                base.Application.Add("rank", user.Rank);
                base.Application.Add("description", user.Description);
                FormsAuthentication.RedirectFromLoginPage(userName, false);//为Web应用程序Form提供验证
                switch (user.Rank)
                {
                    case 0: //管理员
                        base.Response.Redirect("SuperMain.aspx");//将请求重新定ＵＲＬ并指向新的ＵＲＬ
                        return;

                    case 1:// 普通用户
                        base.Response.Redirect("ClientMain.aspx");
                        return;
                    case 2://超级用户
                        base.Response.Redirect("adminMain.aspx");
                        return;
                 
                }
            }
            else
            {
                this.lbl_Message.Text = "用户名或密码错误,请重新尝试！";
            }
        }
    }
    //重置按钮，将用户名和密码的内容清空
    protected void btn_Reset_Click(object sender, EventArgs e)
    {
        this.txt_UserName.Text = "";
        this.txt_UserPwd.Text = "";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        base.Application.RemoveAll();
        if (!this.Page.IsPostBack)
        {
            this.txt_UserName.Text = "";
            this.txt_UserPwd.Text = "";
        }
        this.lbl_Message.Text = "";
    }



    protected void txt_UserName_TextChanged(object sender, EventArgs e)
    {

    }
    protected void txt_UserPwd_TextChanged(object sender, EventArgs e)
    {

    }
}

