using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace waterModify
{
    /// <summary>
    /// CheckUser ��ժҪ˵����
    /// </summary>
    public class CheckUser
    {
        public string Description;//�����û����͵�����
        public bool IsValid;//bool�ͱ������ж��Ƿ����
        public int Rank;

        public CheckUser(string UserName, string UserPwd)//�ж��û���������
        {
            //�������ݿ����Ӳ���
            SqlConnection selectConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["connstring"].ConnectionString);
            //��������������
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Users WHERE user_Name='" + UserName + "' AND user_PWD='" + UserPwd + "'", selectConnection);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            selectConnection.Close();
            //������ݿ�������Ӧ�����ݣ�����Ӧ������ֵ
            if (dataSet.Tables[0].Rows.Count == 1)
            {
                this.IsValid = true;
                this.Rank = Convert.ToInt16(dataSet.Tables[0].Rows[0]["Role"]);//��Role�е�����ת��Ϊ16λ�з�����
                this.Description = dataSet.Tables[0].Rows[0]["Role"].ToString();
            }
            else
            {
                this.IsValid = false;
            }
        }
    }
}
