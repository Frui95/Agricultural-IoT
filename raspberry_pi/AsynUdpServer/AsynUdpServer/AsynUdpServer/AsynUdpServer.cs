using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.Net.Sockets;

namespace AsynUdpServer
{
   class AsynUdpServer{ 
    public class StateObject
   {
      public Socket udpServer = null;// 服务器端
      public byte[] buffer = new byte[1024]; //接受数据缓冲区
      public EndPoint remoteEP; //远程终端
    }
    StateObject state;
    public void ServerBind()//服务器绑定终端节点
    {
      IPEndPoint serverIp = new IPEndPoint(IPAddress.Parse("127.0.0.1"), 8686);
      Socket udpServer = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
      udpServer.Bind(serverIp);
      Console.WriteLine("server ready...");
      IPEndPoint clientIp = new IPEndPoint(IPAddress.Any, 0);
      state = new StateObject();
      state.udpServer = udpServer;
      state.remoteEP = (EndPoint)clientIp;
      AsynRecive();
    }
    public void AsynRecive()//异步接受消息
    {
     state.udpServer.BeginReceiveFrom(state.buffer, 0, state.buffer.Length, SocketFlags.None, ref state.remoteEP, new AsyncCallback(ReciveCallback), null);
    }
    public void ReciveCallback(IAsyncResult asyncResult)// 异步接受消息回调函数
    {
      if (asyncResult.IsCompleted)
      {
        IPEndPoint ipep = new IPEndPoint(IPAddress.Any, 0);
        EndPoint remoteEP = (EndPoint)ipep;

        state.udpServer.EndReceiveFrom(asyncResult, ref remoteEP);
        Console.WriteLine("此喷灌服务器<--<--Web应用:{0}", Encoding.UTF8.GetString(state.buffer));
        state.remoteEP = remoteEP;
        AsynSend("收到消息");
        AsynRecive();
        }
   }
   public void AsynSend(string message)// 异步发送消息
   {
       Console.WriteLine("server-->-->client:{0}", message);
       byte[] buffer = Encoding.UTF8.GetBytes(message);
       state.udpServer.BeginSendTo(buffer, 0, buffer.Length, SocketFlags.None, state.remoteEP,new AsyncCallback(SendCallback), null);
   }
   public void SendCallback(IAsyncResult asyncResult)// 异步发送消息回调函数
   {
      if (asyncResult.IsCompleted)
      {
          state.udpServer.EndSendTo(asyncResult);
       }
   }    







    
   }
}
