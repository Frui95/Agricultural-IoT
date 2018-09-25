using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

//public partial class ajax_point : System.Web.UI.Page
//{

//    protected void Page_Load(object sender, EventArgs e)
//    {
//        Response.Clear();
//        Response.ContentType = "text/json";
//        Response.Charset = "UTF-8";
//        getDataset();//调用getDataset函数
//        //getDatetime();
//        Response.End();
//    }

//    public StringBuilder getDataset()
//    {
//        //string modulnum = Request.QueryString["TableName"].ToString();
//        //string modulnum = "A002";
//        DataSet ds = new DataSet();
//        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);

//        string sql = "SELECT * FROM well_info";
//        //string sql = "select * from well_info left outer join level on well_info.well_Address=well_info.well_Address";
//        SqlCommand cmd = new SqlCommand(sql, selectConnection);
//        SqlDataAdapter sda = new SqlDataAdapter(cmd);
//        sda.Fill(ds);
//        DataTable wellTable = ds.Tables[0];
//        //写json文件
//        StringBuilder jsonData = new StringBuilder();
//        int rcdNum = wellTable.Rows.Count;





//        //jsonData.AppendLine("[");
//        jsonData.AppendLine("{data:[");
//        for (int i = 0; i < rcdNum - 1; i++)
//        {
//            string well_ID = wellTable.Rows[i]["well_ID"].ToString().Trim();

//            //定义需要写入json文件中的变量，并赋值
//            string longitude = wellTable.Rows[i]["longitude"].ToString().Trim();
//            string latitude = wellTable.Rows[i]["latitude"].ToString().Trim();
//            string well_Address = wellTable.Rows[i]["well_Address"].ToString().Trim();
//            string well_Type = wellTable.Rows[i]["well_Type"].ToString().Trim();
//            string well_Status = wellTable.Rows[i]["well_Status"].ToString().Trim();
//            string level_time = wellTable.Rows[i]["level_time"].ToString().Trim();
//            switch (well_Status)
//            {
//                case "0":
//                    well_Status = "正常";
//                    break;
//                case "1":
//                    well_Status = "异常";
//                    break;
//            }
//            string icon = "";
//            string IconA = "{ w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5 }";
//            string IconB = "{ w: 21, h: 21, l: 21, t: 0, x: 6, lb: 5 }";
//            switch (well_Type)
//            {
//                case "0":
//                    well_Type = "只报警";
//                    icon = IconA;
//                    break;
//                case "1":
//                    well_Type = "报警及液位";
//                    icon = IconB;
//                    break;
//            }
//            string content = "";
//            int isopen = 0;
//            jsonData.AppendLine("{well_ID:\"" + well_ID + "\",longitude:\"" + longitude + "\",latitude:\"" + latitude + "\",level_time:\"" + level_time + "\",well_Address:\"" + well_Address + "\",well_Type:\"" + well_Type + "\",well_Status:\"" + well_Status + "\",content:\"" + content + "\",isopen:" + isopen + ",icon:" + icon + "},");

//            //jsonData.AppendLine("{well_ID:\"" + well_ID + "\","+
//            //       "\"longitude\":\"" + longitude + "\","+
//            //        "\"latitude:\":\"" + latitude + "\","+
//            //        "\"well_Address:\":\"" + well_Address + "\"," +
//            //        "\"well_Type:\":\"" + well_Type + "\"," +
//            //         "\"well_Status:\":\"" + well_Status + "\"," +
//            //         "\"level_time:\":\"" + level_time + "\"," +
//            //         "\"content:\":\"" + content + "\"," +
//            //          "\"isopen:" + isopen + "," +
//            //          "\"icon:" + icon + "},");
//        }
//        string Lastwell_ID = wellTable.Rows[rcdNum - 1]["well_ID"].ToString().Trim();
//        string Lastlongitude = wellTable.Rows[rcdNum - 1]["longitude"].ToString().Trim();
//        string Lastlatitude = wellTable.Rows[rcdNum - 1]["latitude"].ToString().Trim();
//        //string LastName = usersTable.Rows[rcdNum - 1]["name"].ToString().Trim();
//        string Lastwell_Address = wellTable.Rows[rcdNum - 1]["well_Address"].ToString().Trim();
//        string Lastwell_Type = wellTable.Rows[rcdNum - 1]["well_Type"].ToString().Trim();
//        string Lastwell_Status = wellTable.Rows[rcdNum - 1]["well_Status"].ToString().Trim();
//        string Lastlevel_time = wellTable.Rows[rcdNum - 1]["level_time"].ToString().Trim();
//        switch (Lastwell_Status)
//        {
//            case "0":
//                Lastwell_Status = "正常";
//                break;
//            case "1":
//                Lastwell_Status = "异常";
//                break;
//        }

//        string iconA = "{ w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5 }";

//        string Lasticon = "";
//        string iconB = "{ w: 21, h: 21, l: 21, t: 0, x: 6, lb: 5 }";

//        switch (Lastwell_Type)
//        {
//            case "0":
//                Lastwell_Type = "只报警";
//                Lasticon = iconA;
//                break;
//            case "1":
//                Lastwell_Type = "报警及液位";
//                Lasticon = iconB;
//                break;
//        }
//        string Lastcontent = "";
//        int Lastisopen = 0;


