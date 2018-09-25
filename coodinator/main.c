/***********************************
检测接收数据，接收到数据则灯2亮
检测接收数据格式是否正确，数据头是AA，尾是BB CC
检测数据来源地址，并重新分配短地址
将整理后的数据通过串口1发送出去，数据格式为：空气湿度，空气温度，土壤湿度，土壤电导率，光照度，短地址，回车 空行
定时器0用来消除接收数据出错时产生的BUG，通过对接收计数清零来实现（将a清零），定时时间由time0决定，4000相当于20s
***********************************/
#include <c8051f340.h>
#include "def.h"
#include "string.h"

int  i,time0,k,kk;
sbit LED1 = P0^6;						   // D7
sbit LED2 = P0^7;						   // D8
int  a = 0;

bit                 clear_ask;				// 清除标志位
bit					receive_bit;			// 接收标志位
u8					receive_data[MAXBUF];	// 接收到的数据
u8 					Send_recv[10];     	    // 需要发送到电脑的数据
tagZigbeePkg		recv_data;				// 已接收的数据包
tagZigbeeSendPkg	send_data;				// 待发送的数据包
tagParaPkg          PaiSend;
u8					shuju[7];
u8					WeiBa[2];

void SysclkInit(void);
void PortInit(void);
void Uart0Init(void);
void Uart1Init(void);
void InitAdc(void);
u32  StartAdc(u8 Pxx);
void SendAdc(void);
void ZigbeeSend(void);
void Ck1Send(u8 s[]);
void TestZigbeeSend(void);
void Timer0Init(void);
void Delay(u16 i);
void Delay_ms(u16 i);
void Delay_s(u16 i);

void main(void)
{
	PCA0MD &= ~0x40;						// 禁止看门狗 
	SysclkInit();							// 初始化是系统时钟到12M
	Timer0Init();							// 定时器0初始化用于清楚接收位
	PortInit();								// 初始挂交叉开关和I/O口
	Uart0Init();							// 初始化UART0
	Uart1Init();						 	// 初始化UART1
	i    = 0;								// 接收计数
	clear_ask = 0;							// 清除位
	time0 = 0;								// 定时器0计数
	LED1 = 1;
	LED2 = 0;
	Delay_ms(10);
	EA   = 1;								// 开总中断
	ET0  = 1;								// 定时器0中断允许
	ES0  = 1;								// 开串口0中断
	EIE2 = 0x02;							// 开串口1中断
	TR0  = 1;								// 定时器0开始
	while(1)
	{
		if(receive_bit == 1)
		{
			ES0 = 0;						 //串口0停止
			TR0 = 0;						 // 定时器0停止
			receive_bit = 0;
			LED2 = 1;
			if(recv_data.u8_array[12] == 0xCC)						  //判断数据格式是否正确
			{
				 if(recv_data.u8_array[11] == 0xBB)
				 {
				 	if(recv_data.u8_array[4] == 0xAA)
					{
						for(k=0; k<6;k++)								//将数据复制到发送数组中
						{
							PaiSend.u8_array[k]=recv_data.u8_array[5+k];
						}
						if(recv_data.ZigbeePkg.mac[0]==0x00&&recv_data.ZigbeePkg.mac[1]==0x01)			 //判断来源地址
						{
							PaiSend.u8_array[6] = 0x01;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x00&&recv_data.ZigbeePkg.mac[1]==0x02)
						{
							PaiSend.u8_array[6] = 0x02;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x00&&recv_data.ZigbeePkg.mac[1]==0x03)
						{
							PaiSend.u8_array[6] = 0x03;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x00&&recv_data.ZigbeePkg.mac[1]==0x04)
						{
							PaiSend.u8_array[6] = 0x04;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x00&&recv_data.ZigbeePkg.mac[1]==0x05)
						{
							PaiSend.u8_array[6] = 0x05;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x00&&recv_data.ZigbeePkg.mac[1]==0x90)
						{
							PaiSend.u8_array[6] = 0x06;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x50&&recv_data.ZigbeePkg.mac[1]==0xF5)
						{
							PaiSend.u8_array[6] = 0x07;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x06&&recv_data.ZigbeePkg.mac[1]==0xBC)
						{
							PaiSend.u8_array[6] = 0x08;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x0A&&recv_data.ZigbeePkg.mac[1]==0x19)
						{
							PaiSend.u8_array[6] = 0x09;
						}
						else if(recv_data.ZigbeePkg.mac[0]==0x0D&&recv_data.ZigbeePkg.mac[1]==0x76)
						{
							PaiSend.u8_array[6] = 0x0A;
						}
						else 
						{
							PaiSend.u8_array[6] = 0;												  //若来源地址不正确则地址为0
						}
						PaiSend.u8_array[7] = 0x0d;
						PaiSend.u8_array[8] = 0x0a;
						if(PaiSend.u8_array[6] == 0)
						{	
							for(k=0; k<9;k++)
							{
								PaiSend.u8_array[k]=0;
							}					
						}
						else
						{
							Ck1Send(PaiSend.u8_array);
							i = 0;									 //将接收指针指向第0位
							for(k=0; k<ZIGBEE_LEN;k++)				 //将接收字段清零
							{
								recv_data.u8_array[k] = 0;
							}
							for(k=0; k<9;k++)						 //将发送字段清零
							{
								PaiSend.u8_array[k]=0;
							}
						}						
					}
				 }
			}	
			LED2 = 0;
			ES0 = 1;
			TR0 = 1;
		}
		if(clear_ask == 1)
		{
			TR1 = 0;
			clear_ask = 0;
			i = 0;									 //将接收指针指向第0位
			for(k=0; k<ZIGBEE_LEN;k++)				 //将接收字段清零
			{
				recv_data.u8_array[k] = 0;
			}
			for(k=0; k<9;k++)						 //将发送字段清零
			{
				PaiSend.u8_array[k]=0;
			}
			TR1 = 1;	
		}
	}
	
}





