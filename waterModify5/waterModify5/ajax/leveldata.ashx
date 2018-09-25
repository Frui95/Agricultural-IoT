<%@ WebHandler Language="C#" Class="leveldata" %>

using System;
using System.Web;
using System.Data;
using Newtonsoft.Json;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
public class leveldata : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(CreateDataTable()));
        context.Response.End();




        //context.Response.ContentType = "text/plain";
        //DateTime dateTime = DateTime.Now;
        //System.Data.SqlClient.SqlParameter[] parameters = {  
        //            new System.Data.SqlClient.SqlParameter("@datetime",dateTime)
        //            };
        //System.Data.DataTable dt = LQJ.Comment.SqlHelp.RunDataTableProcedure("Proc_LoginRecordCount", parameters);
        //context.Response.Write(JsonConvert.GetJSON(dt));
        //context.Response.End();
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
        string comStr = "select airtemper,time from greenhouse_info";
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