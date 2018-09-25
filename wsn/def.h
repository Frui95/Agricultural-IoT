#ifndef  __DEF_H__
#define  __DEF_H__
#include <intrins.h>


typedef unsigned char  u8;					// �������� u8  ����
typedef signed   char  s8;					// �������� s8  ����
typedef unsigned int   u16;					// �������� u16 ����
typedef signed   int   s16;					// �������� s16 ����
typedef unsigned long  u32;					// �������� u32 ����
typedef signed   long  s32;					// �������� s32 ����

#define NOP        _nop_()
#define SYSCLK     12000000					// ϵͳʱ�� 12M
#define BAUDRATE   9600				    	// UART �Ĳ�����

#define DATA_LEN			6				// the length of data
#define ZIGBEE_SEND_LEN		13				// the length of data to be transmitted by zigbee
#define ZIGBEE_LEN			12				// the length of zigbee data	

typedef union {								// Zigbee �������ݰ�
	u8 u8_array[ZIGBEE_LEN];
	struct {
		u8 header;							// ���ݴ���ָ�� : 0xFD
		u8 len;								// ���������� : 0x02
		u8 addr[2];							// Ŀ���ַ
//		u8 cmd;		 						// ����
//		u8 reserved;						// ������
//		u8 type;							// ������������
		u8 dat[DATA_LEN];					// ��������
		u8 mac[2];							// ��Դ�̵�ַ
	} ZigbeePkg;
} tagZigbeePkg;

typedef union {								// Zigbee �������ݰ�
	u8 u8_array[ZIGBEE_SEND_LEN];
	struct {
		u8 header;							// ���ݴ���ָ�� : 0xFD
		u8 len;								// ���������� : 0x02							//
		u8 addr[2];							// Ŀ���ַ
		u8 start;							// ������ʼ
		u8 dat[DATA_LEN];					// ��������
		u8 end1;							// ����
		u8 end2;							// ������			  
	} ZigbeePkg;
} tagZigbeeSendPkg;


#define AD_type				0x01			// ��������������AD


#define CMD_PUT				0x01			// zigbee send data
#define CMD_GET				0x02			// zigbee request data

#endif