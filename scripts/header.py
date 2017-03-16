#!/usr/bin/python2

import socket
import sys
import select
import subprocess as sub
import os

sock_addr='/tmp/dwm_header'

def listen(address):

    if os.path.exists(address):
        print('removing previous socket')
        os.remove(address)
        
    sock = socket.socket( socket.AF_UNIX, socket.SOCK_STREAM )
    sys.stderr.write('Listening on ' + str(sock_addr) + '\n')
    sock.bind(sock_addr)
    sock.listen(1)
    
    try:
        while True:
            r, w, e = select.select([sock], [], [], 1)
            if [r, w, e] != [ [], [], []]:
                # In this case, connection is the object that data is recieved from
                connection, client_address = sock.accept()
                data = connection.recv(1024)
                print(data)
                os.system("xsetroot -name " + '\'' + data + '\'')
                connection.close()
            else:
                time = sub.check_output(['date', '+%A %B %d %H:%M:%S']).split('\n')[0]
                battery_info = sub.check_output('acpi').split()
                battery_percent = int(battery_info[3].split('%')[0])
                if battery_info[2].split(',')[0] == "Discharging":
                    battery_time = battery_info[4]
                    display_string = "%s -- %d%% -- %s Remaining" % (time, battery_percent, battery_time)
                    if battery_percent < 15:
                        display_string = "BATTERY LOW!!! -- %s -- BATTERY LOW!!!" % (display_string)
                elif battery_info[2].split(',')[0] == "Charging":
                    battery_time = battery_info[4]
                    display_string = "%s -- %d%% -- %s Until Charged" % (time, battery_percent, battery_time)
                else:
                    display_string = "%s -- %d%%" % (time, battery_percent)

          
                sub.call(['xsetroot', '-name', display_string])
                
    except AssertionError:
        sock.close()
        os.remove(address)
        sys.stdout.write('\n')
        sys.stderr.write("There was an error!\n")
                
def send(address, string):
    sock = socket.socket( socket.AF_UNIX, socket.SOCK_STREAM )
    sock.connect(address)
    sock.send(string)
    sock.close()


def run(sock_addr):
    if len(sys.argv) > 1:
        if sys.argv[1] == 'server' or sys.argv[1] == 'srv':
            listen(sock_addr)
        elif sys.argv[1] == 'client' or sys.argv[1] == 'cli':
            while True:
                message = raw_input('> ')
                if not message: message = '-------'
                send(sock_addr, message)
        elif sys.argv[1] == 'message' or sys.argv[1] == 'msg':
            if len(sys.argv) > 2:
                message = ''
                for word in sys.argv[2:]:
                    message = message + word + ' '
                send(sock_addr, message)
        else:
            print('Please enter a valid state: \'server\', or \'client\'')
    else:
        print('Please enter a valid state: \'server\', or \'client\'')

if __name__ == '__main__':
    run(sock_addr)
