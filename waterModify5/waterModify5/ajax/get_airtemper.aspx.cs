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
public partial class ajax_get_airtemper : System.Web.UI.Page
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
        DataSet ds = new DataSet();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);

        string sql = "SELECT * FROM greenhouse_info order by time asc";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);       
        sda.Fill(ds);
        DataTable airTable = ds.Tables[0];
        
        
        StringBuilder jsonData = new StringBuilder();
        int rcdNum = airTable.Rows.Count;

        jsonData.AppendLine("{\"rows\":[");
        for (int i = 0; i < rcdNum - 1; i++)
        {
            string airtemper = airTable.Rows[i]["airtemper"].ToString().Trim();
            string shijian = airTable.Rows[i]["time"].ToString().Trim();
            jsonData.AppendLine("{\"airtemper\":\"" + airtemper + "\"," +
                "\"shijian\":\"" + shijian +
                 "\"},");


        }
        string lastairtemper = airTable.Rows[rcdNum - 1]["airtemper"].ToString().Trim();
        string lastshijian = airTable.Rows[rcdNum - 1]["time"].ToString().Trim();
        jsonData.AppendLine("{\"airtemper\":\"" + lastairtemper + "\"," +
                "\"shijian\":\"" + lastshijian +
                 "\"}");
        jsonData.AppendLine(@"]}");
        Response.Write(jsonData.ToString ());
        ////JsonConvert.SerializeObject(jsonData);
        //Response.Write(JsonConvert.SerializeObject(jsonData));
        cmd.Dispose();
    }
}