//        jsonData.AppendLine("{well_ID:\"" + Lastwell_ID + "\",longitude:\"" + Lastlongitude + "\",latitude:\"" + Lastlatitude + "\",level_time:\"" + Lastlevel_time + "\",well_Address:\"" + Lastwell_Address + "\",well_Type:\"" + Lastwell_Type + "\",well_Status:\"" + Lastwell_Status + "\",content:\"" + Lastcontent + "\",isopen:" + Lastisopen + ",icon:" + Lasticon + "}");
//        //jsonData.AppendLine("{well_ID:\"" + Lastwell_ID + "\"," +
//        //          "\"longitude:\":\"" + Lastlongitude + "\"," +
//        //           "\"latitude:\":\"" + Lastlatitude + "\"," +
//        //           "\"well_Address:\":\"" + Lastwell_Address + "\"," +
//        //           "\"well_Type:\":\"" + Lastwell_Type + "\"," +
//        //            "\"well_Status:\":\"" + Lastwell_Status + "\"," +
//        //            "\"level_time:\":\"" + Lastlevel_time + "\"," +
//        //            "\"content:\"" + Lastcontent + "\"," +
//        //             "\"isopen:" + Lastisopen + "," +
//        //             "\"icon:" + Lasticon + "}");
//        //jsonData.AppendLine(@"]");
//        jsonData.AppendLine(@"]}");

//        Response.Write(jsonData.ToString());

//        return jsonData;
//    }


//}
public partial class ajax_point : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "text/json";
        Response.Charset = "UTF-8";
        getDataset();//调用getDataset函数
        //getDatetime();
        Response.End();
    }
    public StringBuilder getDataset()
    {
        //string modulnum = Request.QueryString["TableName"].ToString();
        //string modulnum = "A002";
        DataSet ds = new DataSet();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);

        string sql = "SELECT * FROM greenhouse_info";
        //string sql = "select * from well_info left outer join level on well_info.well_Address=well_info.well_Address";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable greenhouseTable = ds.Tables[0];
        //写json文件
        StringBuilder jsonData = new StringBuilder();
        int rcdNum = greenhouseTable.Rows.Count;





        //jsonData.AppendLine("[");
        jsonData.AppendLine("{data:[");
        for (int i = 0; i < rcdNum -1; i++)
        {
            string airtemper = greenhouseTable.Rows[i]["airtemper"].ToString().Trim();

            //定义需要写入json文件中的变量，并赋值
            string airhum = greenhouseTable.Rows[i]["airhum"].ToString().Trim();
            string landhum = greenhouseTable.Rows[i]["landhum"].ToString().Trim();
            string light = greenhouseTable.Rows[i]["light"].ToString().Trim();
            //string well_Type = greenhouseTable.Rows[i]["well_Type"].ToString().Trim();
            //string well_Status = greenhouseTable.Rows[i]["well_Status"].ToString().Trim();
            //string level_time = greenhouseTable.Rows[i]["level_time"].ToString().Trim();
            //switch (well_Status)
            //{
            //    case "0":
            //        well_Status = "正常";
            //        break;
            //    case "1":
            //        well_Status = "异常";
            //        break;
            //}
            //string icon = "";
            //string IconA = "{ w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5 }";
            //string IconB = "{ w: 21, h: 21, l: 21, t: 0, x: 6, lb: 5 }";
            //switch (well_Type)
            //{
            //    case "0":
            //        well_Type = "只报警";
            //        icon = IconA;
            //        break;
            //    case "1":
            //        well_Type = "报警及液位";
            //        icon = IconB;
            //        break;
            //}
            string content = "";
            int isopen = 0;
            jsonData.AppendLine("{airtemper:\"" + airtemper + "\",airhum:\"" + airhum + "\",landhum:\"" + landhum + "\",light:\"" + light + "},");

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
        string Lastairtemper = greenhouseTable.Rows[rcdNum - 1]["airtemper"].ToString().Trim();
        string Lastairhum = greenhouseTable.Rows[rcdNum - 1]["airhum"].ToString().Trim();
        string Lastlandhum = greenhouseTable.Rows[rcdNum - 1]["landhum"].ToString().Trim();
        //string LastName = usersTable.Rows[rcdNum - 1]["name"].ToString().Trim();
        string Lastlight = greenhouseTable.Rows[rcdNum - 1]["light"].ToString().Trim();
        //string Lastwell_Type = greenhouseTable.Rows[rcdNum - 1]["well_Type"].ToString().Trim();
        //string Lastwell_Status = greenhouseTable.Rows[rcdNum - 1]["well_Status"].ToString().Trim();
        //string Lastlevel_time = greenhouseTable.Rows[rcdNum - 1]["level_time"].ToString().Trim();
        //switch (Lastwell_Status)
        //{
        //    case "0":
        //        Lastwell_Status = "正常";
        //        break;
        //    case "1":
        //        Lastwell_Status = "异常";
        //        break;
        //}

        //string iconA = "{ w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5 }";

        //string Lasticon = "";
        //string iconB = "{ w: 21, h: 21, l: 21, t: 0, x: 6, lb: 5 }";

        //switch (Lastwell_Type)
        //{
        //    case "0":
        //        Lastwell_Type = "只报警";
        //        Lasticon = iconA;
        //        break;
        //    case "1":
        //        Lastwell_Type = "报警及液位";
        //        Lasticon = iconB;
        //        break;
        //}
        string Lastcontent = "";
        int Lastisopen = 0;


        jsonData.AppendLine("{airtemper:\"" + Lastairtemper + "\",airhum:\"" + Lastairhum + "\",landhum:\"" + Lastlandhum + "\",light:\"" + Lastlight +  "}");
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
        //jsonData.AppendLine(@"]");
        jsonData.AppendLine(@"]}");

        Response.Write(jsonData.ToString());

        return jsonData;
    }
}