#-*- coding: utf-8 -*-

import base64
import hashlib
import random
import string
import time
from urllib.request import unquote, urlparse
from G7Platform.G7Globals import *
from Crypto.Cipher import *
from Crypto import Random
from binascii import b2a_hex, a2b_hex

class G7Cryptor:
    """docstring for G7Cryptor"""

    def aesEncode(text, key, mode=AES.MODE_CBC):
        try:
            cryptor = AES.new(key)
            #这里密钥key 长度必须为16（AES-128）、24（AES-192）、或32（AES-256）Bytes 长度.目前AES-128足够用
            length = 16
            count = len(text)
            add = length - (count % length)
            text = G7Cryptor.convertToString(text) + (chr(0) * add)
            ciphertext = cryptor.encrypt(G7Cryptor.convertToByte(text))
            #因为AES加密时候得到的字符串不一定是ascii字符集的，输出到终端或者保存时候可能存在问题
            #所以这里统一把加密后的字符串转化为16进制字符串
            outputText = b2a_hex(ciphertext)
            return outputText
        except:
            return b''

    def aesDecode(text, key, mode=AES.MODE_CBC):
        try:
            cryptor = AES.new(key)
            plain_text = G7Cryptor.convertToString(cryptor.decrypt(a2b_hex(G7Cryptor.convertToByte(text))))
            outputText = plain_text.rstrip(chr(0))
            return outputText
        except:
            return b''

    def desEncode(text, key):
        # try:
        if len(text) > 0 and type(text) == type(b''):
            desCryptor = DES.new(key, DES.MODE_CBC, key)
            length = 8
            g7log("textdesEncode:"+str(text))
            count = len(text) % 8
            if count < length:
                add = (length-count)
                text = text + (b' ' * add)
            desEncodeText = desCryptor.encrypt(text)
            return desEncodeText
        else:
            return b''
        # except:
        #     return b''

    def desDecode(text, key):
        # try:
        desCryptor = DES.new(key, DES.MODE_CBC, key)
        desEncodeText = desCryptor.decrypt(text)
        return desEncodeText
        # except:
        #     return b''

    def base64Encode(text):
        if len(text) > 0 and type(text) == type(b''):
            try:
                outputText = base64.b64encode(text)
                return outputText
            except:
                try:
                    outputText = base64.b64encode(G7Cryptor.convertToByte(text))
                    return outputText
                except:
                    return b''
        else:
            return b''

    def base64Decode(text):
        if len(text) > 0 and type(text) == type(b''):
            try:
                outputText = base64.b64decode(text)
                return outputText
            except:
                try:
                    outputText = base64.b64decode(G7Cryptor.convertToByte(text))
                    return outputText
                except:
                    return b''
        else:
            return b''

    def urlEncode(text):
        if len(text) > 0 and type(text) == type(b''):
            return urlparse(text)
        else:
            return ""

    def urlDecode(text):
        if len(text) > 0 and type(text) == type(b''):
            return unquote(text)
        else:
            return ""

    def desBase64_B64EncodeText(text, key):
        if len(text) > 0 and type(text) == type(b''):
            outputText = G7Cryptor.desEncode(G7Cryptor.base64Decode(G7Cryptor.convertToByte(text)), key)
            return outputText
        else:
            return b''

    def desBase64_B64DecodeText(text, key):
        if len(text) > 0 and type(text) == type(b''):
            outputText = G7Cryptor.desDecode(G7Cryptor.base64Decode(text), key)
            return outputText
        else:
            return b''

    def desBase64_TextEncodeB64(text, key):
        if len(text) > 0 and type(text) == type(b''):
            desEncodeText = G7Cryptor.desEncode(G7Cryptor.convertToByte(text), key)
            outputText = G7Cryptor.base64Encode(desEncodeText)
            return outputText
        else:
            return b''

    def desBase64_TextDecodeB64(text, key):
        if len(text) > 0 and type(text) == type(b''):
            desDecodeText = G7Cryptor.desDecode(G7Cryptor.convertToByte(text), key)
            outputText = G7Cryptor.base64Encode(desDecodeText)
            return outputText
        else:
            return b''

    def desBase64_B64EncodeB64(text, key):
        if len(text) > 0 and type(text) == type(b''):
            desEncodeText = G7Cryptor.desEncode(G7Cryptor.base64Decode(G7Cryptor.convertToByte(text)), key)
            outputText = G7Cryptor.base64Encode(desEncodeText)
            return outputText
        else:
            return b''

    def desBase64_B64DecodeB64(text, key):
        if len(text) > 0 and type(text) == type(b''):
            desDecodeText = G7Cryptor.desDecode(G7Cryptor.base64Decode(G7Cryptor.convertToByte(text)), key)
            outputText = G7Cryptor.base64Encode(desDecodeText)
            return outputText
        else:
            return b''

    def md5Encrypt(text):
        m = hashlib.md5()
        m.update(G7Cryptor.convertToByte(text))
        outputText = m.hexdigest()
        return outputText

    def convertToByte(text):
        if type(text) == type(""):
            try:
                return text.encode("utf-8")
            except:
                return b''
        return text

    def convertToString(text):
        if type(text) == type(b''):
            try:
                return text.decode("utf-8")
            except:
                return str(text)[2:-1]
        return text