/********************************************************************
* 功能 : 系统时钟初始化
* 输入 : 无
* 输出 : 无
***********************************************************************/

void SysclkInit(void)
{
	REG0CN = 0x00;							// 稳压器使能 
	OSCICN |= 0x83;							// 不分频,使用内部12M晶振,系统时钟频率为12MHz
	OSCICL = 0x00;							// 内部晶振工作在最高频率
	OSCLCN = 0x00;							// 禁止内部L-F振荡器
	OSCXCN = 0x00;							// 关闭外部振荡器
	TMOD = 0;								// 定时器方式寄存器初始化
	CKCON = 0;								// 时钟控制寄存器初始化
}

/********************************************************************
* 功能 : 端口初始化
* 输入 : 无
* 输出 : 无
***********************************************************************/

void PortInit(void)
{
	P0MDOUT = 0xd0;							// 设置两盏灯和P0.4（对应TX0）输出为推挽方式
//	P1MDOUT = 0x03;							// 设置两盏灯输出为推挽方式
	P2MDOUT = 0x01;							// 设置P2.0（对应TX1）输出为推挽方式
//	P3MDOUT = 0x40; 						// 设置P3.6（继电器）输出为推挽方式
//	P3MDIN  = 0xCE;							// 设置P3.1,P3.4,P3.5为模拟输入
	P0SKIP  = 0xcf;							// 交叉开关跳过P0和P1（不能跳过P0.4和P0.5），使P2.0和P2.1成为TX1和RX1
	P1SKIP  = 0xff;
	XBR0 = 0x01;							// UART TX0, RX0 连到端口引脚 P0.4 和 P0.5。
	XBR2 = 0x01;							// UART1 TX1, RX1 连到端口引脚 P0.0 和 P2.1。
	XBR1 = 0x40;							// 交叉开关使能并弱上拉
}

/******************************************************************** 
* 功能 : 串口0初始化
* 输入 : 无
* 输出 : 无
***********************************************************************/

