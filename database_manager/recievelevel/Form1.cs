using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Threading;
using System.Net;
using System.Net.Sockets;
using System.Data.SqlClient;
using System.IO;



namespace recievelevel
{
    public partial class Form1 : Form
    {
        private delegate void statusStripInfo(string str1);
        private statusStripInfo a;
        //private statusStripInfo b;
        private TcpListener tcpListener;
        private bool isExit = false;
        private ManualResetEvent allDone = new ManualResetEvent(false);
        private Thread acceptThread;
        private string IPstr = "";
        private int port=0;
       // private IPEndPoint Rcver = new IPEndPoint(IPAddress.Parse("210.51.26.138"), 4040);
        //private Socket s = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

        public Form1()
        {
            InitializeComponent();
            this.btnStart.Enabled = false;
            this.btnStop.Enabled = false;
            a = new statusStripInfo(setText);
            //Reflash();
            //IPAddress ipaddress = IPAddress.Parse(IPstr);
            //int Port =port ;

            //tcpListener = new TcpListener(ipaddress, Port);
            
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO:  这行代码将数据加载到表“greenHouseDataSet14.K_Line_Con”中。您可以根据需要移动或删除它。
            this.k_Line_ConTableAdapter1.Fill(this.greenHouseDataSet14.K_Line_Con);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet13.K_Line_Light”中。您可以根据需要移动或删除它。
            this.k_Line_LightTableAdapter1.Fill(this.greenHouseDataSet13.K_Line_Light);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet12.K_Line_Hum_Land”中。您可以根据需要移动或删除它。
            this.k_Line_Hum_LandTableAdapter1.Fill(this.greenHouseDataSet12.K_Line_Hum_Land);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet11.K_Line_Temperature”中。您可以根据需要移动或删除它。
            this.k_Line_TemperatureTableAdapter1.Fill(this.greenHouseDataSet11.K_Line_Temperature);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet10.K_Line_Hum_Air”中。您可以根据需要移动或删除它。
            this.k_Line_Hum_AirTableAdapter1.Fill(this.greenHouseDataSet10.K_Line_Hum_Air);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet9.greenhouse_info”中。您可以根据需要移动或删除它。
            this.greenhouse_infoTableAdapter1.Fill(this.greenHouseDataSet9.greenhouse_info);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet8.greenhouse_info”中。您可以根据需要移动或删除它。
            this.greenhouse_infoTableAdapter.Fill(this.greenHouseDataSet8.greenhouse_info);
           
           
            // TODO:  这行代码将数据加载到表“greenHouseDataSet5.K_Line_Con”中。您可以根据需要移动或删除它。
            //this.k_Line_ConTableAdapter.Fill(this.greenHouseDataSet5.K_Line_Con);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet4.K_Line_Light”中。您可以根据需要移动或删除它。
            //this.k_Line_LightTableAdapter.Fill(this.greenHouseDataSet4.K_Line_Light);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet3.K_Line_Hum_Land”中。您可以根据需要移动或删除它。
            //this.k_Line_Hum_LandTableAdapter.Fill(this.greenHouseDataSet3.K_Line_Hum_Land);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet2.K_Line_Hum_Air”中。您可以根据需要移动或删除它。
            //this.k_Line_Hum_AirTableAdapter.Fill(this.greenHouseDataSet2.K_Line_Hum_Air);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet1.K_Line_Temperature”中。您可以根据需要移动或删除它。
            //this.k_Line_TemperatureTableAdapter.Fill(this.greenHouseDataSet1.K_Line_Temperature);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet.greenhouse_info”中。您可以根据需要移动或删除它。
            //this.greenhouse_infoTableAdapter.Fill(this.greenHouseDataSet.greenhouse_info);
            // TODO:  这行代码将数据加载到表“greenHouseDataSet.greenhouse_info”中。您可以根据需要移动或删除它。
            
            // TODO: 这行代码将数据加载到表“waterDataSet.level”中。您可以根据需要移动或删除它。
            //this.levelTableAdapter.Fill(this.waterDataSet.level);
            // TODO: 这行代码将数据加载到表“waterDataSet1.level”中。您可以根据需要移动或删除它。
            //this.levelTableAdapter.Fill(this.waterDataSet1.level);
            //Reflash();
           // try
           //{
            //    TcpClient tcp = tcpListener.AcceptTcpClient();
            // }
            //catch (Exception exc)
            //{
           //     MessageBox.Show(exc.Message);
           // }
           // try
           // {
            //    s.Connect(Rcver);
           // }
           // catch (Exception ex)
            //{
            //    MessageBox.Show(ex.Message);
            //    this.Close();
           // }

        }

