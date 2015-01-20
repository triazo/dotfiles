#!/usr/bin/python


# Accept connections on two ports
#    
#    All connections to source port should 
#    quickly send a message then disconnect
#
#    Connections on Dest port should not send anything, but rather
#    just listen for information
#
#

import socket
import threading
import struct
import time

SOURCE_PORT = 10104
RELAY_PORT   = 10105

def client_listener(clients, lock):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.bind(('', RELAY_PORT))
    except socket.error as msg:
        print("Error binding chat socket: %s"% msg)
        return -1

    while True:
        # The data doesn't matter, only the address is looked at.
        # No harm in sending data to another address.  Probably.
        data, addr = s.recvfrom(1024)
        lock.acquire()
        clients[addr] =  time.time()
        lock.release()
        print("Recieved connection from %s"% str(addr))



def main():
    clients = {}
    clilock = threading.Lock()
        
    sendthread = threading.Thread(target=client_listener,
                                  args=(clients, clilock))
    sendthread.start()

    # Main now listens for incoming messages and forewards them to all
    # clients.
    
    
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.bind(('', SOURCE_PORT))
        s.listen(5)
    except socket.error as error:
        print("Error binding udp socket: %s"% error)
        return -1

    while True:
        conn, addr = s.accept()
        msglen = struct.unpack_from("!I",conn.recv(4))[0]
        msg = conn.recv(msglen)
        conn.close()
        print(msg)    
        # Now relay the message to all clients
        # But only the ones that have contacted the server in the last
        # 5 minutes
        ss = socket.socket(socket.AF_INET, SOCK_DGRAM)
        clilock.aquire()
        clients = dict((k, v) for k, v in d.items() if v + 300 >
        time.time())
        for addres in clients:
            try:
                #cconn.send(struct.pack("!I", msglen))
                cconn.sendto(msg, address)
            except socket.error as error:
                print("Error relaying message: %s"% str(error))
                clients.remove(address)
        clilock.release()
        


if __name__ == "__main__":
    main()
