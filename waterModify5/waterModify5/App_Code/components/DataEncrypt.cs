using System;
using System.Security.Cryptography;
using System.IO;
using System.Text;
namespace waterModify
{
	/// <summary>
	///数据加密、解密，文件的加密解密
	/// </summary>
	public class DataEncrypt
	{
		public DataEncrypt()
		{
			//
			// TODO: 在此处添加构造函数逻辑
			//
		}

        #region 加密（对称加密）
        public string DesEncrypt(string strText, string strEncrKey)
		{
			byte[] byKey=null;
			byte[] IV= {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
			try
			{
				byKey = System.Text.Encoding.UTF8.GetBytes(strEncrKey.Substring(0,strEncrKey.Length));
				DESCryptoServiceProvider des = new DESCryptoServiceProvider();
				byte[] inputByteArray = Encoding.UTF8.GetBytes(strText);
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

        #region 解密（对称加密）
        public string DesDecrypt(string strText,string sDecrKey)
		{
			byte[] byKey = null;
			byte[] IV= {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
			byte[] inputByteArray = new Byte[strText.Length];
			try
			{
				byKey = System.Text.Encoding.UTF8.GetBytes(sDecrKey.Substring(0,8));
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

        #region 对文件加密（对称加密）
        public void DesEncrypt(string m_InFilePath,string m_OutFilePath,string strEncrKey)
		{
			byte[] byKey=null;
			byte[] IV= {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
			try
			{
				byKey = System.Text.Encoding.UTF8.GetBytes(strEncrKey.Substring(0,8));
				FileStream fin = new FileStream(m_InFilePath, FileMode.Open, FileAccess.Read);
				FileStream fout = new FileStream(m_OutFilePath, FileMode.OpenOrCreate, FileAccess.Write);
				fout.SetLength(0);
				byte[] bin = new byte[100]; 
				long rdlen = 0;
				long totlen = fin.Length;
				int len; 
				DES des = new DESCryptoServiceProvider();
				CryptoStream encStream = new CryptoStream(fout, des.CreateEncryptor(byKey, IV), CryptoStreamMode.Write);
				while(rdlen < totlen)
				{
					len = fin.Read(bin, 0, 100);
					encStream.Write(bin, 0, len);
					rdlen = rdlen + len;
				}

				encStream.Close();
				fout.Close();
				fin.Close();
			}
			catch
			{
				
			}
		}
        #endregion

        #region 对文件解密（对称加密）
        public void DesDecrypt(string m_InFilePath,string m_OutFilePath,string sDecrKey)
		{
			byte[] byKey = null;
			byte[] IV= {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
			try
			{
				byKey = System.Text.Encoding.UTF8.GetBytes(sDecrKey.Substring(0,8));
				FileStream fin = new FileStream(m_InFilePath, FileMode.Open, FileAccess.Read);
				FileStream fout = new FileStream(m_OutFilePath, FileMode.OpenOrCreate, FileAccess.Write);
				fout.SetLength(0);
				
				byte[] bin = new byte[100]; 
				long rdlen = 0; 
				long totlen = fin.Length; 
				int len; 

				DES des = new DESCryptoServiceProvider();
				CryptoStream encStream = new CryptoStream(fout, des.CreateDecryptor(byKey, IV), CryptoStreamMode.Write);

				while(rdlen < totlen)
				{
					len = fin.Read(bin, 0, 100);
					encStream.Write(bin, 0, len);
					rdlen = rdlen + len;
				}

				encStream.Close();
				fout.Close();
				fin.Close();

			}
			catch
			{
				
			}


		}
        #endregion
        #region MD5加密 
		public string MD5Encrypt(string strText)
		{
			MD5 md5 = new MD5CryptoServiceProvider();
			byte[] result = md5.ComputeHash(System.Text.Encoding.Default.GetBytes(strText));
			return System.Text.Encoding.Default.GetString(result);
		}
        #endregion
        #region MD5加密
        public string MD5Decrypt(string strText)
		{
			MD5 md5 = new MD5CryptoServiceProvider();
			byte[] result = md5.TransformFinalBlock(System.Text.Encoding.Default.GetBytes(strText),0,strText.Length);
			return System.Text.Encoding.Default.GetString(result);
		}
        #endregion
	}
}