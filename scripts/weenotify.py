#!/usr/bin/python2

import paramiko
import socket
import struct
import pynotify
import json
import time

host = "triazo.net"
logfile = '/home/adam/notifyerror.log'


def sock_connect():

    # Connect once initially
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((host, 10105))

    print("Connected to %s"% host)
    # Wait on recv.  Work with lengths
    while True:
        smsg = s.recv(4)
        if len(smsg) != 4:
            print(len(smsg))
            return 1
        msglen = struct.unpack_from("!I",smsg)[0]
        msg = s.recv(msglen)
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
        try:
            if sock_connect() == 1:
                i = 0
        except Exception as error:
            open(logfile, 'a').write('socket-notifier: {0}\n'.format(error))
            i += 1

        time.sleep(3)
        

    pynotify.init("wee-notifier")
    wn = pynotify.Notification('Notifier', 'Notifier has timed out after %d tries'%i)
    wn.set_urgency(pynotify.Urgency(2))
    wn.set_timeout(500)
    wn.show()
            


if __name__ == "__main__":
    i = 0
    main()
