#!/usr/bin/env python
#-*- coding:utf-8 -*-


import socket
import sqlite3
import time


while True:
    try:
        s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        s.connect(('192.168.1.32',9900))
        con=sqlite3.connect('/tmp/test.db')
        cursor=con.cursor()
        cursor.execute('select max(row_id),node_id,airtemper,airhum,landhum,conduct,lux,real_time from weather_nodes group by node_id')
        #value=cursor.fetchall()
        for r in cursor:
            s.send(','.join([str(t)for t in r][1:]))
    
    except sqlite3.Error as selecterr:
        print ('Sqlite Error:'+str(selecterr))
    finally:
        cursor.close()
        #con.commit()
        con.close()
        s.close()   
        time.sleep(5)
    
