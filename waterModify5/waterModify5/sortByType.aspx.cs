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

public partial class sortByType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public StringBuilder getType()
    {
        DataSet ds = new DataSet();
        SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);

        string sql = "SELECT * FROM well_info";
        SqlCommand cmd = new SqlCommand(sql, selectConnection);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(ds);
        DataTable wellTable = ds.Tables[0];
        //写json文件
        StringBuilder Type = new StringBuilder();
        int rcdNum = wellTable.Rows.Count;
        Type.AppendLine("[");

        for (int i = 0; i < rcdNum - 1; i++)
        {
            string well_Status = wellTable.Rows[i]["well_Type"].ToString().Trim();
            Type.AppendLine(well_Status + ",");
        }

        string Lastwell_Type = wellTable.Rows[rcdNum - 1]["well_Type"].ToString().Trim();

        Type.AppendLine(Lastwell_Type);
        Type.AppendLine(@"]");

        Response.Write(Type.ToString());

        return Type;


    }

}