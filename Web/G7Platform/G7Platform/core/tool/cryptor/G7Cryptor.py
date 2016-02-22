#-*- coding: utf-8 -*-

import base64
import hashlib
import random
import string
import time
from urllib.request import unquote, urlparse

from pyDes import *

class G7Cryptor(object):
    """docstring for G7Cryptor"""
    
    def desEncode(text, key):
        if len(text) > 0:
            desCryptor = des(key, ECB, key,pad=None, padmode=PAD_PKCS5)
            desEncodeText = desCryptor.encrypt(text)
            return desEncodeText
        else:
            return ""

    def desDecode(text, key):
        if len(text) > 0:
            desCryptor = des(key, ECB, key, padmode=PAD_PKCS5)
            desEncodeText = desCryptor.decrypt(text)
            return desEncodeText
        else:
            return ""

    def base64Encode(text):
        if len(text) > 0:
            return base64.b64encode(text)
        else:
            return ""

    def base64Decode(text):
        if len(text) > 0:
            return base64.b64decode(text)

        else:
            return ""

    def urlEncode(text):
        if len(text) > 0:
            return urlparse(text)
        else:
            return ""

    def urlDecode(text):
        if len(text) > 0:
            return unquote(text)
        else:
            return ""

    def desBase64_B64EncodeText(b64Text, key):
        if len(b64Text) > 0:
            desEncodeText = G7Cryptor.desEncode(G7Cryptor.base64Decode(b64Text), key)
            return desEncodeText
        else:
            return ""

    def desBase64_B64DecodeText(b64Text, key):
        if len(b64Text) > 0:
            desDecodeText = G7Cryptor.desDecode(G7Cryptor.base64Decode(b64Text), key)
            return desDecodeText
        else:
            return ""

    def desBase64_TextEncodeB64(text, key):
        if len(text) > 0:
            desEncodeText = G7Cryptor.desEncode(text, key)
            return G7Cryptor.base64Encode(desEncodeText)
        else:
            return ""

    def desBase64_TextDecodeB64(text, key):
        if len(text) > 0:
            desDecodeText = G7Cryptor.desDecode(text, key)
            return G7Cryptor.base64Encode(desDecodeText)
        else:
            return ""

    def desBase64_B64EncodeB64(b64Text, key):
        if len(b64Text) > 0:
            desEncodeText = G7Cryptor.desEncode(G7Cryptor.base64Decode(b64Text), key)
            return G7Cryptor.base64Encode(desEncodeText)
        else:
            return ""

    def desBase64_B64DecodeB64(b64Text, key):
        if len(b64Text) > 0:
            desDecodeText = G7Cryptor.desDecode(G7Cryptor.base64Decode(b64Text), key)
            return G7Cryptor.base64Encode(desDecodeText)
        else:
            return ""

    def md5Encrypt(text):
        m = hashlib.md5()
        m.update(text.encode('utf-8'))
        return m.hexdigest()
