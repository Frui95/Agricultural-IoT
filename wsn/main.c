/***************************************************************
通过定时器0，由ii设定定时时间，ii=1就是5ms，ii=24000，每隔2分钟进入一次发送程序，
发送地址是0000
send_ask是发送请求；
i是接收计数变量，用来确定接收个数；
总共5个参数，分别是空气温度，空气湿度，土壤湿度，土壤电导率和光照度

***************************************************************/
#include <c8051f340.h>
#include "def.h"
#include "string.h"

int  i,ii;
sbit LED1 = P0^6;						   // D7
sbit LED2 = P0^7;						   // D8
sbit relay = P3^6;						   // 继电器

bit                 send_ask;
bit					receive_bit;			// 接收标志位
u8					receive_data;			// 接收到的数据
tagZigbeePkg		recv_data;				// 已接收的数据包
tagZigbeeSendPkg	send_data;				// 待发送的数据包

void SysclkInit(void);
void PortInit(void);
void Uart0Init(void);
void InitAdc(void);			    
u32  StartAdc(u8 Pxx);
void SendAdc(void);
void SendAdc2(void);
void ZigbeeSend(void);
void TestZigbeeSend(void);
void Timer0Init(void);
void Delay(u16 i);
void Delay_ms(u16 i);
void Delay_s(u16 i);

