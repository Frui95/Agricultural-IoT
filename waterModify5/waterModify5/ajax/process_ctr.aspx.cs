using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ajax_process_ctr : System.Web.UI.Page
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
                editCtr();
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
        catch(Exception ex)
        {

        }
    }
    protected void savenew()
    {
        string ctr_Date=Request.Form["ctr_Date"].ToString();
        string ctr_Start = Request.Form["ctr_Start"].ToString();
        string ctr_Close = Request.Form["ctr_Close"].ToString();
        string ctr_Temperal = Request.Form["ctr_Temperal"].ToString();
        string ctr_User = Request.Form["ctr_User"].ToString();

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        string insertsql = "INSERT INTO irrigationCtrl VALUES('"+ctr_Date+"','"+ctr_Start+"','"+ctr_Close+"','"+ctr_Temperal+"','"+ctr_User+"' )";
        con.Open();
        SqlCommand cmd = new SqlCommand(insertsql, con);
        cmd.ExecuteNonQuery();
        con.Close();
    }

    protected void delete()
    {
        string symbol=Request.QueryString["symbol"].ToString();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        string deletecmd = "DELETE FROM irrigationCtrl WHERE symbol = '" + symbol + "'";
        con.Open();
        SqlCommand cmd = new SqlCommand(deletecmd, con);
        cmd.ExecuteNonQuery();
        con.Close();
    }

    private void editCtr()
    {
        string ctr_Date = Request.Form["ctr_Date"].ToString();
        string ctr_Start = Request.Form["ctr_Start"].ToString();
        string ctr_Close = Request.Form["ctr_Close"].ToString();
        string ctr_Temperal = Request.Form["ctr_Temperal"].ToString();
        string ctr_User = Request.Form["ctr_User"].ToString();
        string symbol = Request.QueryString["symbol"].ToString();

        SqlConnection con = new SqlConnection(ConfigurationManager .ConnectionStrings["connstring"].ConnectionString);
        string updatecmd = "UPDATE irrigationCtrl SET 日期 = '" + ctr_Date + "',阀门开启时刻 = '" + ctr_Start + "',阀门关断时刻 =' " + ctr_Close + "',灌溉时长 = '" + ctr_Temperal + "',操作员 = '" + ctr_User + "' WHERE symbol = '" + symbol + "'";
        SqlCommand cmd = new SqlCommand(updatecmd,con);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
       
}