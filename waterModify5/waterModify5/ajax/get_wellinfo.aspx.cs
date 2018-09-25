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

public partial class ajax_get_wellinfo : System.Web.UI.Page
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
                                                                  
        string sql = "SELECT * FROM well_info";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable wellTable = ds.Tables[0];
        //写json文件
        StringBuilder jsonData = new StringBuilder();
        int rcdNum = wellTable.Rows.Count;

        



        jsonData.AppendLine("{\"total\":\"" + rcdNum + "\",\"rows\":[");
        for (int i = 0; i < rcdNum-1; i++)
        {
            string well_ID = wellTable.Rows[i]["well_ID"].ToString().Trim();

            //定义需要写入json文件中的变量，并赋值
            string longitude = wellTable.Rows[i]["longitude"].ToString().Trim();
            string latitude = wellTable.Rows[i]["latitude"].ToString().Trim();
            string well_Address = wellTable.Rows[i]["well_Address"].ToString().Trim();
            string well_Type = wellTable.Rows[i]["well_Type"].ToString().Trim();
            switch (well_Type)
             {
                case "0" :
                     well_Type = "只报警";
                    break;
                case "1":
                    well_Type = "报警及液位";
                    break;
             }
           string well_Status = wellTable.Rows[i]["well_Status"].ToString().Trim();
            switch (well_Status)
            {
                case "0":
                    well_Status = "正常";
                    break;
                case "1":
                    well_Status = "异常";
                    break;
            }

            string well_lev = wellTable.Rows[i]["well_lev"].ToString().Trim();
            if (well_lev=="-1")
            {
                well_lev = "无液位检测模块";
            }

            jsonData.AppendLine("{\"well_ID\":\"" + well_ID + "\","+
                "\"longitude\":\"" + longitude + "\","+
                "\"latitude\":\"" + latitude + "\"," +
                "\"well_Address\":\"" + well_Address + "\"," +
                "\"well_Type\":\"" + well_Type + "\"," + 
                "\"well_Status\":\"" + well_Status + "\","+
                "\"well_lev\":\"" + well_lev + "\"},");
        }
        string Lastwell_ID = wellTable.Rows[rcdNum - 1]["well_ID"].ToString().Trim();
        string Lastlongitude = wellTable.Rows[rcdNum - 1]["longitude"].ToString().Trim();
        string Lastlatitude = wellTable.Rows[rcdNum - 1]["latitude"].ToString().Trim();
        //string LastName = usersTable.Rows[rcdNum - 1]["name"].ToString().Trim();
        string Lastwell_Address = wellTable.Rows[rcdNum - 1]["well_Address"].ToString().Trim();
        string Lastwell_Type = wellTable.Rows[rcdNum - 1]["well_Type"].ToString().Trim();

        switch (Lastwell_Type)
        {
            case "0":
                Lastwell_Type = "只报警";
                break;
            case "1":
                Lastwell_Type = "报警及液位";
                break;
        }


        string Lastwell_Status = wellTable.Rows[rcdNum - 1]["well_Status"].ToString().Trim();
        switch (Lastwell_Status)
        {
            case "0":
                Lastwell_Status = "正常";
                break;
            case "1":
                Lastwell_Status = "异常";
                break;
        }

        string Lastwell_lev = wellTable.Rows[rcdNum - 1]["well_lev"].ToString().Trim();
        if (Lastwell_lev == "-1")
        {
            Lastwell_lev = "无液位检测模块";
        }
        jsonData.AppendLine("{\"well_ID\":\"" + Lastwell_ID + "\"," +
            "\"longitude\":\"" + Lastlongitude + "\"," +
            "\"latitude\":\"" + Lastlatitude + "\"," +
            "\"well_Address\":\"" + Lastwell_Address + "\"," +
            "\"well_Type\":\"" + Lastwell_Type + "\"," +
             "\"well_Status\":\"" + Lastwell_Status + "\"," +
            "\"well_lev\":\"" + Lastwell_lev + "\"}");
        jsonData.AppendLine(@"]}");

        Response.Write(jsonData.ToString());
    }
}
