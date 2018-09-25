using System;
using System.IO;
using System.Text;
using System.Security.Cryptography;

namespace waterModify
{
	/// <summary>
	/// ClassDES ��ժҪ˵����
	/// </summary>
	public class encoder
	{	
		public string sDecrKey; //Key
		public string sDecrIV;  //IV
		public int KeyLength;  //Key��IV�ĳ���

		#region �淶��Կ�ͳ�ʼ������
		private object[] getKey() 
		{ 
			object[] result=new object[3];
			byte[] byKey = null;  
			byte[] IV = null;
			try
			{
				if(sDecrKey.Length<KeyLength)
				{
					string tempStr=sDecrKey;
					for(int i=0;i<(KeyLength-sDecrKey.Length);i++)
						tempStr+="a";
					byKey = System.Text.Encoding.UTF8.GetBytes(tempStr.Substring(0,KeyLength));
				}
				else
				{
					byKey = System.Text.Encoding.UTF8.GetBytes(sDecrKey.Substring(0,KeyLength));
				}

				if(sDecrIV.Length<KeyLength)
				{
					string tempStr=sDecrIV;
					for(int i=0;i<(KeyLength-sDecrIV.Length);i++)
						tempStr+="0";
					IV = System.Text.Encoding.UTF8.GetBytes(tempStr.Substring(0,KeyLength));
				}
				else
				{
					IV = System.Text.Encoding.UTF8.GetBytes(sDecrIV.Substring(0,KeyLength));
				}	
			}
			catch
			{
				result[0]=0;
				result[1]=byKey;
				result[2]=IV;
			}		

			result[0]=KeyLength;
			result[1]=byKey;
			result[2]=IV;
			return result;
		} 
		#endregion

		#region ���ܣ��ԳƼ��ܣ�
		public string DesEncrypt(string strText) 
		{
			try 
			{ 
				object[] mykey=getKey();
				byte[] byKey = (byte[])mykey[1];  
				byte[] IV = (byte[] )mykey[2];			
		
				DESCryptoServiceProvider des = new DESCryptoServiceProvider(); 
				byte[] inputByteArray = System.Text.Encoding.UTF8.GetBytes(strText); 
				MemoryStream ms = new MemoryStream(); 
				CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(byKey, IV), CryptoStreamMode.Write) ; 
				cs.Write(inputByteArray, 0, inputByteArray.Length); 
				cs.FlushFinalBlock(); 
				return Convert.ToBase64String(ms.ToArray()); 
			} 
			catch(System.Exception error) 
			{ 
				return "error:" +error.Message+"\r"; 
			} 
		} 
		#endregion

		#region ���ܣ��ԳƼ��ܣ�
		public string DesDecrypt(string strText) 
		{ 
			try 
			{ 
				object[] mykey=getKey();
				byte[] byKey = (byte[])mykey[1];  
				byte[] IV = (byte[] )mykey[2];

				byte[] inputByteArray = new Byte[strText.Length]; 
				DESCryptoServiceProvider des = new DESCryptoServiceProvider(); 
				inputByteArray = Convert.FromBase64String(strText); 
				MemoryStream ms = new MemoryStream(); 
				CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(byKey, IV), CryptoStreamMode.Write); 
				cs.Write(inputByteArray, 0, inputByteArray.Length); 
				cs.FlushFinalBlock(); 
				System.Text.Encoding encoding = new System.Text.UTF8Encoding(); 
				return encoding.GetString(ms.ToArray()); 
			} 
			catch(System.Exception error) 
			{ 
				return "error:"+error.Message+"\r"; 
			} 			
		} 
		#endregion

		#region MD5���� 
		public byte[] MD5Encrypt(string strText) 
		{ 
			MD5 md5 = new MD5CryptoServiceProvider(); 
			byte[] result = md5.ComputeHash(System.Text.Encoding.Default.GetBytes(strText)); 
			return result;
			//			return System.Text.Encoding.Default.GetString(result); 
		} 
		#endregion
	}	
}