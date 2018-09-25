<%@ WebHandler Language="C#" Class="UDPSenderHandler" %>

using System;
using System.Web;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Net.WebSockets;

public class UDPSenderHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        try
        {
            string opt = HttpContext.Current.Request["opt"].ToString();
            string cons = HttpContext.Current.Request["cons"].ToString();
            string jiaoshui = opt + cons;
            AsynUdpClient tc = new AsynUdpClient();
            tc.InitClient();
            tc.AsynSend(jiaoshui);
        }
        catch (Exception ex)
        {
            
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write("ok");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    class AsynUdpClient
    {
        public class StateObject
        {
            public Socket udpClient = null;// //客户端套接字
            public byte[] buffer = new byte[1024]; ///接收信息缓冲区
            public IPEndPoint serverIp; ////服务器端终节点
            public EndPoint remoteEP; // //远程终端节点
        }
        public StateObject state;
        public void InitClient()
        {
            state = new StateObject();
            state.udpClient = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
            state.serverIp = new IPEndPoint(IPAddress.Parse("127.0.0.1"), 8686);
            state.remoteEP = (EndPoint)(new IPEndPoint(IPAddress.Any, 0));
            //AsynSend("第1次发送消息");
            //AsynSend("第2次发送消息");
            // AsynRecive();
        }
        public void AsynRecive()
        {
            state.udpClient.BeginReceiveFrom(state.buffer, 0, state.buffer.Length, SocketFlags.None, ref state.remoteEP, new AsyncCallback(ReciveCallback), null);
        }
        public void ReciveCallback(IAsyncResult asyncResult)
        {
            if (asyncResult.IsCompleted)
            {
                state.udpClient.EndReceiveFrom(asyncResult, ref state.remoteEP);
                Console.WriteLine("client<--<--{0}:{1}", state.remoteEP.ToString(), Encoding.UTF8.GetString(state.buffer));
                AsynRecive();
            }
        }
        public void AsynSend(string message)
        {
            Console.WriteLine("client-->-->{0}:{1}", state.serverIp.ToString(), message);
            byte[] buffer = Encoding.UTF8.GetBytes(message);
            state.udpClient.BeginSendTo(buffer, 0, buffer.Length, SocketFlags.None, state.serverIp, new AsyncCallback(SendCallback), null);
        }
        public void SendCallback(IAsyncResult asyncResult)
        {
            if (asyncResult.IsCompleted)
            {
                state.udpClient.EndSendTo(asyncResult);
            }
        }




    }

}