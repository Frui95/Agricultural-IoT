using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userhelp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ShowWord();
    }
    private void ShowWord()
    {
        Response.ContentType = "Application/msword";
        string filePath = MapPath("用户手册.doc");
        Response.WriteFile(filePath);
        Response.End();
    }
}