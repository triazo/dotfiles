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
import requests
from requests.auth import HTTPBasicAuth
import time

# For sending texts
from numbers import fromnum, tonum, account_sid, auth_token
import json

SOURCE_PORT = 10104
RELAY_PORT   = 10105
keep_alive_time = 300

access_token = ''
with open("/home/adam/.pushbullet_api_key", 'r') as f:
    access_token = f.read()

headers = {"Accept": "application/json",
           "Content-Type": "application/json",
           "User-Agent": "triazo"}
auth=HTTPBasicAuth(access_token, "")

def findPhone():
    # current phone should be the first active device with icon of 'phone'
    url = "https://api.pushbullet.com/v2/devices"
    r = requests.request("GET", url, headers=headers, auth=auth)
    deviceID = ''
    for d in r.json()["devices"]:
        if d["active"] and d["icon"] == "phone":
            deviceID = d["iden"]
    return deviceID

# TODO: only send to phone
def pushToPhone(title, body):
    # create the push
    push = {"type": "note", "title": title, "body": body}

    r = requests.request("POST", "https://api.pushbullet.com/v2/pushes", data=json.dumps(push), headers=headers, auth=auth)


def send_text(jmsg):
    msg = json.loads(jmsg)
    pushToPhone(msg['title'], msg['description'])

    print("sending message to pushbullet: %s: %s"%(msg['title'], msg['description']))


def filter_clients(clients, lock):
    lock.acquire()
    todel = []
    for address in clients:
        if clients[address] + keep_alive_time < time.time():
            todel.append(address)
    log = False
    if len(todel) > 0:
        log = True
    for a in todel:
        del clients[a]
    if log:
        print("removed clients")
    lock.release()

def client_listener(clients, lock, s):
    while True:
        # The data doesn't matter, only the address is looked at.
        # No harm in sending data to another address.  Probably.
        data, addr = s.recvfrom(1024)
        lock.acquire()
        clients[addr] =  time.time()
        lock.release()
        filter_clients(clients, lock)
        print("Recieved connection from %s, all clients: %s"% (str(addr), str(clients)))



def main():
    clients = {}
    clilock = threading.Lock()

    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.bind(('', RELAY_PORT))
    except socket.error as msg:
        print("Error binding chat socket: %s"% msg)
        return -1

    sendthread = threading.Thread(target=client_listener,
                                  args=(clients, clilock, sock))
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
        filter_clients(clients, clilock)
        if len(clients) == 0:
            send_text(msg)

        clilock.acquire()
        dellist = []
        for address in clients:
            try:
                sock.sendto(msg, address)
            except socket.error as error:
                print("Error relaying message: %s"% str(error))
                dellist.append(address)

        for add in dellist:
            del clients[address]

        clilock.release()



if __name__ == "__main__":
    main()
