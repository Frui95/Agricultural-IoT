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
using Newtonsoft.Json;

public partial class ajax_infosearch : System.Web.UI.Page
{
    public string airtemper = "";
    public string airhum = "";
    public string landhum = "";
    public string light = "";
    public string conductance = "";
    public string begintime = "";
    public string endtime = "";
    public string oneoffivedata = "";
    public string nodes_id = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "text/plain";
        Response.Charset = "UTF-8";
        getDataset();//调用getDataset函数
        Response.End();
    }
    private void getDataset()
    {
        if (Request.QueryString["begintime"] != null) { begintime = Request.QueryString["begintime"].ToString(); }
        if (Request.QueryString["endtime"] != null) { endtime = Request.QueryString["endtime"].ToString(); }
        if (Request.QueryString["oneoffivedata"] != null) { oneoffivedata = Request.QueryString["oneoffivedata"].ToString(); }
        if (Request.QueryString["nodes_id"] != null) { nodes_id = Request.QueryString["nodes_id"].ToString(); }
        //begintime = "2016-02-27 15:14:42.207";
        //endtime = "2016-02-28 22:09:33.183";
        //oneoffivedata = "airtemper";
        SqlConnection selectconnection= new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
        string mycmd = "select convert(varchar(20),time,120), " + oneoffivedata + " as col from greenhouse_info where time between '"+begintime+"'"+" and '"+endtime+"'"+"AND nodes_id='"+nodes_id+"'";
        SqlCommand cmd = new SqlCommand(mycmd, selectconnection);
        cmd.CommandTimeout = 0;
        DataSet ds = new DataSet();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        try
        {
            sda.Fill(ds);
            DataTable searchtable = new DataTable();
            sda.Fill(searchtable);
            Response.Write(JsonConvert.SerializeObject(searchtable));
        }
        catch (SqlException ex) {  }
        finally { cmd.Dispose(); }
       
    }
}