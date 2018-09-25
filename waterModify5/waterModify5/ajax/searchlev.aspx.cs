using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using waterModify;
using System.Configuration;

public partial class ajax_searchlev : System.Web.UI.Page
{
    public string well_Address = "";
    public string levInfo = "";
    //public string DateBegin = "";
    public string well_Status = "";
    public string Datetime = "";

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
        if (Request.QueryString["well_Address"] != null)
        {
            well_Address = Request.QueryString["well_Address"].ToString();
        }
        if (Request.QueryString["levInfo"] != null)
        {
            levInfo = Request.QueryString["levInfo"].ToString();
        }
        //if (Request.QueryString["DateBegin"] != null)
        //{
        //    DateBegin = Request.QueryString["DateBegin"].ToString();
        //}
        if (Request.QueryString["Datetime"] != null)
        {
            Datetime = Request.QueryString["Datetime"].ToString();
        }
        //if (Request.QueryString["well_Type"] != null)
        //{
        //    well_Type = Request.QueryString["well_Type"].ToString();
        //}
        if (Request.QueryString["well_Status"] != null)
        {
            well_Status = Request.QueryString["well_Status"].ToString();
        }


        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        //string str = "server=(local);database=water;uid=sa;pwd=sjtumi!863";
        //SqlConnection conn = new SqlConnection(str);//创建数据库连接
        SqlCommand cmd = new SqlCommand("inquery", selectConnection);//定义数据库的执行命令
        //string cmdstr = "select * from level  where level.Datetime  between "+DateBegin+" and "+DateEnd+"";
        //SqlCommand cmd1 = new SqlCommand(cmdstr, conn);
        //conn.Open();
        //cmd1.ExecuteNonQuery();



        cmd.CommandType = CommandType.StoredProcedure;//数据库命令类型为存储过程
        if (well_Address!= "")
        {
            cmd.Parameters.Add("@well_Address", SqlDbType.VarChar, 300).Value = well_Address;
        }
        if (levInfo != "")
        {
            cmd.Parameters.Add("@levInfo", SqlDbType.VarChar, 300).Value = levInfo;
        }
        //if (DateBegin != "")
        //{
        //    cmd.Parameters.Add("@Datetime", SqlDbType.DateTime, 300).Value = DateBegin;
        //}
       

        if (well_Status != "")
        {
            cmd.Parameters.Add("@well_Status", SqlDbType.VarChar, 300).Value = well_Status;
        }
        if (Datetime != "")
        {
            cmd.Parameters.Add("@Datetime", SqlDbType.DateTime, 300).Value = Datetime;
        }




        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable wellTable = ds.Tables[0];
        //写json文件
        StringBuilder jsonData = new StringBuilder();
        int rcdNum = wellTable.Rows.Count;

        if (rcdNum != 0)
        {



            jsonData.AppendLine("{\"total\":\"" + rcdNum + "\",\"rows\":[");
            for (int i = 0; i < rcdNum - 1; i++)
            {
                well_Address = wellTable.Rows[i]["well_Address"].ToString().Trim();

                //定义需要写入json文件中的变量，并赋值
                levInfo = wellTable.Rows[i]["levInfo"].ToString().Trim();
                Datetime = wellTable.Rows[i]["Datetime"].ToString().Trim();
                well_Status = wellTable.Rows[i]["well_Status"].ToString().Trim();
                switch (well_Status)
                {
                    case "0":
                        well_Status = "正常";
                        break;
                    case "1":
                        well_Status = "异常";
                        break;
                }


                jsonData.AppendLine("{\"well_Address\":\"" + well_Address+ "\",\"levInfo\":\"" + levInfo + "\",\"Datetime\":\"" + Datetime + "\",\"well_Status\":\"" + well_Status + "\"},");
            }
            string LastAddress = wellTable.Rows[rcdNum - 1]["well_Address"].ToString().Trim();
            string LastlevInfo = wellTable.Rows[rcdNum - 1]["levInfo"].ToString().Trim();
            string LastDatetime = wellTable.Rows[rcdNum - 1]["Datetime"].ToString().Trim();
            //string LastName = usersTable.Rows[rcdNum - 1]["name"].ToString().Trim();
            //string Lastwell_Address = wellTable.Rows[rcdNum - 1]["well_Address"].ToString().Trim();
            //string Lastwell_Type = wellTable.Rows[rcdNum - 1]["well_Type"].ToString().Trim();

            //switch (Lastwell_Type)
            //{
            //    case "0":
            //        Lastwell_Type = "只报警";
            //        break;
            //    case "1":
            //        Lastwell_Type = "报警及液位";
            //        break;
            //}
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


            jsonData.AppendLine("{\"well_Address\":\"" + LastAddress + "\",\"levInfo\":\"" + LastlevInfo + "\",\"Datetime\":\"" + LastDatetime + "\",\"well_Status\":\"" + Lastwell_Status + "\"}");
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
            jsonData.AppendLine("{\"well_Address\":\"" + Nonwell_ID + "\",\"levInfo\":\"" + Nonlongitude + "\",\"Datetime\":\"" + Nonlatitude + "\",\"well_Status\":\"" + Nonwell_Status + "\"}");
            jsonData.AppendLine(@"]}");
            Response.Write(jsonData.ToString());
        }

    }
    

}