#ifndef  __DEF_H__
#define  __DEF_H__
#include <intrins.h>


typedef unsigned char  u8;					// 数据类型 u8  定义
typedef signed   char  s8;					// 数据类型 s8  定义
typedef unsigned int   u16;					// 数据类型 u16 定义
typedef signed   int   s16;					// 数据类型 s16 定义
typedef unsigned long  u32;					// 数据类型 u32 定义
typedef signed   long  s32;					// 数据类型 s32 定义

#define NOP        _nop_()
#define SYSCLK     12000000					// 系统时钟 12M
#define BAUDRATE   9600						// UART 的波特率
#define MAXBUF     64

#define DATA_LEN			6				// the length of data
#define ZIGBEE_SEND_LEN		10				// the length of data to be transmitted by zigbee
#define ZIGBEE_LEN			15				// the length of zigbee data	
#define PAI_SEND_LEN		9
typedef union {								// Zigbee 完整数据包
	u8 u8_array[ZIGBEE_LEN];
	struct {
		u8 header;							// 数据传输指令 : 0xFD
		u8 len;								// 数据区长度 : 0x06
		u8 addr[2];							// 目标地址
		u8 start;
		u8 dat[DATA_LEN];					// 待传数据
		u8 end1;
		u8 end2;
		u8 mac[2];							// 来源短地址
	} ZigbeePkg;
} tagZigbeePkg;

typedef union {								// Zigbee 待传数据包
	u8 u8_array[ZIGBEE_SEND_LEN];
	struct {
		u8 header;							// 数据传输指令 : 0xFD
		u8 len;								// 数据区长度 : 0x0E
		u8 addr[2];							// 目标地址
//		u8 cmd;								// 操作
//		u8 reserved;						// 保留字
//		u8 type;							// 待传数据种类
		u8 dat[DATA_LEN];					// 待传数据			  
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


#define AD_type				0x01			// 待传数据种类是AD


#define CMD_PUT				0x01			// zigbee send data
#define CMD_GET				0x02			// zigbee request data

#endif