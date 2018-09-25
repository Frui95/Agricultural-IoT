using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.Net.Sockets;

namespace AsynUdpServer
{
    class Program
    {
        static void Main(string[] args)
        {
            AsynUdpServer ts = new AsynUdpServer();
            ts.ServerBind();
            Console.Read();
        }
    }
    

}