        private void Connect(Thread acceptThread)
        {
            //throw new NotImplementedException();
            return;
        }

        private void AcceptConnection()
        {


            while (!isExit)
            {
                byte[] btServerReceive = new byte[1024];
                UpdateUI setEvent = new UpdateUI(onSet);
                string strServerReceive = string.Empty;
                string outstr = string.Empty;
                bool flat = false;
                
                TcpClient tcp = tcpListener.AcceptTcpClient();
                
                
                while (true)
                {
                   


                    //开启网络流，开始接受数据
                    NetworkStream ns = tcp.GetStream();
                    try
                    {
                        int intReceiveLength = ns.Read(btServerReceive, 0, btServerReceive.Length);//原先是read方法
                    }
                    catch(IOException e)
                    {
                        jinggao();
                        //throw e;
                        
                    }
                    //outstr = System.Text.Encoding.Unicode.GetString(btServerReceive);
                    outstr = ASCIIEncoding.ASCII.GetString(btServerReceive);//处理ascii码流
                    string recstr = outstr.Trim();
                    try
                    {
                        //for (int i = 0; i < btServerReceive.Length; i++)
                        //{
                        //    strServerReceive += btServerReceive[i].ToString();
                        //}


                        flat = Conver16to10AndSaveToDatabase(recstr );
                        DateTime now = DateTime.Now;
                        int t = now.Hour;
                        if (flat && 10<=t)
                        {
                            KLineAirtemperature();
                            KLineHumAir();
                            KLineLandAir();
                            KLineLight();
                            KLineCon();
                            break;
                            //this.label3.Text = "数据接收成功";
                        }

                        else
                        {
                            //MessageBox.Show("存储失败");
                            break;
                        }

                    }
                    catch (IOException)
                    {
                        
                       
                        tcp.Close();
                       
                    }

                    finally
                    {
                        tcp.Close();

                    }
                }
                this.Invoke(setEvent, outstr);
                //this.Invoke(setEvent, strServerReceive); 
            }
        }

        //private void Invoke(UpdateUI setEvent, string strServerReceive)
        //{
        //    throw new NotImplementedException();
        //}
        private delegate void UpdateUI(string strServerReceive);
        private void onSet(string mess)
        {
            //截取字符
            int i = 100;
            string str = mess;
            string strleft = str.Substring(0, i);
            RecTxt.Text += DateTime.Now.ToString();
            RecTxt.Text += ":" + strleft + "\n\r";
            RecTxt.SelectionStart = RecTxt.Text.Length;
            RecTxt.ScrollToCaret();
        }


        
 
        private void setText(string str)
        {
            textBoxState.Text += DateTime.Now.ToString();
            textBoxState.Text += "  " + str + "\n\r";
            textBoxState.SelectionStart = textBoxState.Text.Length;
            textBoxState.ScrollToCaret();
        }


