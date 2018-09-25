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

public partial class Reset : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public StringBuilder getDataset()
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
            switch (well_Status)
            {
                case "0":
                    well_Status = "正常";
                    //icon = IconA;
                    break;
                case "1":
                    well_Status = "异常";
                    //icon = IconB;
                    break;
            }


            string icon = "";
            string IconA = "{ w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5 }";
            string IconB = "{ w: 23, h: 25, l: 23, t: 21, x: 9, lb: 12 }";
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

            jsonData.AppendLine("{well_ID:\"" + well_ID + "\",longitude:\"" + longitude + "\",latitude:\"" + latitude + "\",well_Address:\"" + well_Address + "\",well_Type:\"" + well_Type + "\",well_Status:\"" + well_Status + "\",content:\"" + content + "\",isopen:" + isopen + ",icon:" + icon + "},");
        }
        string Lastwell_ID = wellTable.Rows[rcdNum - 1]["well_ID"].ToString().Trim();
        string Lastlongitude = wellTable.Rows[rcdNum - 1]["longitude"].ToString().Trim();
        string Lastlatitude = wellTable.Rows[rcdNum - 1]["latitude"].ToString().Trim();
        //string LastName = usersTable.Rows[rcdNum - 1]["name"].ToString().Trim();
        string Lastwell_Address = wellTable.Rows[rcdNum - 1]["well_Address"].ToString().Trim();
        string Lastwell_Type = wellTable.Rows[rcdNum - 1]["well_Type"].ToString().Trim();
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

        string iconA = "{ w: 21, h: 21, l: 0, t: 0, x: 6, lb: 5 }";

        string Lasticon = "";
        string iconB = "{ w: 23, h: 25, l: 23, t: 21, x: 9, lb: 12 }";

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




        jsonData.AppendLine("{well_ID:\"" + Lastwell_ID + "\",longitude:\"" + Lastlongitude + "\",latitude:\"" + Lastlatitude + "\",well_Address:\"" + Lastwell_Address + "\",well_Type:\"" + Lastwell_Type + "\",well_Status:\"" + Lastwell_Status + "\",content:\"" + Lastcontent + "\",isopen:" + Lastisopen + ",icon:" + Lasticon + "}");
        jsonData.AppendLine(@"]");

        Response.Write(jsonData.ToString());

        return jsonData;
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
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
        for (int i = 0; i < rcdNum; i++)
        {
            //string Address = "";
            string well_Status = wellTable.Rows[i]["well_Status"].ToString().Trim();
            string well_Address = wellTable.Rows[i]["well_Address"].ToString().Trim();
            switch (well_Status)
            {
                case "0":
                    well_Status = "正常";
                    
                    break;
                case "1":
                    well_Status = "异常";
                   
                    break;
            }
        }


        int wellStatus = 0;
        string sqlstr  = "UPDATE well_Info SET well_Status=" + wellStatus;


        SqlCommand cmd1 = new SqlCommand(sqlstr, selectConnection);
        //SqlDataAdapter sda = new SqlDataAdapter(cmd);
        try
        {
            selectConnection.Open();
            cmd1.ExecuteNonQuery();
          
        }
        //catch (Exception err)
        //{
        //    this.Invoke(a, err.Message);
        //    return false;
        //}
        finally
        {
            selectConnection.Close();
        }

        Response.Write("<script language=javascript>alert( '所有出现异常井盖模块已成功复位!');</script>");
    
    }
}