# -*- coding: utf-8 -*-
"""
Created on Fri Mar 31 19:39:00 2017

@author: LvYangFangRui
"""
import socket
import datetime
import time
#import serial
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.bind(('127.0.0.1',9906))
print 'Bind UDP on 9900...'

while True:
    #data receive
    data,addr=s.recvfrom(1024)
    arr = data.split(':')
    now = datetime.datetime.now()
    cony=int(now.year)
    conmh=int(now.month)
    cond=int(now.day)
    conh=int(arr[0])
    conm=int(arr[1])
    cons=int(arr[2])
    con=int(arr[3])
    startTime=datetime.datetime(cony,conmh,cond,conh,conm,cons)
    nowTime=datetime.datetime.now()
    print  data
    print addr
    while datetime.datetime.now()<startTime:
       time.sleep(1)
    print ('start watering')
    # 打开串口    
    #ser = serial.Serial("/dev/ttyUSB0", 9600)
    #ser.write(01,con)
    time.sleep(1)
    
    
    