        private bool Conver16to10AndSaveToDatabase(string number)
        {

            //CharEnumerator CEnumerator = number.GetEnumerator();
            //string number2 = "";

            //while (CEnumerator.MoveNext())                              //去空格
            //{

            //    byte[] array = new byte[1];

            //    array = System.Text.Encoding.ASCII.GetBytes(CEnumerator.Current.ToString());

            //    int asciicode = (short)(array[0]);

            //    if (asciicode != 32)
            //    {

            //        number2 += CEnumerator.Current.ToString();

            //    }
            //}


            string insertSQL = "";
            //string sqlstr = "";
            //string wellstr = "";
            try
            {
                //string str = number2.Substring(4, 4) + "." + number2.Substring(0, 4);

                //double AD = Convert.ToDouble(str);
                //textBoxState.Text = "";
                //textBoxState.Text = number2;

                //string str = Convert.ToInt32(number2.Substring(4, 4), 16).ToString();
                //string str1 = Convert.ToInt32(number2.Substring(0, 4), 16).ToString();
                //string AD = str + "." + str1;
                ////string AD = Convert.ToInt32(number2.Substring(0, 8), 16).ToString();
                //string Address = number2.Substring(10, 4).ToString();
                //string wellStatus = Convert.ToInt32(number2.Substring(8, 2), 16).ToString();
                //string airtem1 = Convert.ToInt32(number.Substring(0, 3)).ToString();
                //string airtem2 = Convert.ToInt32(number.Substring(3, 2)).ToString().PadLeft(2, '0');
                //string airhum1 = Convert.ToInt32(number.Substring(5, 2)).ToString().PadLeft(2, '0');
                //string airhum2 = Convert.ToInt32(number.Substring(7, 2)).ToString().PadLeft(2, '0');
                //string landhum1 = Convert.ToInt32(number.Substring(9, 2)).ToString().PadLeft(2,'0');
                //string landhum2 = Convert.ToInt32(number.Substring(11, 2)).ToString().PadLeft(2,'0');
                //string lighting = Convert.ToInt32(number.Substring(13, 6)).ToString();
                //string con1 = Convert.ToInt32(number.Substring(19,2)).ToString().PadLeft(2,'0');
                //string con2 = Convert.ToInt32(number.Substring(21,3)).ToString().PadLeft(3,'0');
                //string airtemper = airtem1 +"."+ airtem2;
                //string airhum = airhum1 +"."+ airhum2;
                //string landhum = landhum1 +"."+ landhum2;
                //string light = lighting;
                //string Con = con1 + "." + con2;
                string[] str1 = number.Split(',');//字符串分割
                string nodes_id = str1[0];
                string airtemper = str1[1];
                string airhum = str1[2];
                string landhum = str1[3];
                string Con = str1[4];
                string light = str1[5];
                
                

                insertSQL = "INSERT INTO greenhouse_info (airtemper,airhum,landhum,light,conductance,time,nodes_id)";
                insertSQL += "VALUES(";
                insertSQL += "'" + airtemper + "'," + "'" + airhum + "'," + "'" + landhum + "'," + "'" + light + "'," +"'"+Con+"',"+"GETDATE()"+",'"+nodes_id+"'"+")";
                 


                //insertSQL = "INSERT INTO level(levInfo,well_Address,Datetime,well_Status) ";
                //insertSQL += "VALUES (";

                //insertSQL += "'" + AD + "',";

                //insertSQL += "'" + Address + "',";
                //insertSQL += "getdate(),";
                //insertSQL += "'" + wellStatus + "'";
                //insertSQL += ")";


                //sqlstr = "UPDATE well_info SET well_Status = '" + wellStatus + "',well_lev = '" + AD + "' WHERE well_Address = '" + Address + "'";
                //wellstr = "UPDATE well_Alert SET well_Status=" + wellStatus + " WHERE well_Address ='" + Address + "'";
                //MessageBox.Show("数据插入成功");
                //Reflash();
            }
            catch(Exception)
            {
                //MessageBox.Show(number2);
                //throw ex;
                //Console.WriteLine(ex.Message);
                return true;
            }



            this.Invoke(a, insertSQL);
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(insertSQL, con);
            //SqlCommand cmd1 = new SqlCommand(sqlstr, con);
            //SqlCommand cmd2 = new SqlCommand(wellstr, con);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //cmd1.ExecuteNonQuery();
                //cmd2.ExecuteNonQuery();
                return true;
            }
            catch (Exception err)
            {
                this.Invoke(a, err.Message);
                return false;
            }
           
