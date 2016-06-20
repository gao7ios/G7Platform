#-*- coding: utf-8 -*-

import socket, ssl, json, struct
import binascii
import sys

def Payload(alert='', badge=1, data={}):
     payload = {
        'aps': {
            'alert':alert,
            'sound':'k1DiveAlarm.caf',
            'badge':badge,
         },
        'acme': data,
     }
     return payload

def APN(token, payload, theCertfile):
    theHost = ( 'gateway.push.apple.com', 2195 )

    data = json.dumps( payload )

    # Clear out spaces in the device token and convert to hex
    deviceToken = token.replace(' ','')
    byteToken = binascii.unhexlify(token)

    theFormat = '!BH32sH%ds' % len(data)
    theNotification = struct.pack( theFormat, 0, 32, byteToken, len(data), data )

    # Create our connection using the certfile saved locally
    ssl_sock = ssl.wrap_socket(
            socket.socket( socket.AF_INET, socket.SOCK_STREAM ),
            certfile = theCertfile
        )
    ssl_sock.connect( theHost )

    # Write out our data
    ssl_sock.write( theNotification )

    # Close the connection -- apple would prefer that we keep
    # a connection open and push data as needed.
    ssl_sock.close()

    return True


def push(msg):
    #推送需要用到的证书
    pem = 'apn.pem'
    token = msg['udid']
    data = msg['data']
    
    payload = Payload(msg['content'], msg['count'], data)
    return APN(token, payload, pem)
