using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

public partial class ajax_search : System.Web.UI.Page
{
    public string well_ID = "";
    public string longitude = "";
    public string latitude = "";
    public string well_Address = "";
    public string well_Type = "";
    public string well_Status = "";

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
        if (Request.QueryString["well_ID"] != null)
        {
            well_ID = Request.QueryString["well_ID"].ToString();
        }
        if (Request.QueryString["longitude"] != null)
        {
            longitude = Request.QueryString["longitude"].ToString();
        }
        if (Request.QueryString["latitude"] != null)
        {
            latitude = Request.QueryString["latitude"].ToString();
        }
        if (Request.QueryString["well_Address"] != null)
        {
            well_Address = Request.QueryString["well_Address"].ToString();
        }
        if (Request.QueryString["well_Type"] != null)
        {
            well_Type = Request.QueryString["well_Type"].ToString();
        }
        if (Request.QueryString["well_Status"] != null)
        {
            well_Status = Request.QueryString["well_Status"].ToString();
        }


        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        SqlCommand cmd = new SqlCommand("search", selectConnection);//定义数据库的执行命令
        cmd.CommandType = CommandType.StoredProcedure;//数据库命令类型为存储过程
        if (well_ID != "")
        {
            cmd.Parameters.Add("@well_ID", SqlDbType.VarChar, 300).Value = well_ID;
        }
        if (longitude != "")
        {
            cmd.Parameters.Add("@longitude", SqlDbType.VarChar, 300).Value = longitude;
        }
        if (latitude != "")
        {
            cmd.Parameters.Add("@latitude", SqlDbType.VarChar, 300).Value = latitude;
        }
        if (well_Address != "")
        {
            cmd.Parameters.Add("@well_Address", SqlDbType.VarChar, 300).Value = well_Address;
        }

        if (well_Type != "")
        {
            cmd.Parameters.Add("@well_Type", SqlDbType.VarChar, 300).Value = well_Type;
        }

        if (well_Status != "")
        {
            cmd.Parameters.Add("@well_Status", SqlDbType.VarChar, 300).Value = well_Status;
        }
        //if (rcdDate != "")
        //{
        //    cmd.Parameters.Add("@rcdDate", SqlDbType.DateTime, 300).Value = rcdDate;
        //}




        DataSet ds = new DataSet();

        //string sql = "SELECT * FROM well_info";
        //SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable wellTable = ds.Tables[0];
        //写json文件
        StringBuilder jsonData = new StringBuilder();
        int rcdNum = wellTable.Rows.Count;
        //int rcdNum = 0;
        if (rcdNum != 0)
        {
            jsonData.AppendLine("{\"total\":\"" + rcdNum + "\",\"rows\":[");
            for (int i = 0; i < rcdNum - 1; i++)
            {
                well_ID = wellTable.Rows[i]["well_ID"].ToString().Trim();

                //定义需要写入json文件中的变量，并赋值
                longitude = wellTable.Rows[i]["longitude"].ToString().Trim();
                latitude = wellTable.Rows[i]["latitude"].ToString().Trim();
                well_Address = wellTable.Rows[i]["well_Address"].ToString().Trim();
                well_Type = wellTable.Rows[i]["well_Type"].ToString().Trim();
                switch (well_Type)
                {
                    case "0":
                        well_Type = "只报警";
                        break;
                    case "1":
                        well_Type = "报警及液位";
                        break;
                }
                well_Status = wellTable.Rows[i]["well_Status"].ToString().Trim();
                switch (well_Status)
                {
                    case "0":
                        well_Status = "正常";
                        break;
                    case "1":
                        well_Status = "故障";
                        break;
                }


                jsonData.AppendLine("{\"well_ID\":\"" + well_ID + "\",\"longitude\":\"" + longitude + "\",\"latitude\":\"" + latitude + "\",\"well_Address\":\"" + well_Address + "\",\"well_Type\":\"" + well_Type + "\",\"well_Status\":\"" + well_Status + "\"},");
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
                    Lastwell_Status = "故障";
                    break;
            }


            jsonData.AppendLine("{\"well_ID\":\"" + Lastwell_ID + "\",\"longitude\":\"" + Lastlongitude + "\",\"latitude\":\"" + Lastlatitude + "\",\"well_Address\":\"" + Lastwell_Address + "\",\"well_Type\":\"" + Lastwell_Type + "\",\"well_Status\":\"" + Lastwell_Status + "\"}");
            jsonData.AppendLine(@"]}");

            Response.Write(jsonData.ToString());
        }

        else
        {
            string Nonwell_ID = "未查到数据";
            string Nonlongitude = "未查到数据";
            string Nonlatitude = "未查到数据";
            //string LastName = usersTable.Rows[rcdNum - 1]["name"].ToString().Trim();
            string Nonwell_Address = "未查到数据";
            string Nonwell_Type = "未查到数据";
            string Nonwell_Status = "未查到数据";

           // Response.Write(" <script type=\"javascript\"> "+ alert("没有查到数据")+");
            //Response.Write("没有查到数据");
            jsonData.AppendLine("{\"total\":\"" + "1" + "\",\"rows\":[");
            jsonData.AppendLine("{\"well_ID\":\"" + Nonwell_ID + "\",\"longitude\":\"" + Nonlongitude + "\",\"latitude\":\"" + Nonlatitude + "\",\"well_Address\":\"" + Nonwell_Address + "\",\"well_Type\":\"" + Nonwell_Type + "\",\"well_Status\":\"" + Nonwell_Status + "\"}");
            jsonData.AppendLine(@"]}");
            Response.Write(jsonData.ToString());
        }
    }
    

}