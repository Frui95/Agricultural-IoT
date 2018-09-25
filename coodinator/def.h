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
#define BAUDRATE   9600						// UART �Ĳ�����
#define MAXBUF     64

#define DATA_LEN			6				// the length of data
#define ZIGBEE_SEND_LEN		10				// the length of data to be transmitted by zigbee
#define ZIGBEE_LEN			15				// the length of zigbee data	
#define PAI_SEND_LEN		9
typedef union {								// Zigbee �������ݰ�
	u8 u8_array[ZIGBEE_LEN];
	struct {
		u8 header;							// ���ݴ���ָ�� : 0xFD
		u8 len;								// ���������� : 0x06
		u8 addr[2];							// Ŀ���ַ
		u8 start;
		u8 dat[DATA_LEN];					// ��������
		u8 end1;
		u8 end2;
		u8 mac[2];							// ��Դ�̵�ַ
	} ZigbeePkg;
} tagZigbeePkg;

typedef union {								// Zigbee �������ݰ�
	u8 u8_array[ZIGBEE_SEND_LEN];
	struct {
		u8 header;							// ���ݴ���ָ�� : 0xFD
		u8 len;								// ���������� : 0x0E
		u8 addr[2];							// Ŀ���ַ
//		u8 cmd;								// ����
//		u8 reserved;						// ������
//		u8 type;							// ������������
		u8 dat[DATA_LEN];					// ��������			  
	} ZigbeePkg;
} tagZigbeeSendPkg;

typedef union {								
	u8 u8_array[PAI_SEND_LEN];
	struct {
		u8 atemp[2];							
		u8 ahum;							
		u8 shum;
		u8 sele;							
		u8 light;
		u8 addr;
		u8 huiche;
		u8 huanhang;			  
	} ParaPkg;
} tagParaPkg;


#define AD_type				0x01			// ��������������AD


#define CMD_PUT				0x01			// zigbee send data
#define CMD_GET				0x02			// zigbee request data

#endif