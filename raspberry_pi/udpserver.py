# -*- coding: utf-8 -*-
"""
Created on Fri Mar 31 19:39:00 2017

@author: LvYangFangRui
"""
import socket
import datetime
import time
#import serial
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.bind(('127.0.0.1',9000))
print ('Bind TCP on 9900...')

while True:
    #data receive
    data,addr=s.accept()
    print  (data)
    print  (addr)
    print ('start watering')
    # 打开串口    
    #ser = serial.Serial("/dev/ttyUSB0", 9600)
    #ser.write(01,con)
    time.sleep(1)
    
    
    
