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

SOURCE_PORT = 10104
RELAY_PORT   = 10105

def client_listener(clients, lock):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.bind(('', RELAY_PORT))
        s.listen(5)
    except socket.error as msg:
        print("Error binding socket: %s", msg)
        return -1

    while True:
        conn, addr = s.accept()
        lock.acquire()
        clients.append((conn, addr))
        lock.release()
        print("Recieved connection from %s"% str(addr))



def main():
    clients = []
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
        print("Error binding socket: %s", error)
        return -1

    while True:
        conn, addr = s.accept()
        msglen = struct.unpack_from("!I",conn.recv(4))[0]
        msg = conn.recv(msglen)
        conn.close()
        print(msg)    
        # Now relay the message to all clients
        for cconn, caddr in clients:
            try:
                cconn.send(struct.pack("!I", msglen))
                cconn.send(msg)
            except socket.error as error:
                print("Error relaying message: %s"% str(error))
                cconn.close()
                clients.remove((cconn,caddr))
        


if __name__ == "__main__":
    main()
