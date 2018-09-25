/***********************************
���������ݣ����յ��������2��
���������ݸ�ʽ�Ƿ���ȷ������ͷ��AA��β��BB CC
���������Դ��ַ�������·���̵�ַ
������������ͨ������1���ͳ�ȥ�����ݸ�ʽΪ������ʪ�ȣ������¶ȣ�����ʪ�ȣ������絼�ʣ����նȣ��̵�ַ���س� ����
��ʱ��0���������������ݳ���ʱ������BUG��ͨ���Խ��ռ���������ʵ�֣���a���㣩����ʱʱ����time0������4000�൱��20s
***********************************/
#include <c8051f340.h>
#include "def.h"
#include "string.h"

int  i,time0,k,kk;
sbit LED1 = P0^6;						   // D7
sbit LED2 = P0^7;						   // D8
int  a = 0;

bit                 clear_ask;				// �����־λ
bit					receive_bit;			// ���ձ�־λ
u8					receive_data[MAXBUF];	// ���յ�������
u8 					Send_recv[10];     	    // ��Ҫ���͵����Ե�����
tagZigbeePkg		recv_data;				// �ѽ��յ����ݰ�
tagZigbeeSendPkg	send_data;				// �����͵����ݰ�
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
	PCA0MD &= ~0x40;						// ��ֹ���Ź� 
	SysclkInit();							// ��ʼ����ϵͳʱ�ӵ�12M
	Timer0Init();							// ��ʱ��0��ʼ�������������λ
	PortInit();								// ��ʼ�ҽ��濪�غ�I/O��
	Uart0Init();							// ��ʼ��UART0
	Uart1Init();						 	// ��ʼ��UART1
	i    = 0;								// ���ռ���
	clear_ask = 0;							// ���λ
	time0 = 0;								// ��ʱ��0����
	LED1 = 1;
	LED2 = 0;
	Delay_ms(10);
	EA   = 1;								// �����ж�
	ET0  = 1;								// ��ʱ��0�ж�����
	ES0  = 1;								// ������0�ж�
	EIE2 = 0x02;							// ������1�ж�
	TR0  = 1;								// ��ʱ��0��ʼ
	while(1)
	{
		if(receive_bit == 1)
		{
			ES0 = 0;						 //����0ֹͣ
			TR0 = 0;						 // ��ʱ��0ֹͣ
			receive_bit = 0;
			LED2 = 1;
			if(recv_data.u8_array[12] == 0xCC)						  //�ж����ݸ�ʽ�Ƿ���ȷ
			{
				 if(recv_data.u8_array[11] == 0xBB)
				 {
				 	if(recv_data.u8_array[4] == 0xAA)
					{
						for(k=0; k<6;k++)								//�����ݸ��Ƶ�����������
						{
							PaiSend.u8_array[k]=recv_data.u8_array[5+k];
						}
						if(recv_data.ZigbeePkg.mac[0]==0x00&&recv_data.ZigbeePkg.mac[1]==0x01)			 //�ж���Դ��ַ
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
							PaiSend.u8_array[6] = 0;												  //����Դ��ַ����ȷ���ַΪ0
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
							i = 0;									 //������ָ��ָ���0λ
							for(k=0; k<ZIGBEE_LEN;k++)				 //�������ֶ�����
							{
								recv_data.u8_array[k] = 0;
							}
							for(k=0; k<9;k++)						 //�������ֶ�����
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
			i = 0;									 //������ָ��ָ���0λ
			for(k=0; k<ZIGBEE_LEN;k++)				 //�������ֶ�����
			{
				recv_data.u8_array[k] = 0;
			}
			for(k=0; k<9;k++)						 //�������ֶ�����
			{
				PaiSend.u8_array[k]=0;
			}
			TR1 = 1;	
		}
	}
	
}





/********************************************************************
* ���� : ϵͳʱ�ӳ�ʼ��
* ���� : ��
* ��� : ��
***********************************************************************/

void SysclkInit(void)
{
	REG0CN = 0x00;							// ��ѹ��ʹ�� 
	OSCICN |= 0x83;							// ����Ƶ,ʹ���ڲ�12M����,ϵͳʱ��Ƶ��Ϊ12MHz
	OSCICL = 0x00;							// �ڲ������������Ƶ��
	OSCLCN = 0x00;							// ��ֹ�ڲ�L-F����
	OSCXCN = 0x00;							// �ر��ⲿ����
	TMOD = 0;								// ��ʱ����ʽ�Ĵ�����ʼ��
	CKCON = 0;								// ʱ�ӿ��ƼĴ�����ʼ��
}

/********************************************************************
* ���� : �˿ڳ�ʼ��
* ���� : ��
* ��� : ��
***********************************************************************/

void PortInit(void)
{
	P0MDOUT = 0xd0;							// ������յ�ƺ�P0.4����ӦTX0�����Ϊ���췽ʽ
//	P1MDOUT = 0x03;							// ������յ�����Ϊ���췽ʽ
	P2MDOUT = 0x01;							// ����P2.0����ӦTX1�����Ϊ���췽ʽ
//	P3MDOUT = 0x40; 						// ����P3.6���̵��������Ϊ���췽ʽ
//	P3MDIN  = 0xCE;							// ����P3.1,P3.4,P3.5Ϊģ������
	P0SKIP  = 0xcf;							// ���濪������P0��P1����������P0.4��P0.5����ʹP2.0��P2.1��ΪTX1��RX1
	P1SKIP  = 0xff;
	XBR0 = 0x01;							// UART TX0, RX0 �����˿����� P0.4 �� P0.5��
	XBR2 = 0x01;							// UART1 TX1, RX1 �����˿����� P0.0 �� P2.1��
	XBR1 = 0x40;							// ���濪��ʹ�ܲ�������
}

/******************************************************************** 
* ���� : ����0��ʼ��
* ���� : ��
* ��� : ��
***********************************************************************/

void Uart0Init(void)
{
	SCON0 = 0x50;							// SCON0:ģʽ1,8λUART,ʹ��RX
	TMOD |= 0x20;							// TMOD: ��ʱ��������ģʽ2, 8λ����
	TH1 = 256 - (SYSCLK / BAUDRATE / 8);	// ���ö�ʱ1���������ʵ�����ֵ
	TR1 = 1;								// ����ʱ��1
	CKCON |= 0x01;							// ��ʱ��1��(ϵͳʱ��/4)��Ϊ����ʱ��
	TI0 = 0;								// �巢�ͱ�־λ
}

/******************************************************************** 
* ���� : ����1��ʼ��
* ���� : ��
* ��� : ��
***********************************************************************/
void Uart1Init(void)
{
   u16     sbrl;
   sbrl = 65536 - (SYSCLK/BAUDRATE/2); // ����UART1ר�ü��������������ʵ�����ֵ��Ԥ��Ƶ = 1
   SBRLL1 = sbrl & 0x00ff;			   // ����UART1 �����ʷ���������ֵ���ֽ�
   SBRLH1 = sbrl / 256;				   // ����UART1 �����ʷ���������ֵ���ֽ�
   SBCON1 |= 0x43;					   // SBCON1:�����ʷ�����ʹ��,Ԥ��Ƶ = 1
   SCON1 = 0x30;					   // SCON1:ʹ��RX
   SMOD1 = 0x0c;                       // SMOD1:�ദ����ͨ�Ž�ֹ��Ӳ����żλ��ֹ,8λ����,����λ��ֹ,ֹͣλ����1
}



/******************************************************************** 
* ���� : ����1�������ݳ���
* ���� : ��
* ��� : ��
***********************************************************************/
void Ck1Send(u8 s[])
{	
	int j;
	Delay_ms(10); 								 
	EIE2 = 0;							// �ش���1�ж�
	for (j = 0; j < PAI_SEND_LEN; j++)
	{
		SBUF1 = s[j];	       			// �����յ������ͳ�
		while(!(SCON1 & 0x02)) NOP;		// ���ͱ�־λ�Ƿ����
		SCON1 &= (~0x02);				// �巢�ͱ�־λ
		Delay(100);						// ��ʱ									
	}
	EIE2 = 0x02;						// ������1�ж�

}

/********************************************************************
* ���� : ����0�жϣ����������ݺ���λ
* ���� : ��
* ��� : ��
***********************************************************************/
void Uart0Isr(void) interrupt 4
{
	if (!TI0)								// �Ƿ����жϻ��ǽ����ж�
	{
		RI0 = 0;							// ����ձ�־λ
		recv_data.u8_array[i++] = SBUF0;	// ������յ�������
		if (i == ZIGBEE_LEN)
		{
			receive_bit = 1;				// �ý��ձ�־
			i = 0;
		}
	}
	TI0 = 0;								// �巢�ͱ�־λ
}

/********************************************************************
* ���� : Timer0Init() 
* ���� : C8051F340��TIMER0�ĳ�ʼ����OX150A��Ӧ��ʱ5MS
* ���� : ��
* ��� : ��
***********************************************************************/
void Timer0Init(void)
{
	CKCON |= 0x04;							// ��ʱ��0ʹ��ϵͳʱ��12M
	TMOD |= 0x01;							// ��ʱ��0ʹ��16λ��ʱ����ʽ
	TH0 = 0x15;								// �˶�ʱ����ʼֵ��Ӧ��ʱ5MS
	TL0 = 0xa0;
}



/********************************************************************
* ���� : Timer0Isr() 
* ���� : ��ʱ���ж�0�����ӳ���
* ���� : ��
* ��� : ��
***********************************************************************/

void Timer0Isr(void) interrupt 1
{
	ET0 = 0;							// �ض�ʱ��0�ж�
	TF0 = 0;							// ���жϱ�־λ
	time0++;
	if(time0==4000)
	{
		time0=0;
		clear_ask = 1;	
	}
	TR0 = 1;							// ����ʱ��0
	ET0 = 1;							// ����ʱ��0�ж�
	
}


/******************************************************************** 
* ���� : ��ʱ�ӳ���
* ���� : ��
* ��� : ��
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
* ���� : ����ʱ�ӳ���
* ���� : ��
* ��� : ��
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