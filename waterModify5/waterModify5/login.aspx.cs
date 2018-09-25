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
    //��½��ť���¼�����
    protected void btn_Login_Click(object sender, EventArgs e)
    {

        string userName = this.txt_UserName.Text.Trim();//�����û����ַ����������ҳ����Text�ؼ�������
        string strText = this.txt_UserPwd.Text.Trim();//���������ַ����������ҳ����Text�ؼ�������
        //�û���Ϊ��ʱ��ʾ����
        if ((userName.Length == 0) || (strText.Length == 0))
        {
            this.lbl_Message.Text = "�û���������Ϊ�գ�";
        }
        else
        {
            //string userPwd = new DataEncrypt().DesEncrypt(strText, "ohmygod!");//�û��������

            //CheckUser user = new CheckUser(userName, userPwd);//����û����������Ƿ�һ��
            CheckUser user = new CheckUser(userName, strText);//����û����������Ƿ�һ��
            Session["user_Name"] = userName.ToString();
            if (user.IsValid)
            {    //���û��������벻Ϊ��ʱ����һ��ʱ�������û����������Ȩ�޵Ĳ�ͬ������Ӧ��ҳ��
                base.Application.Add("user", userName);
                base.Application.Add("rank", user.Rank);
                base.Application.Add("description", user.Description);
                FormsAuthentication.RedirectFromLoginPage(userName, false);//ΪWebӦ�ó���Form�ṩ��֤
                switch (user.Rank)
                {
                    case 0: //����Ա
                        base.Response.Redirect("SuperMain.aspx");//���������¶��գң̲�ָ���µģգң�
                        return;

                    case 1:// ��ͨ�û�
                        base.Response.Redirect("ClientMain.aspx");
                        return;
                    case 2://�����û�
                        base.Response.Redirect("adminMain.aspx");
                        return;
                 
                }
            }
            else
            {
                this.lbl_Message.Text = "�û������������,�����³��ԣ�";
            }
        }
    }
    //���ð�ť�����û�����������������
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

