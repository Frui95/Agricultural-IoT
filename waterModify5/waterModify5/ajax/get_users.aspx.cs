using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/// <summary>
/// 用户信息管理页面调用的json文件
/// </summary>

public partial class ajax_get_users : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "text/json";
        Response.Charset = "UTF-8";
        getDataset();//调用getDataset函数
        Response.End();
    }
    private void getDataset()
    {
        //string modulnum = Request.QueryString["TableName"].ToString();
        //string modulnum = "A002";
        DataSet ds = new DataSet();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
                                                                  
        string sql = "SELECT * FROM Users";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable usersTable = ds.Tables[0];
        //写json文件
        StringBuilder jsonData = new StringBuilder();
        int rcdNum = usersTable.Rows.Count;
        jsonData.AppendLine("{\"total\":\"" + rcdNum + "\",\"rows\":[");
        for (int i = 0; i < rcdNum-1; i++)
        {
            //string UserID = usersTable.Rows[i]["user_ID"].ToString().Trim();
            string UserName = usersTable.Rows[i]["user_Name"].ToString().Trim();//获得UserName字段内容赋值给UserName
            string Role = usersTable.Rows[i]["Role"].ToString().Trim();//获得Role字段的内容，复制给Role
           //根据Role值的不同，设置写入json文件中的内容
            switch (Role){
                case "0" :
                    Role="系统管理员";
                    break;
                case "1":
                    Role = "普通用户";
                    break;
                case "2":
                    Role = "超级用户";
                    break;
                //case "3":
                //    Role = "普通权限";
                //    break;
            }
            //定义需要写入json文件中的变量，并赋值
            string PassWord = usersTable.Rows[i]["user_PWD"].ToString().Trim();
            //string Name = usersTable.Rows[i]["user_Name"].ToString().Trim();
            string Company = usersTable.Rows[i]["user_company"].ToString().Trim();
            string Phone = usersTable.Rows[i]["user_phone"].ToString().Trim();
            string Email = usersTable.Rows[i]["user_email"].ToString().Trim();

            jsonData.AppendLine("{\"user_Name\":\"" + UserName + "\",\"Role\":\"" + Role + "\",\"user_PWD\":\"" + PassWord + "\",\"user_company\":\"" + Company + "\",\"user_phone\":\"" + Phone + "\",\"user_email\":\"" + Email + "\"},");
            //jsonData.AppendLine("{\"user_ID\":\"" + UserID + "\",\"user_Name\":\"" + UserName + "\",\"Role\":\"" + Role + "\",\"user_PWD\":\"" + PassWord + "\",\"user_company\":\"" + Company + "\",\"user_phone\":\"" + Phone + "\",\"user_email\":\"" + Email + "\"},");
        }
        //string LastUserID = usersTable.Rows[rcdNum - 1]["user_ID"].ToString().Trim();
        string LastUserName = usersTable.Rows[rcdNum - 1]["user_Name"].ToString().Trim();
        string LastRole = usersTable.Rows[rcdNum - 1]["Role"].ToString().Trim();
        string LastPassWord = usersTable.Rows[rcdNum - 1]["user_PWD"].ToString().Trim();
        //string LastName = usersTable.Rows[rcdNum - 1]["name"].ToString().Trim();
        string LastCompany = usersTable.Rows[rcdNum - 1]["user_company"].ToString().Trim();
        string LastPhone = usersTable.Rows[rcdNum - 1]["user_phone"].ToString().Trim();
        string LastEmail = usersTable.Rows[rcdNum - 1]["user_email"].ToString().Trim();
        switch (LastRole)
        {
            case "0":
                LastRole = "系统管理员";
                break;
            case "1":
                LastRole = "普通用户";
                break;
            case "2":
                LastRole = "超级用户";
                break;
            //case "3":
            //    LastRole = "普通权限";
            //    break;
        }

        jsonData.AppendLine("{\"user_Name\":\"" + LastUserName + "\",\"Role\":\"" + LastRole + "\",\"user_PWD\":\"" + LastPassWord + "\",\"user_phone\":\"" + LastPhone + "\",\"user_company\":\"" + LastCompany + "\",\"user_email\":\"" + LastEmail + "\"}");
        //jsonData.AppendLine("{\"user_ID\":\"" + LastUserID + "\",\"user_Name\":\"" + LastUserName + "\",\"Role\":\"" + LastRole + "\",\"user_PWD\":\"" + LastPassWord + "\",\"user_phone\":\"" + LastPhone + "\",\"user_company\":\"" + LastCompany + "\",\"user_email\":\"" + LastEmail + "\"}");
        jsonData.AppendLine(@"]}");

        Response.Write(jsonData.ToString());
    }

}

