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
using Newtonsoft.Json;

public partial class ajax_get_ctr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "text/json";
        Response.Charset = "UTF-8";
        getCtr();//调用getDataset函数
        Response.End();
    }

    private void  getCtr()
    {
        DataSet ds = new DataSet();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);

        string sql = "select * from irrigationCtrl";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);


        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable ctrTable = ds.Tables[0];
        //写json文件
        StringBuilder jsonData = new StringBuilder();
        int rcdNum = ctrTable.Rows.Count;
        jsonData.AppendLine("{\"total\":\"" + rcdNum + "\",\"rows\":[");
        for (int i = 0; i < rcdNum - 1; i++)
        {
            string datetime = ctrTable.Rows[i]["日期"].ToString().Trim();//获得UserName字段内容赋值给UserName
            string opentime = ctrTable.Rows[i]["阀门开启时刻"].ToString().Trim();//获得Role字段的内容，复制给Role
            string closetime = ctrTable.Rows[i]["阀门关断时刻"].ToString().Trim();
            //string Name = usersTable.Rows[i]["user_Name"].ToString().Trim();
            string temperal = ctrTable.Rows[i]["灌溉时长"].ToString().Trim();
            string Operator = ctrTable.Rows[i]["操作员"].ToString().Trim();

            jsonData.AppendLine("{\"日期\":\"" + datetime + "\",\"阀门开启时刻\":\"" + opentime + "\",\"阀门关断时刻\":\"" + closetime + "\",\"灌溉时长\":\"" + temperal + "\",\"操作员\":\"" + Operator + "\"},");

        }
        if (rcdNum - 1 > 0)
        {
            string lastdatetime = ctrTable.Rows[rcdNum - 1]["日期"].ToString().Trim();
            string lastopentime = ctrTable.Rows[rcdNum - 1]["阀门开启时刻"].ToString().Trim();
            string lastclosetime = ctrTable.Rows[rcdNum - 1]["阀门关断时刻"].ToString().Trim();
            string lasttemperal = ctrTable.Rows[rcdNum - 1]["灌溉时长"].ToString().Trim();
            string lastOperator = ctrTable.Rows[rcdNum - 1]["操作员"].ToString().Trim();

            jsonData.AppendLine("{\"日期\":\"" + lastdatetime + "\",\"阀门开启时刻\":\"" + lastopentime + "\",\"阀门关断时刻\":\"" + lastclosetime + "\",\"灌溉时长\":\"" + lasttemperal + "\",\"操作员\":\"" + lastOperator + "\"}");
        }
        jsonData.AppendLine(@"]}");
        Response.Write(jsonData.ToString());
       

    }
}