            finally
            {
                con.Close();
            }





        }
        private void  KLineAirtemperature()
        {
           
                string selectSQL = "";
                string insertSQl = "";
                string updateSQL = "";
                string selectKLineTemperature = "";
                selectSQL = "select convert(varchar(10),time,120),airtemper from greenhouse_info where convert(varchar(10),time,120)=convert(varchar(10),getdate(),120)";
                SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
                SqlCommand cmd = new SqlCommand(selectSQL, con);
                con.Open();
                DataSet ds = new DataSet();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
             try
                {
                sda.Fill(ds);
                con.Close();
             }
             catch (SqlException e)
             {
                 throw e;
                 
             }
             finally
             {
                 con.Close(); 
             }
                DataTable KLineTemperatureTable = ds.Tables[0];
                int rcdNum = KLineTemperatureTable.Rows.Count;
                string Open_Temperature = KLineTemperatureTable.Rows[0]["airtemper"].ToString().Trim();
                string Close_Temperature = KLineTemperatureTable.Rows[rcdNum - 1]["airtemper"].ToString().Trim();
                string a = KLineTemperatureTable.Rows[0]["airtemper"].ToString().Trim();//为比大小准备初始值
                float b = float.Parse(a);//将字符串转为单精度浮点型数据
                float c = float.Parse(a);
                float avg=0;
                float sumtemper = 0;
                for (int i = 0; i < rcdNum; i++)
                {                   
                    string MAXTemper = KLineTemperatureTable.Rows[i]["airtemper"].ToString().Trim();
                    float atemper = float.Parse(MAXTemper);
                    if (b < atemper)
                    {
                        b = atemper;
                    }
                    
                    sumtemper+=float.Parse(KLineTemperatureTable.Rows[i]["airtemper"].ToString().Trim());//求和
                    
                }
                avg = sumtemper / rcdNum;//求温度的均值
                string Max_Temperature = b.ToString().Trim();

                for (int i = 0; i < rcdNum; i++)
                {
                    string MINTemper = KLineTemperatureTable.Rows[i]["airtemper"].ToString().Trim();
                    float min = float.Parse(MINTemper);
                    if (c > min)
                    {
                        c = min;
                    }
                }
                string Min_Temperature = c.ToString().Trim();
            
            
            insertSQl = "INSERT INTO K_Line_Temperature ";
            insertSQl += "VALUES(";
            insertSQl += "CONVERT(varchar(10),GETDATE(),120)," + "'" + Open_Temperature + "'," + "'" + Close_Temperature + "'," + "'" + Min_Temperature + "'," + "'" + Max_Temperature + "'," + "'" +avg+ "')";
            updateSQL = "UPDATE K_Line_Temperature ";
            updateSQL += "SET 日期 = CONVERT(varchar(10),GETDATE(),120)";            
            updateSQL += " ,Open_Airtemper =" + "'" + Open_Temperature + "'";
            updateSQL += ",Close_Airtemper =" + "'" + Close_Temperature + "'";
            updateSQL += ",Min_Airtemper =" + "'" + Min_Temperature + "'";
            updateSQL += ",Max_Airtemper =" + "'" + Max_Temperature + "'";
            updateSQL += ",avg =" + "'" + avg + "'";
            updateSQL += " WHERE 日期=CONVERT(varchar(10),GETDATE(),120)";
            selectKLineTemperature = "select count(*) from K_Line_Temperature where convert(varchar(10),日期,120)=convert(varchar(10),getdate(),120)";
            SqlCommand InsertCmd = new SqlCommand(insertSQl,con);
            SqlCommand UpdateCmd = new SqlCommand(updateSQL, con);
            SqlCommand selectKLineCmd = new SqlCommand(selectKLineTemperature, con);
            con.Open();
            int val = Convert.ToInt32(selectKLineCmd.ExecuteScalar());
            con.Close();
            if (val > 0)
            {
                try
                {
                    con.Open();
                    UpdateCmd.ExecuteNonQuery();
                }
                
                catch (SqlException e)
                {
                    throw e;
                    con.Close();
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                try
                {
                    con.Open();
                    InsertCmd.ExecuteNonQuery();

                }
                catch (SqlException err)
                {
                    throw err;
                    con.Close();
                }

                finally
                {
                    con.Close();
                }
            }
        
        }//处理温度的K线数据存入数据库
        private void KLineHumAir()
        {

            string selectSQL = "";
            string insertSQl = "";
            string updateSQL = "";
            selectSQL = "select convert(varchar(10),time,120),airhum from greenhouse_info where convert(varchar(10),time,120)=convert(varchar(10),getdate(),120)";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            try
            {
                sda.Fill(ds);
            }
            catch (SqlException e)
            {
                throw e;

            }
            finally
            {
                con.Close();
            }
            DataTable KLineAirHumTable = ds.Tables[0];
            int rcdNum = KLineAirHumTable.Rows.Count;
            string Open_AirHum = KLineAirHumTable.Rows[0]["airhum"].ToString().Trim();
            string Close_AirHum = KLineAirHumTable.Rows[rcdNum - 1]["airhum"].ToString().Trim();
            string a = KLineAirHumTable.Rows[0]["airhum"].ToString().Trim();//为比大小准备初始值
            float b = float.Parse(a);//将字符串转为单精度浮点型数据
            float c = float.Parse(a);
            float avg = 0;
            float sumhum = 0;
            for (int i = 0; i < rcdNum; i++)
            {
                string MAXHum = KLineAirHumTable.Rows[i]["airhum"].ToString().Trim();
                float ahum = float.Parse(MAXHum);
                if (b < ahum)
                {
                    b = ahum;
                }
                sumhum += float.Parse(KLineAirHumTable.Rows[i]["airhum"].ToString().Trim());//求和
            }
            avg = sumhum / rcdNum;
            string Max_AirHum = b.ToString().Trim();

            for (int i = 0; i < rcdNum; i++)
            {
                string MINHum = KLineAirHumTable.Rows[i]["airhum"].ToString().Trim();
                float min = float.Parse(MINHum);
                if (c > min)
                {
                    c = min;
                }
            }
            string Min_AirHum = c.ToString().Trim();


            insertSQl = "INSERT INTO K_Line_Hum_Air ";
            insertSQl += "VALUES(";
            insertSQl += "CONVERT(varchar(10),GETDATE(),120)," + "'" + Open_AirHum + "'," + "'" + Close_AirHum + "'," + "'" + Min_AirHum + "'," + "'" + Max_AirHum + "'," + "'" + avg + "')";
            updateSQL = "UPDATE K_Line_Hum_Air ";
            updateSQL += "SET 日期 = CONVERT(varchar(10),GETDATE(),120)";
            updateSQL += " ,Open_Hum =" + "'" + Open_AirHum + "'";
            updateSQL += ",Close_Hum =" + "'" + Close_AirHum + "'";
            updateSQL += ",Min_Hum =" + "'" + Min_AirHum + "'";
            updateSQL += ",Max_Hum =" + "'" + Max_AirHum + "'";
            updateSQL += ",avg =" + "'" + avg + "'";
            updateSQL += " WHERE 日期=CONVERT(varchar(10),GETDATE(),120)";
            string selectKLineHumAir = "select count(*) from K_Line_Hum_Air where convert(varchar(10),日期,120)=convert(varchar(10),getdate(),120)";
            SqlCommand InsertCmd = new SqlCommand(insertSQl, con);
            SqlCommand UpdateCmd = new SqlCommand(updateSQL, con);
            SqlCommand selectKLineCmd = new SqlCommand(selectKLineHumAir, con);
            con.Open();
            int val = Convert.ToInt32(selectKLineCmd.ExecuteScalar());
            con.Close();
            if (val > 0)
            {
                try
                {
                    con.Open();
                    UpdateCmd.ExecuteNonQuery();
                }

                catch (SqlException e)
                {
                    throw e;
                    con.Close();
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                try
                {
                    con.Open();
                    InsertCmd.ExecuteNonQuery();

                }
                catch (SqlException err)
                {
                    throw err;
                    con.Close();
                }

                finally
                {
                    con.Close();
                }
            }

        }//处理空气湿度的K先数据存入数据库
        private void KLineLandAir()
        {

            string selectSQL = "";
            string insertSQl = "";
            string updateSQL = "";
            selectSQL = "select convert(varchar(10),time,120),landhum from greenhouse_info where convert(varchar(10),time,120)=convert(varchar(10),getdate(),120)";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            try
            {
                sda.Fill(ds);
            }
            catch (SqlException e)
            {
                throw e;

            }
            finally
            {
                con.Close();
            }
            DataTable KLineLandHumTable = ds.Tables[0];
            int rcdNum = KLineLandHumTable.Rows.Count;
            string Open_LandHum = KLineLandHumTable.Rows[0]["landhum"].ToString().Trim();
            string Close_LandHum = KLineLandHumTable.Rows[rcdNum - 1]["landhum"].ToString().Trim();
            string a = KLineLandHumTable.Rows[0]["landhum"].ToString().Trim();//为比大小准备初始值
            float b = float.Parse(a);//将字符串转为单精度浮点型数据
            float c = float.Parse(a);
            float avg = 0;
            float sumlandhum = 0;
            for (int i = 0; i < rcdNum; i++)
            {
                string MAXHum = KLineLandHumTable.Rows[i]["landhum"].ToString().Trim();
                float ahum = float.Parse(MAXHum);
                if (b < ahum)
                {
                    b = ahum;
                }
                sumlandhum += float.Parse(KLineLandHumTable.Rows[i]["landhum"].ToString().Trim());//求和
            }
            avg = sumlandhum / rcdNum;
            string Max_LandHum = b.ToString().Trim();

            for (int i = 0; i < rcdNum; i++)
            {
                string MINHum = KLineLandHumTable.Rows[i]["landhum"].ToString().Trim();
                float min = float.Parse(MINHum);
                if (c > min)
                {
                    c = min;
                }
            }
            string Min_LandHum = c.ToString().Trim();


            insertSQl = "INSERT INTO K_Line_Hum_Land ";
            insertSQl += "VALUES(";
            insertSQl += "CONVERT(varchar(10),GETDATE(),120)," + "'" + Open_LandHum + "'," + "'" + Close_LandHum + "'," + "'" + Min_LandHum + "'," + "'" + Max_LandHum + "'," + "'" + avg + "')";
            updateSQL = "UPDATE K_Line_Hum_Land ";
            updateSQL += "SET 日期 = CONVERT(varchar(10),GETDATE(),120)";
            updateSQL += " ,Open_Hum =" + "'" + Open_LandHum + "'";
            updateSQL += ",Close_Hum =" + "'" + Close_LandHum + "'";
            updateSQL += ",Min_Hum =" + "'" + Min_LandHum + "'";
            updateSQL += ",Max_Hum =" + "'" + Max_LandHum + "'";
            updateSQL += ",avg =" + "'" + avg + "'";
            updateSQL += " WHERE 日期=CONVERT(varchar(10),GETDATE(),120)";
            string selectKLineHumLand = "select count(*) from K_Line_Hum_Land where convert(varchar(10),日期,120)=convert(varchar(10),getdate(),120)";
            SqlCommand InsertCmd = new SqlCommand(insertSQl, con);
            SqlCommand UpdateCmd = new SqlCommand(updateSQL, con);
            SqlCommand selectKLineCmd = new SqlCommand(selectKLineHumLand, con);
            con.Open();
            int val = Convert.ToInt32(selectKLineCmd.ExecuteScalar());
            con.Close();
            if (val > 0)
            {
                try
                {
                    con.Open();
                    UpdateCmd.ExecuteNonQuery();
                }

                catch (SqlException e)
                {
                    throw e;
                    con.Close();
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                try
                {
                    con.Open();
                    InsertCmd.ExecuteNonQuery();

                }
                catch (SqlException err)
                {
                    throw err;
                    con.Close();
                }

                finally
                {
                    con.Close();
                }
            }
            

        }//处理土壤湿度的K线数据存入数据库
        private void KLineLight()
        {

            string selectSQL = "";
            string insertSQl = "";
            string updateSQL = "";
            selectSQL = "select convert(varchar(10),time,120),light from greenhouse_info where convert(varchar(10),time,120)=convert(varchar(10),getdate(),120)";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            try
            {
                sda.Fill(ds);
            }
            catch (SqlException e)
            {
                throw e;

            }
            finally
            {
                con.Close();
            }
            DataTable KLineLightTable = ds.Tables[0];
            int rcdNum = KLineLightTable.Rows.Count;
            string Open_Light = KLineLightTable.Rows[0]["light"].ToString().Trim();
            string Close_Light = KLineLightTable.Rows[rcdNum - 1]["light"].ToString().Trim();
            string a = KLineLightTable.Rows[0]["light"].ToString().Trim();//为比大小准备初始值
            float b = float.Parse(a);//将字符串转为单精度浮点型数据
            float c = float.Parse(a);
            float avg = 0;
            float sumlight = 0;
            for (int i = 0; i < rcdNum; i++)
            {
                string MAXLight = KLineLightTable.Rows[i]["light"].ToString().Trim();
                float alight = float.Parse(MAXLight);
                if (b < alight)
                {
                    b = alight;
                }
                sumlight += float.Parse(KLineLightTable.Rows[i]["light"].ToString().Trim());//求和
            }
            avg = sumlight / rcdNum;
            string Max_Light = b.ToString().Trim();

            for (int i = 0; i < rcdNum; i++)
            {
                string MINLight = KLineLightTable.Rows[i]["light"].ToString().Trim();
                float min = float.Parse(MINLight);
                if (c > min)
                {
                    c = min;
                }
            }
            string Min_Light = c.ToString().Trim();


            insertSQl = "INSERT INTO K_Line_Light ";
            insertSQl += "VALUES(";
            insertSQl += "CONVERT(varchar(10),GETDATE(),120)," + "'" + Open_Light + "'," + "'" + Close_Light + "'," + "'" + Min_Light + "'," + "'" + Max_Light + "'," + "'" + avg + "')";
            updateSQL = "UPDATE K_Line_Light ";
            updateSQL += "SET 日期 = CONVERT(varchar(10),GETDATE(),120)";
            updateSQL += " ,Open_Light =" + "'" + Open_Light + "'";
            updateSQL += ",Close_Light =" + "'" + Close_Light + "'";
            updateSQL += ",Min_Light =" + "'" + Min_Light + "'";
            updateSQL += ",Max_Light =" + "'" + Max_Light + "'";
            updateSQL += ",avg =" + "'" + avg + "'";
            updateSQL += " WHERE 日期=CONVERT(varchar(10),GETDATE(),120)";
            string selectKLineLight = "select count(*) from K_Line_Light where convert(varchar(10),日期,120)=convert(varchar(10),getdate(),120)";
            SqlCommand InsertCmd = new SqlCommand(insertSQl, con);
            SqlCommand UpdateCmd = new SqlCommand(updateSQL, con);
            SqlCommand selectKLineCmd = new SqlCommand(selectKLineLight, con);
            con.Open();
            int val = Convert.ToInt32(selectKLineCmd.ExecuteScalar());
            con.Close();
            if (val > 0)
            {
                try
                {
                    con.Open();
                    UpdateCmd.ExecuteNonQuery();
                }

                catch (SqlException e)
                {
                    //throw e;
                    con.Close();
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                try
                {
                    con.Open();
                    InsertCmd.ExecuteNonQuery();

                }
                catch (SqlException err)
                {
                    //throw err;
                    con.Close();
                }

                finally
                {
                    con.Close();
                }
            }


        }
        private void KLineCon()
        {
            string selectSQL = "";
            string insertSQl = "";
            string updateSQL = "";
            selectSQL = "select convert(varchar(10),time,120),conductance from greenhouse_info where convert(varchar(10),time,120)=convert(varchar(10),getdate(),120)";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(selectSQL, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            try
            {
                sda.Fill(ds);
            }
            catch (SqlException e)
            {
                throw e;

            }
            finally
            {
                con.Close();
            }
            DataTable KLineConTable = ds.Tables[0];
            int rcdNum = KLineConTable.Rows.Count;
            string Open_Con = KLineConTable.Rows[0]["conductance"].ToString().Trim();
            string Close_Con = KLineConTable.Rows[rcdNum - 1]["conductance"].ToString().Trim();
            string a = KLineConTable.Rows[0]["conductance"].ToString().Trim();//为比大小准备初始值
            float b = float.Parse(a);//将字符串转为单精度浮点型数据
            float c = float.Parse(a);
            float avg = 0;
            float sumcon = 0;
            for (int i = 0; i < rcdNum; i++)
            {
                string MAXCon = KLineConTable.Rows[i]["conductance"].ToString().Trim();
                float acon = float.Parse(MAXCon);
                if (b < acon)
                {
                    b = acon;
                }
                sumcon += float.Parse(KLineConTable.Rows[i]["conductance"].ToString().Trim());//求和
            }
            avg = sumcon / rcdNum;
            string Max_Con = b.ToString().Trim();

            for (int i = 0; i < rcdNum; i++)
            {
                string MINCon = KLineConTable.Rows[i]["conductance"].ToString().Trim();
                float min = float.Parse(MINCon);
                if (c > min)
                {
                    c = min;
                }
            }
            string Min_Con = c.ToString().Trim();


            insertSQl = "INSERT INTO K_Line_Con ";
            insertSQl += "VALUES(";
            insertSQl += "CONVERT(varchar(10),GETDATE(),120)," + "'" + Open_Con + "'," + "'" + Close_Con + "'," + "'" + Min_Con + "'," + "'" + Max_Con + "'," + "'" + avg + "')";
            updateSQL = "UPDATE K_Line_Con ";
            updateSQL += "SET 日期 = CONVERT(varchar(10),GETDATE(),120)";
            updateSQL += " ,Open_Con =" + "'" + Open_Con + "'";
            updateSQL += ",Close_Con =" + "'" + Close_Con + "'";
            updateSQL += ",Min_Con =" + "'" + Min_Con + "'";
            updateSQL += ",Max_Con =" + "'" + Max_Con + "'";
            updateSQL += ",avg =" + "'" + avg + "'";
            updateSQL += " WHERE 日期=CONVERT(varchar(10),GETDATE(),120)";
            string selectKLineCon = "select count(*) from K_Line_Con where convert(varchar(10),日期,120)=convert(varchar(10),getdate(),120)";
            SqlCommand InsertCmd = new SqlCommand(insertSQl, con);
            SqlCommand UpdateCmd = new SqlCommand(updateSQL, con);
            SqlCommand selectKConCmd = new SqlCommand(selectKLineCon, con);
            con.Open();
            int val = Convert.ToInt32(selectKConCmd.ExecuteScalar());
            con.Close();
            if (val > 0)
            {
                try
                {
                    con.Open();
                    UpdateCmd.ExecuteNonQuery();
                }

                catch (SqlException e)
                {
                    //throw e;
                    con.Close();
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                try
                {
                    con.Open();
                    InsertCmd.ExecuteNonQuery();

                }
                catch (SqlException err)
                {
                    //throw err;
                    con.Close();
                }

                finally
                {
                    con.Close();
                }
            }
        }

        private void Reflash()
        {

            string strCmd = "select * from greenhouse_info order by time ASC";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(strCmd, con);
            con.Open();
            //SqlDataReader reader = cmd.ExecuteReader();
            DataSet ds = new DataSet();

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0].DefaultView;
            //reader.Close();
            con.Close();
            dataGridView1.ClearSelection();
            int index = dataGridView1.Rows.Count - 2;
            dataGridView1.Rows[index].Selected = true;
            dataGridView1.FirstDisplayedScrollingRowIndex = index;
        }//刷新greenhouse_info表
        private void Reflash1()
        {
            string strCmd = "select * from K_Line_Temperature";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(strCmd, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);
            dataGridView2.DataSource = ds.Tables[0].DefaultView;
            con.Close();
            dataGridView2.ClearSelection();
            int index = dataGridView2.Rows.Count - 2;
            dataGridView2.Rows[index].Selected = true;
            dataGridView2.FirstDisplayedScrollingRowIndex = index;
        }//刷新温度K线表
        private void Reflash2()
        {
            string strCmd = "select * from K_Line_Hum_Air";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(strCmd, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);
            dataGridView3.DataSource = ds.Tables[0].DefaultView;
            con.Close();
            dataGridView3.ClearSelection();
            int index = dataGridView3.Rows.Count - 2;
            dataGridView3.Rows[index].Selected = true;
            dataGridView3.FirstDisplayedScrollingRowIndex = index;
        }//刷新空气湿度K线表
        private void Reflash3()
        {
            string strCmd = "select * from K_Line_Hum_Land";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(strCmd, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);
            dataGridView4.DataSource = ds.Tables[0].DefaultView;
            con.Close();
            dataGridView4.ClearSelection();
            int index = dataGridView4.Rows.Count - 2;
            dataGridView4.Rows[index].Selected = true;
            dataGridView4.FirstDisplayedScrollingRowIndex = index;
        }//刷新土壤湿度K线表
        private void Reflash4()//刷新光照K线表
        {
            string strCmd = "select * from K_Line_Light";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(strCmd, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);
            dataGridView5.DataSource = ds.Tables[0].DefaultView;
            con.Close();
            dataGridView5.ClearSelection();
            int index = dataGridView5.Rows.Count - 2;
            dataGridView5.Rows[index].Selected = true;
            dataGridView5.FirstDisplayedScrollingRowIndex = index;
        }
        private void Reflash5()
        {
            string strCmd = "select * from K_Line_Con";
            SqlConnection con = new SqlConnection("Data Source=NEWMI;Initial Catalog=GreenHouse; uid=sa;pwd=sjtumi!863");
            SqlCommand cmd = new SqlCommand(strCmd, con);
            con.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(ds);
            dataGridView6.DataSource = ds.Tables[0].DefaultView;
            con.Close();
            dataGridView6.ClearSelection();
            int index = dataGridView6.Rows.Count - 2;
            dataGridView6.Rows[index].Selected = true;
            dataGridView6.FirstDisplayedScrollingRowIndex = index;

        }
        private void btnStart_Click(object sender, EventArgs e)
        {
            try
            {

                // 启动一个线程来接受请求
                acceptThread = new Thread(AcceptConnection);
                acceptThread.Name = "Listen";

                tcpListener.Start();
                acceptThread.Start();
                isExit = false;
                btnStart.Enabled = false;
                btnStop.Enabled = true;
                setText("开始监听...");
            }
            catch(Exception ex)
            {
                this.Invoke(a, ex.ToString()+"连接错误");

            }

        }

        private void btnStop_Click(object sender, EventArgs e)
        {
            btnStart.Enabled = true;
            btnStop.Enabled = false;
            btnSet.Enabled = true;
            isExit = true;
            allDone.Set();
            this.Invoke(a, "停止监听");
            tcpListener.Stop();
            acceptThread.Abort();
        }

        private void btnSet_Click(object sender, EventArgs e)
        {
            port = Convert.ToInt32(this.textBoxCom.Text.ToString());
            IPstr = this.textBoxIP.Text.ToString();
            IPAddress ipaddress = IPAddress.Parse(IPstr);
            int Port = port;
            tcpListener = new TcpListener(ipaddress, Port);
            btnStart.Enabled = true;
            btnSet.Enabled = false;
        }

        private void btnReflash_Click(object sender, EventArgs e)
        {
            Reflash();
            Reflash1();
            Reflash2();
            Reflash3();
            Reflash4();
            Reflash5();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (acceptThread != null)

                acceptThread.Abort(); 
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void textBoxIP_TextChanged(object sender, EventArgs e)
        {

        }

        //8.25修改
        private void timer1_Tick(object sender, EventArgs e)
        {
            Reflash();
            Reflash1();
            Reflash2();
            Reflash3();
            Reflash4();
            Reflash5();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void RecTxt_TextChanged(object sender, EventArgs e)
        {

        }
        private void jinggao()
        {
            MessageBox.Show(
                "客户端连接已断开，请重新连接！",
                "重要提示",
                MessageBoxButtons.OKCancel,
                MessageBoxIcon.Error,
                MessageBoxDefaultButton.Button2,
                MessageBoxOptions.RtlReading
                );
            acceptThread.Abort();
            acceptThread.Start();
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void textBoxCom_TextChanged(object sender, EventArgs e)
        {

        }
       

       





        
    }
}