void Uart0Init(void)
{
	SCON0 = 0x50;							// SCON0:模式1,8位UART,使能RX
	TMOD |= 0x20;							// TMOD: 定时器工作在模式2, 8位重载
	TH1 = 256 - (SYSCLK / BAUDRATE / 8);	// 设置定时1用作波特率的重载值
	TR1 = 1;								// 开定时器1
	CKCON |= 0x01;							// 定时器1用(系统时钟/4)作为它的时基
	TI0 = 0;								// 清发送标志位
}

/******************************************************************** 
* 功能 : 串口1初始化
* 输入 : 无
* 输出 : 无
***********************************************************************/
void Uart1Init(void)
{
   u16     sbrl;
   sbrl = 65536 - (SYSCLK/BAUDRATE/2); // 计算UART1专用计数器用作波特率的重载值，预分频 = 1
   SBRLL1 = sbrl & 0x00ff;			   // 设置UART1 波特率发生器重载值低字节
   SBRLH1 = sbrl / 256;				   // 设置UART1 波特率发生器重载值高字节
   SBCON1 |= 0x43;					   // SBCON1:波特率发生器使能,预分频 = 1
   SCON1 = 0x30;					   // SCON1:使能RX
   SMOD1 = 0x0c;                       // SMOD1:多处理器通信禁止，硬件奇偶位禁止,8位数据,额外位禁止,停止位长度1
}



/******************************************************************** 
* 功能 : 串口1发送数据程序
* 输入 : 无
* 输出 : 无
***********************************************************************/
void Ck1Send(u8 s[])
{	
	int j;
	Delay_ms(10); 								 
	EIE2 = 0;							// 关串口1中断
	for (j = 0; j < PAI_SEND_LEN; j++)
	{
		SBUF1 = s[j];	       			// 将接收到数据送出
		while(!(SCON1 & 0x02)) NOP;		// 发送标志位是否产生
		SCON1 &= (~0x02);				// 清发送标志位
		Delay(100);						// 延时									
	}
	EIE2 = 0x02;						// 开串口1中断

}

/********************************************************************
* 功能 : 串口0中断，接收完数据后置位
* 输入 : 无
* 输出 : 无
***********************************************************************/
void Uart0Isr(void) interrupt 4
{
	if (!TI0)								// 是发送中断还是接收中断
	{
		RI0 = 0;							// 清接收标志位
		recv_data.u8_array[i++] = SBUF0;	// 保存接收到的数据
		if (i == ZIGBEE_LEN)
		{
			receive_bit = 1;				// 置接收标志
			i = 0;
		}
	}
	TI0 = 0;								// 清发送标志位
}

/********************************************************************
* 名称 : Timer0Init() 
* 功能 : C8051F340的TIMER0的初始化，OX150A对应延时5MS
* 输入 : 无
* 输出 : 无
***********************************************************************/
void Timer0Init(void)
{
	CKCON |= 0x04;							// 定时器0使用系统时钟12M
	TMOD |= 0x01;							// 定时器0使用16位定时器方式
	TH0 = 0x15;								// 此定时器初始值对应定时5MS
	TL0 = 0xa0;
}



/********************************************************************
* 名称 : Timer0Isr() 
* 功能 : 定时器中断0服务子程序
* 输入 : 无
* 输出 : 无
***********************************************************************/

void Timer0Isr(void) interrupt 1
{
	ET0 = 0;							// 关定时器0中断
	TF0 = 0;							// 清中断标志位
	time0++;
	if(time0==4000)
	{
		time0=0;
		clear_ask = 1;	
	}
	TR0 = 1;							// 开定时器0
	ET0 = 1;							// 开定时器0中断
	
}


/******************************************************************** 
* 功能 : 延时子程序
* 输入 : 无
* 输出 : 无
***********************************************************************/

void Delay(u16 i)
{
	while (i--)
	{
		NOP;
		NOP;
		NOP;
	}
}

/********************************************************************
* 功能 : 长延时子程序
* 输入 : 无
* 输出 : 无
***********************************************************************/

void Delay_ms(u16 i)
{
	while(i--)
	{
		Delay(0xffff);
	}
}

void Delay_s(u16 i)
{
	while(i--)
	{
		Delay_ms(10);
	}	
}