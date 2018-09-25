#!/usr/bin/env python
#-*- coding:utf-8 -*-

"""
Created on Mon Dec 19 15:05:40 2016

@author:LvYang-NUIST in SJTU
"""
import socket
import time
import sqlite3

while(1):
    time.sleep(120)
    try:
        con=sqlite3.connect('/tmp/test.db')
        cursor=con.cursor()
        cursor.execute('select max(row_id),node_id,airtemper,airhum,landhum,conduct,lux,real_time from weather_nodes group by node_id')
        #value=cursor.fetchall()
        for r in cursor:
            try:
                s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
                s.connect(('192.168.1.100',9900))
                s.send(','.join([str(t)for t in r][1:])+',\n')
                time.sleep(1)
                s.close()
            except socket.error as serr:
                print('socket error:'+str(serr))
            finally:
                s.close()
    except sqlite3.Error as selecterr:
        print ('Sqlite Error:'+str(selecterr))
    finally:
        cursor.close()
        con.commit()
        con.close()
        
