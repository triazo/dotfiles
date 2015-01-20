#!/usr/bin/python2

import socket
import pynotify
import json
import time
import threading


logfile = '/home/adam/notifyerror.log'
pingdelay = 5
host = "trizao.net"
port = 10105

def pinger(address, socket):
    while True:
        socket.sendto("Ping!", ("triazo.net", 10105))
        time.sleep(pingdelay)

def sock_connect():

    # Make socket.  Re-use socket for sending and stuff
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.bind(('', 0))
        
    pingthread = threading.Thread(target=pinger, args=((host, port), s))
    pingthread.start()

    # Wait on recv.  Work with lengths
    while True:
        msg, addr = s.recvfrom(2048) # Need to somehow ensure the entire packet is there
        print(msg)
        n = json.loads(msg)
        print(n)
        try:
            pynotify.init("wee-notifier")
            wn = pynotify.Notification(n['title'], n['description'], n['icon'])
            wn.set_urgency(pynotify.Urgency(n['priority']))
            wn.set_timeout(n['time_out'])
            wn.show()
        except Exception as error:
            open(logfile, 'a').write('anotify: {0}\n'.format(error))
                    

def main():
    i = 0
    while i < 100:
        #try:
        if sock_connect() == 1:
            i = 0
        #except Exception as error:
        # open(logfile, 'a').write('socket-notifier: {0}\n'.format(error))
        # i += 1
        time.sleep(3)
        

    pynotify.init("wee-notifier")
    wn = pynotify.Notification('Notifier', 'Notifier has timed out after %d tries'%i)
    wn.set_urgency(pynotify.Urgency(2))
    wn.set_timeout(500)
    wn.show()
            


if __name__ == "__main__":
    i = 0
    main()
