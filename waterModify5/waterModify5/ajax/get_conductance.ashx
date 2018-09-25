<%@ WebHandler Language="C#" Class="get_conductance" %>

using System;
using System.Web;
using System.Data;
using Newtonsoft.Json;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

public class get_conductance : IHttpHandler {
    string nodes_id = "";
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        if (context.Request.QueryString["nodes_id"] != null) { nodes_id = context.Request.QueryString["nodes_id"].ToString(); }
        context.Response.Write(JsonConvert.SerializeObject(CreateDataTable()));
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    public DataTable CreateDataTable()
    {
        DataTable Table = new DataTable();
        //string LinkStr = "Data Source=NEWMI;Initial Catalog=water; uid=sa;pwd=sjtumi!863";
        string LinkStr = ConfigurationManager.ConnectionStrings["connstring"].ConnectionString;
        SqlConnection myCon = new SqlConnection(LinkStr);  //Linestr为连接路径
        //string comStr = "select well_ID,well_lev from well_Info where well_lev !=-1";
        //string comStr = "select conductance,time from greenhouse_info where nodes_id='" + nodes_id + "'";
        string comStr = "select conductance,CONVERT(VARCHAR(10),time,108) as time from greenhouse_info where convert(varchar(10),time,120)=convert(varchar(10),getdate(),120) and nodes_id='" + nodes_id + "'";
        SqlCommand myCom = new SqlCommand(comStr, myCon);
        myCom.CommandTimeout = 0;
        SqlDataAdapter Adapter = new SqlDataAdapter(myCom);
        try
        {
            Adapter.Fill(Table);
            return Table;
        }
        catch (SqlException e)
        {
            //this.MessageBox.Show(e.Message);
            return Table;
        }
        finally
        {
            myCom.Dispose();
        }

    }

}