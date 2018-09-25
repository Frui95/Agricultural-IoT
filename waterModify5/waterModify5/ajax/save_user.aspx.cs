using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// 保存用户信息
/// </summary>
public partial class ajax_save_user : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string mode = Request.QueryString["mode"].ToString();
            if (mode == "0")
            {
                savenew();//调用保存函数
                Response.Clear();
                Response.ContentType = "text/html";
                Response.Charset = "UTF-8";
                Response.Write("0");//已成功保存
                Response.End();
            }
            else if (mode == "1")
            {
                update();
                Response.Clear();
                Response.ContentType = "text/html";
                Response.Charset = "UTF-8";
                Response.Write("0");//已成功保存
                Response.End();
            }
            else if (mode == "2")
            {
                delete();
                Response.Clear();
                Response.ContentType = "text/html";
                Response.Charset = "UTF-8";
                Response.Write("1");//已成功删除
                Response.End();
            }
        }


        catch (Exception ex)
        {
            //Response.Clear();
            //Response.ContentType = "text/html";
            //Response.Charset = "UTF-8";
            //Response.Write("错误");
            //Response.End();
        }

    }
    //保存新建用户函数
    protected void savenew()
    {
        //string UserID = Request.Form["user_ID"].ToString();
        string UserName = Request.Form["user_Name"].ToString();
        string Role = Request.Form["Role"].ToString();
        string PassWord = Request.Form["user_PWD"].ToString();
        //string Name = Request.Form["Name"].ToString();
        string Company = Request.Form["user_company"].ToString();
        string Phone = Request.Form["user_phone"].ToString();
        string Email = Request.Form["user_email"].ToString();
        int iRole = Convert.ToInt32(Role);
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        //string insertSql = "INSERT INTO users VALUES('"+UserID+"','" + UserName + "','" + PassWord + "','" + iRole + "','" + Phone + "','" + Company + "','" + Email + "'  )";

        string insertSql = "INSERT INTO users VALUES('" + UserName + "','" + iRole + "','" + PassWord + "','" + Company + "','" + Phone + "','" + Email + "'  )";
        selectConnection.Open();
        SqlCommand com = new SqlCommand(insertSql, selectConnection);
        com.ExecuteNonQuery();
        selectConnection.Close();
    }
    //更新用户函数
    protected void update()
    {
        string userid = Request.QueryString["userid"].ToString();


        string UserName = Request.Form["user_Name"].ToString();
        string Role = Request.Form["Role"].ToString();

        switch (Role)
        {
            case "系统管理员":
                Role =" 0";
                break;
            case "普通用户": 
                Role = "1";
                break;
            case "超级用户":
                Role = "2";
                break;

 

        }




        string PassWord = Request.Form["user_PWD"].ToString();
        //string Name = Request.Form["Name"].ToString();
        string Company = Request.Form["user_company"].ToString();
        string Phone = Request.Form["user_phone"].ToString();
        string Email = Request.Form["user_email"].ToString();
        int iRole = Convert.ToInt32(Role);
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        string insertSql = "UPDATE users SET user_name = '" + UserName + "',user_PWD = '" + PassWord + "',Role =' " + iRole + "',user_phone = '" + Phone + "',user_company = '" + Company + "',user_email = '" + Email + "' WHERE user_Name = '" + userid + "'";
        selectConnection.Open();
        SqlCommand com = new SqlCommand(insertSql, selectConnection);
        com.ExecuteNonQuery();
        selectConnection.Close();

    }
    //删除用户信息函数
    protected void delete()
    {
        string userid = Request.QueryString["userid"].ToString();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        string insertSql = "DELETE FROM users WHERE user_name = '" + userid + "'";
        selectConnection.Open();
        SqlCommand com = new SqlCommand(insertSql,selectConnection);
        com.ExecuteNonQuery();
        selectConnection.Close();
    }


}