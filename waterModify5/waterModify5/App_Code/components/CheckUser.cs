using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace waterModify
{
    /// <summary>
    /// CheckUser 的摘要说明。
    /// </summary>
    public class CheckUser
    {
        public string Description;//定义用户类型的描述
        public bool IsValid;//bool型变量，判断是否存在
        public int Rank;

        public CheckUser(string UserName, string UserPwd)//判断用户名和密码
        {
            //定义数据库连接参数
            SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
            //定义书库填充内容
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Users WHERE user_Name='" + UserName + "' AND user_PWD='" + UserPwd + "'", selectConnection);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            selectConnection.Close();
            //如果数据库中有相应的内容，给相应参数赋值
            if (dataSet.Tables[0].Rows.Count == 1)
            {
                this.IsValid = true;
                this.Rank = Convert.ToInt16(dataSet.Tables[0].Rows[0]["Role"]);//将Role中的内容转换为16位有符合数
                this.Description = dataSet.Tables[0].Rows[0]["Role"].ToString();
            }
            else
            {
                this.IsValid = false;
            }
        }
    }
}
