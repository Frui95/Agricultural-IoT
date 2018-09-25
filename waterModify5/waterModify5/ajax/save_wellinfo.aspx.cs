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
public partial class ajax_save_wellinfo : System.Web.UI.Page
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
        string well_ID = Request.Form["well_ID"].ToString();
        string longitude = Request.Form["longitude"].ToString();
        string latitude = Request.Form["latitude"].ToString();
        string well_Address = Request.Form["well_Address"].ToString();
        string well_Type = Request.Form["well_Type"].ToString();
        string well_Status = Request.Form["well_Status"].ToString();
        string well_lev = Request.Form["well_lev"].ToString();
        double level = Convert.ToDouble(well_lev);
        int Status = Convert.ToInt32(well_Status);
        int iwell_Type = Convert.ToInt32(well_Type);

        DateTime lev_time=new DateTime();
        lev_time=DateTime.Now;

        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        //SqlConnection conn = new SqlConnection(str);//创建数据库连接
        string insertSql = "INSERT INTO well_info VALUES('" + well_ID + "','" + longitude + "','" + latitude + "','" + well_Address + "','" + iwell_Type + "','" + Status + "','" + level + "' ,'" + lev_time + "' )";
        selectConnection.Open();
        SqlCommand com = new SqlCommand(insertSql, selectConnection);
        com.ExecuteNonQuery();
        selectConnection.Close();
    }
    //更新用户函数
    protected void update()
    {
        string wellid = Request.QueryString["userid"].ToString();


        string well_ID = Request.Form["well_ID"].ToString();
        string longitude = Request.Form["longitude"].ToString();
        string latitude = Request.Form["latitude"].ToString();
        string well_Address = Request.Form["well_Address"].ToString();
        string well_Type = Request.Form["well_Type"].ToString();

        switch (well_Type)
        {
            case "只报警":
                well_Type = " 0";
                break;
            case "报警及液位":
                well_Type = "1";
                break;
           
        }
        int iwell_Type = Convert.ToInt32(well_Type);

        string well_Status = Request.Form["well_Status"].ToString();
        switch (well_Status)
        {
            case "正常":
                well_Status = " 0";
                break;
            case "异常":
                well_Status = "1";
                break;

        }
        string well_lev = Request.Form["well_lev"].ToString();
        if (well_lev == "-1")
        {
            well_lev = "-1";
        }
        else if (well_lev == "无液位检测模块")
        {
            well_lev = "-1";
        }
        double level = Convert.ToDouble(well_lev);
        int Status = Convert.ToInt32(well_Status);




        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        string insertSql = "UPDATE well_info SET  well_ID = '" + well_ID + "',longitude = '" + longitude + "',latitude = '" + latitude + "',well_Address = '" + well_Address + "',well_Type = '" + iwell_Type + "',well_Status = '" + Status + "',well_lev = '" + level + "' WHERE well_ID = '" + wellid + "'";
        selectConnection.Open();
        SqlCommand com = new SqlCommand(insertSql, selectConnection);
        com.ExecuteNonQuery();
        selectConnection.Close();

    }
    //删除用户信息函数
    protected void delete()
    {
        //string wellid ="1";

        string wellid = Request.QueryString["userid"].ToString();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        string insertSql = "DELETE FROM well_info WHERE well_ID = '" + wellid + "'";
        selectConnection.Open();
        SqlCommand com = new SqlCommand(insertSql, selectConnection);
        com.ExecuteNonQuery();
        selectConnection.Close();
    }


}