<%@ WebHandler Language="C#" Class="KLineConductance" %>

using System;
using System.Web;
using System.Data;
using Newtonsoft.Json;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
public class KLineConductance : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
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
        string comStr = "select 日期,Open_Con,Close_Con,Min_Con,Max_Con , avg from K_Line_Con";
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