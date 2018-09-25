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

public partial class important : System.Web.UI.Page
{
    //StringBuilder getDataset();
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Clear();
        //Response.ContentType = "text/json";
        //Response.Charset = "UTF-8";
        //getDataset();//调用getDataset函数
        ////getDatetime();
        //Response.End();
    }
    public StringBuilder getDataset()
    {
        //string modulnum = Request.QueryString["TableName"].ToString();
        //string modulnum = "A002";
        DataSet ds = new DataSet();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);

        string sql = "SELECT * FROM well_info";
        //string sql = "select * from well_info left outer join level on well_info.well_Address=well_info.well_Address";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable wellTable = ds.Tables[0];
        //写json文件
        StringBuilder jsonData = new StringBuilder();
        int rcdNum = wellTable.Rows.Count;





        jsonData.AppendLine("[");
        for (int i = 0; i < rcdNum - 1; i++)
        {
            string well_ID = wellTable.Rows[i]["well_ID"].ToString().Trim();

            //定义需要写入json文件中的变量，并赋值
            string longitude = wellTable.Rows[i]["longitude"].ToString().Trim();
            string latitude = wellTable.Rows[i]["latitude"].ToString().Trim();
            string well_Address = wellTable.Rows[i]["well_Address"].ToString().Trim();
            string well_Type = wellTable.Rows[i]["well_Type"].ToString().Trim();
            string well_Status = wellTable.Rows[i]["well_Status"].ToString().Trim();
            string level_time = wellTable.Rows[i]["level_time"].ToString().Trim();
            switch (well_Status)
            {
                case "0":
                    well_Status = "正常";
                    break;
                case "1":
                    well_Status = "异常";
                    break;
            }
            string icon = "";
            string IconA = "{ w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5 }";
            string IconB = "{ w: 21, h: 21, l: 21, t: 0, x: 6, lb: 5 }";
            switch (well_Type)
            {
                case "0":
                    well_Type = "只报警";
                    icon = IconA;
                    break;
                case "1":
                    well_Type = "报警及液位";
                    icon = IconB;
                    break;
            }
            string content = "";
            int isopen = 0;
            jsonData.AppendLine("{well_ID:\"" + well_ID + "\",longitude:\"" + longitude + "\",latitude:\"" + latitude + "\",level_time:\"" + level_time + "\",well_Address:\"" + well_Address + "\",well_Type:\"" + well_Type + "\",well_Status:\"" + well_Status + "\",content:\"" + content + "\",isopen:" + isopen + ",icon:" + icon + "},");
            
            //jsonData.AppendLine("{well_ID:\"" + well_ID + "\","+
            //       "\"longitude\":\"" + longitude + "\","+
            //        "\"latitude:\":\"" + latitude + "\","+
            //        "\"well_Address:\":\"" + well_Address + "\"," +
            //        "\"well_Type:\":\"" + well_Type + "\"," +
            //         "\"well_Status:\":\"" + well_Status + "\"," +
            //         "\"level_time:\":\"" + level_time + "\"," +
            //         "\"content:\":\"" + content + "\"," +
            //          "\"isopen:" + isopen + "," +
            //          "\"icon:" + icon + "},");
        }
        string Lastwell_ID = wellTable.Rows[rcdNum - 1]["well_ID"].ToString().Trim();
        string Lastlongitude = wellTable.Rows[rcdNum - 1]["longitude"].ToString().Trim();
        string Lastlatitude = wellTable.Rows[rcdNum - 1]["latitude"].ToString().Trim();
        //string LastName = usersTable.Rows[rcdNum - 1]["name"].ToString().Trim();
        string Lastwell_Address = wellTable.Rows[rcdNum - 1]["well_Address"].ToString().Trim();
        string Lastwell_Type = wellTable.Rows[rcdNum - 1]["well_Type"].ToString().Trim();
        string Lastwell_Status = wellTable.Rows[rcdNum - 1]["well_Status"].ToString().Trim();
        string Lastlevel_time = wellTable.Rows[rcdNum-1]["level_time"].ToString().Trim();
        switch (Lastwell_Status)
        {
            case "0":
                Lastwell_Status = "正常";
                break;
            case "1":
                Lastwell_Status = "异常";
                break;
        }

        string iconA = "{ w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5 }";

        string Lasticon = "";
        string iconB = "{ w: 21, h: 21, l: 21, t: 0, x: 6, lb: 5 }";

        switch (Lastwell_Type)
        {
            case "0":
                Lastwell_Type = "只报警";
                Lasticon = iconA;
                break;
            case "1":
                Lastwell_Type = "报警及液位";
                Lasticon = iconB;
                break;
        }
        string Lastcontent = "";
        int Lastisopen = 0;


        jsonData.AppendLine("{well_ID:\"" + Lastwell_ID + "\",longitude:\"" + Lastlongitude + "\",latitude:\"" + Lastlatitude + "\",level_time:\"" + Lastlevel_time + "\",well_Address:\"" + Lastwell_Address + "\",well_Type:\"" + Lastwell_Type + "\",well_Status:\"" + Lastwell_Status + "\",content:\"" + Lastcontent + "\",isopen:" + Lastisopen + ",icon:" + Lasticon + "}");
        //jsonData.AppendLine("{well_ID:\"" + Lastwell_ID + "\"," +
        //          "\"longitude:\":\"" + Lastlongitude + "\"," +
        //           "\"latitude:\":\"" + Lastlatitude + "\"," +
        //           "\"well_Address:\":\"" + Lastwell_Address + "\"," +
        //           "\"well_Type:\":\"" + Lastwell_Type + "\"," +
        //            "\"well_Status:\":\"" + Lastwell_Status + "\"," +
        //            "\"level_time:\":\"" + Lastlevel_time + "\"," +
        //            "\"content:\"" + Lastcontent + "\"," +
        //             "\"isopen:" + Lastisopen + "," +
        //             "\"icon:" + Lasticon + "}");
        jsonData.AppendLine(@"]");

        Response.Write(jsonData.ToString());

        return jsonData;
    }
    public StringBuilder getDatetime()
    {
        DataSet ds = new DataSet();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);

        //string sql = "SELECT * FROM level where well_Address in (select distinct well_Address FROM level)";
        string sql = "SELECT levInfo,Datetime , well_Address FROM level where well_Address in(select well_Address FROM well_Info GROUP BY well_Address)";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable wellTable = ds.Tables[0];
        //写json文件
        StringBuilder Status = new StringBuilder();
        int rcdNum = wellTable.Rows.Count;





        Status.AppendLine("[");
        for (int i = 0; i < rcdNum - 1; i++)
        {
            string levInfo = wellTable.Rows[i]["levInfo"].ToString().Trim();

            //定义需要写入json文件中的变量，并赋值

            string well_Address = wellTable.Rows[i]["well_Address"].ToString().Trim();
            string levelDatetime = wellTable.Rows[i]["Datetime"].ToString().Trim();

            Status.AppendLine("{levInfo:\"" + levInfo + "\",well_Address:\"" + well_Address + "\",levelDatetime:" + levelDatetime + "},");
        }
        string LastlevInfo = wellTable.Rows[rcdNum - 1]["levInfo"].ToString().Trim();

        //定义需要写入json文件中的变量，并赋值

        string Lastwell_Address = wellTable.Rows[rcdNum - 1]["well_Address"].ToString().Trim();
        string LastlevelDatetime = wellTable.Rows[rcdNum - 1]["Datetime"].ToString().Trim();



        Status.AppendLine("{levInfo:\"" + LastlevInfo + "\", well_Address:\"" + Lastwell_Address + "\",levelDatetime:" + LastlevelDatetime + "}");
        Status.AppendLine(@"]");

        Response.Write(Status.ToString());

        return Status;
    
 
    }


    public StringBuilder getStatus()
    {

        DataSet ds = new DataSet();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);

        string sql = "SELECT * FROM wellAlert";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable wellTable = ds.Tables[0];
        //写json文件
        StringBuilder Status = new StringBuilder();
        int rcdNum = wellTable.Rows.Count;





        Status.AppendLine("[");
        for (int i = 0; i < rcdNum - 1; i++)
        {
            string well_ID = wellTable.Rows[i]["well_ID"].ToString().Trim();

            //定义需要写入json文件中的变量，并赋值

            string well_Address = wellTable.Rows[i]["well_Address"].ToString().Trim();
            string well_Status = wellTable.Rows[i]["wellStatus"].ToString().Trim();

            Status.AppendLine("{well_ID:\"" + well_ID + "\",well_Address:\"" + well_Address + "\",well_Status:" + well_Status + "},");
        }
        string Lastwell_ID = wellTable.Rows[rcdNum - 1]["well_ID"].ToString().Trim();

        //定义需要写入json文件中的变量，并赋值

        string Lastwell_Address = wellTable.Rows[rcdNum - 1]["well_Address"].ToString().Trim();
        string Lastwell_Status = wellTable.Rows[rcdNum - 1]["wellStatus"].ToString().Trim();



        Status.AppendLine("{well_ID:\"" + Lastwell_ID + "\", well_Address:\"" + Lastwell_Address + "\",well_Status:" + Lastwell_Status + "}");
        Status.AppendLine(@"]");

        Response.Write(Status.ToString());

        return Status;
    }

}