void main(void)
{
	PCA0MD &= ~0x40;						// 禁止看门狗 
	SysclkInit();							// 初始化是系统时钟到12M
	PortInit();								// 初始挂交叉开关和I/O口
	Uart0Init();							// 初始化UART0
	Timer0Init();							// 初始化定时器0
	InitAdc();								// AD初始化
	i    = 0;
	ii   = 0;
	LED1 = 1;
	LED2 = 0;
	relay = 0;
	Delay_ms(10);
	EA   = 1;
	ES0  = 1;
	ET0  = 1;
	TR0  = 1;
	send_ask = 0;
	relay = 0;
	while(1)
	{
		if(send_ask == 1)
		{
			TR0 = 0;								 //关闭定时器计数，防止程序还没结束进入下一次中断
			send_ask = 0;
			SendAdc();								 //将数据发送给中继点		
			TR0 = 1;
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
* 功能 : 端口初始化				 `
* 输入 : 无
* 输出 : 无
***********************************************************************/

void PortInit(void)
{
	P0MDOUT = 0xd0;							// 设置两盏灯和P0.4（对应TX0）输出为推挽方式
	P1MDOUT = 0x03;							// 设置两盏灯输出为推挽方式
	P3MDOUT = 0x40; 						// 设置P3.6（继电器）输出为推挽方式
	P3MDIN  = 0xCC;							// 设置P3.0,P3.1,P3.4,P3.5为模拟输入
	XBR0 = 0x01;							// UART TX0, RX0 连到端口引脚 P0.4 和 P0.5。
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

/****************************************************************
* 名称 ：InitAdc()
* 功能 ：初始化AD转换
* 输入 ：无
* 输出 ：无
****************************************************************/
void InitAdc(void)
{
	REF0CN = 0x0E;							// 电压基准控制寄存器(PDF.50) /	 选择VDD作为VREF
	AMX0N = 0x1F;							// 负输入通道选择寄存器:单端(PDF.40)    /选择GAN作为负输入
	ADC0CF = 0xF8;							// ADC0配置寄存器:右对齐
	ADC0CN = 0x80;							// ADC0控制寄存器:关闭ADC0的窗口比较中断
}


/****************************************************************
* 名称 ：StartAdc()
* 功能 ：开始AD转换
* 输入 ：Pxx : 待转换的端口
* 输出 ：16位无符号数字量
****************************************************************/
u32 StartAdc(u8 Pxx)
{
	u32 temp_long;
	u32 ain_voltage=0;
    int j;                               	
	AMX0P = Pxx;							// 正输入通道选择寄存器(PDF.39)
    for (j = 0; j <6 ; j++)					// 延时
    Delay(60000);
	AD0INT = 0;								// 清除转换完成标志
	AD0BUSY = 1;							// 启动ADC0开始工作
	while (AD0INT == 0) NOP;				// 等待ADC转换结束
	temp_long = ADC0H;						// 读取转换结果的高8位
	temp_long = temp_long << 8;				// 把读取的8位数据左移8位，移到高8位
	temp_long |= ADC0L;						// 读取转换结果的低8位
	ain_voltage = temp_long;
	return ain_voltage;
}



/******************************************************************** 
* 功能 : 测AD，将数据放入结构体中，再通过串口0发送
* 输入 : 无
* 输出 : 无
***********************************************************************/

void SendAdc()
{
	u16 adc1;
	u8 adc2,adc3,adc4,adc5;
	u32 atemp,ahum,shum,sec,light;						//对应空气温度，空气湿度，土壤湿度，土壤电导率，光照度
	LED2 = 1;
	relay = 1;
	Delay_s(5);
	atemp=StartAdc(0x08);								//测空气温度对应输入引脚P3.4，其AMX0P对应0x08
	ahum=StartAdc(0x09);								//测空气湿度对应输入引脚P3.5，其AMX0P对应0x09
	shum=StartAdc(0x07);								//测土壤湿度对应输入引脚P3.1，其AMX0P对应0x07
	sec =StartAdc(0x06);								//测土壤电导率对应输入引脚P3.0，其AMX0P对应0x06
	light=StartAdc(0x05);								//测光照度对应输入引脚P2.6，其AMX0P对应0x05
	atemp = ((atemp*3270/1024)-600)/3; 
	ahum = ahum*3270/1024/30;
	shum = shum*3270/1024*50/1000;						//计算湿度方法对应0-100%
	sec = sec*3270/1024*50/1000;						//计算电导率方法对应0-100 us/ms
	light = light*2*327/5/1024;
	adc1 = atemp;
	adc2 = ahum;
	adc3 = shum;
	adc4 = sec;
	adc5 = light;
	relay = 0;										   //关继电器
//	adc1 = 0x0118;
	send_data.ZigbeePkg.header		= 0xFD;			// 点对点标志位
	send_data.ZigbeePkg.len			= 0x09;			// 数据区长度 9
	send_data.ZigbeePkg.addr[0]		= 0x00;			// 目标地址 : 0001
	send_data.ZigbeePkg.addr[1]		= 0x2E;
	send_data.ZigbeePkg.start		= 0xAA;
	memcpy(send_data.ZigbeePkg.dat     , &adc1, 2);	// 待传数据
	memcpy(send_data.ZigbeePkg.dat +  2, &adc2, 1);
	memcpy(send_data.ZigbeePkg.dat +  3, &adc3, 1);
	memcpy(send_data.ZigbeePkg.dat +  4, &adc4, 1);
	memcpy(send_data.ZigbeePkg.dat +  5, &adc5, 1);
	send_data.ZigbeePkg.end1		=0xBB;
	send_data.ZigbeePkg.end2		=0XCC;
	ZigbeeSend();
	Delay_s(1);
	relay = 0;
	LED2 = 0;
}



/******************************************************************** 
* 功能 : 测AD，将数据放入结构体中，再通过串口0发送
* 输入 : 无
* 输出 : 无
***********************************************************************/

void SendAdc2()
{
	u16 adc1,adc2;
	u32 temp,hum;
	LED2 = 1;
	temp=StartAdc(0x09);							//测空气温度对应输入引脚P3.5，其AMX0P对应0x09
	hum=StartAdc(0x08);								//测空气温度对应输入引脚P3.4，其AMX0P对应0x08
	adc1 = ((temp*3270/1024)-600)/3; 
	adc2 = hum*3270/1024/30; 	
//	adc1 = 0x0118;
	send_data.ZigbeePkg.header		= 0xFD;			// 点对点标志位
	send_data.ZigbeePkg.len			= 0x04;			// 数据区长度 4
	send_data.ZigbeePkg.addr[0]		= 0X28;			// 目标地址 : coordinator
	send_data.ZigbeePkg.addr[1]		= 0X7B;
	memcpy(send_data.ZigbeePkg.dat     , &adc1, 2);	// 待传数据
	memcpy(send_data.ZigbeePkg.dat +  2, &adc2, 2);
	ZigbeeSend();
	LED2 = 0;
}

/******************************************************************** 
* 功能 : 串口0发送ZIGBEE数据程序，发送前灯3亮，发送完后灯3灭
* 输入 : 无
* 输出 : 无
***********************************************************************/

void ZigbeeSend(void)
{
	int j;									// 循环发送变量
	Delay_ms(10);
	ES0 = 0;
	for (j = 0; j < ZIGBEE_SEND_LEN; j++)
	{
		SBUF0 = send_data.u8_array[j];		// 将接收到数据送出
		while (TI0 == 0) NOP;				// 发送标志位是否产生
		TI0 = 0;							// 清发送标志位
		Delay(100);							// 延时									
	}
	ES0 = 1;
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
	ii++;
	if(ii==2000)						//ii最大是65535
	{
		ii=0;
		send_ask = 1;	
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