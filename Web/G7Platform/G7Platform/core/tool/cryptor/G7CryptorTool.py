#-*- coding: utf-8
__author__ = 'yuyang'

from G7Platform.G7Globals import *
from G7Platform.profile.settings.G7Settings import *
from G7Platform.core.tool.cryptor.G7Cryptor import *

cryptor_types = {
    "base64":"0",
    "des":"2",
    "xxtea":"1",
    "aes":"3",
    "rsa":"4",
    "md5":"5",
}

class G7CryptorType:

    base64 = "base64"
    des = "des"
    xxtea = "xxtea"
    aes = "aes"
    rsa = "rsa"
    md5 = "md5"

    def cryptorPrefix(cryptorType):
        if cryptorType in list(cryptor_types.keys()):
            return cryptor_types[cryptorType]
        else:
            return "0"

class G7CryptorTool:

    def desBase64_B64EncodeText(b64Text):

        if len(b64Text) > 0:
            desEncodeText = G7Cryptor.desEncode(G7Cryptor.base64Decode(b64Text), desPassword)
            return desEncodeText
        else:
            return ""

    def desBase64_B64DecodeText(b64Text):

        if len(b64Text) > 0:
            desDecodeText = G7Cryptor.desDecode(G7Cryptor.base64Decode(b64Text), desPassword)
            return desDecodeText
        else:
            return ""

    def desBase64_TextEncodeB64(text):

        if len(text) > 0:
            g7log("desBase64_TextEncodeB64:"+str(text))
            desEncodeText = G7Cryptor.desEncode(text, desPassword)
            g7log("desEncodeText:"+str(desEncodeText))
            return G7Cryptor.base64Encode(desEncodeText)
        else:
            return ""

    def desBase64_TextDecodeB64(text):

        if len(text) > 0:
            desDecodeText = G7Cryptor.desDecode(text, desPassword)
            return G7Cryptor.base64Encode(desDecodeText)
        else:
            return ""

    def desBase64_B64EncodeB64(b64Text):

        if len(b64Text) > 0:
            desEncodeText = G7Cryptor.desEncode(G7Cryptor.base64Decode(b64Text), desPassword)
            return G7Cryptor.base64Encode(desEncodeText)
        else:
            return ""

    def desBase64_B64DecodeB64(b64Text):

        if len(b64Text) > 0:
            desDecodeText = G7Cryptor.desDecode(G7Cryptor.base64Decode(b64Text), desPassword)
            return G7Cryptor.base64Encode(desDecodeText)
        else:
            return ""

    def getB64DecryptText(text):

        if type(text) == type(b''):
            cryptor_type = str(text[:2])[2:-1]
        else:
            cryptor_type = text[:2]

        cryptor_text = text[2:]
        decryptBytes = G7Cryptor.base64Decode(cryptor_text)
        if cryptor_type == cryptor_types[G7CryptorType.base64]:
            decryptBytes = G7Cryptor.base64Decode(cryptor_text)
        elif cryptor_type == cryptor_types[G7CryptorType.des]:
            decryptBytes = G7CryptorTool.desBase64_B64DecodeText(cryptor_text)
        elif cryptor_type == cryptor_types[G7CryptorType.xxtea]:
            decryptBytes = G7CryptorTool.desBase64_B64DecodeText(cryptor_text)
        elif cryptor_type == cryptor_types[G7CryptorType.aes]:
            decryptBytes = G7CryptorTool.desBase64_B64DecodeText(cryptor_text)
        elif cryptor_type == cryptor_types[G7CryptorType.rsa]:
            decryptBytes = G7CryptorTool.desBase64_B64DecodeText(cryptor_text)
        elif cryptor_type == cryptor_types[G7CryptorType.md5]:
            decryptBytes = G7CryptorTool.desBase64_B64DecodeText(cryptor_text)
        else:
            decryptBytes = b''

        return bytesToString(decryptBytes)

    def getTextEncryptB64(text, cryptror_type):

        if cryptror_type not in cryptor_types.keys():
            return ""

        prefix = cryptor_types[cryptror_type]
        encryptBytes = b''
        if cryptror_type == G7CryptorType.base64:
            encryptBytes = bytes(prefix,"utf-8")+G7Cryptor.base64Encode(text)
        elif cryptror_type == G7CryptorType.des:
            encryptBytes = bytes(prefix,"utf-8")+G7CryptorTool.desBase64_TextEncodeB64(text)
        elif cryptror_type == G7CryptorType.xxtea:
            encryptBytes = bytes(prefix,"utf-8")+G7CryptorTool.desBase64_TextEncodeB64(text)
        elif cryptror_type == G7CryptorType.aes:
            encryptBytes = bytes(prefix,"utf-8")+G7CryptorTool.desBase64_TextEncodeB64(text)
        elif cryptror_type == G7CryptorType.rsa:
            encryptBytes = bytes(prefix,"utf-8")+G7CryptorTool.desBase64_TextEncodeB64(text)
        elif cryptror_type == G7CryptorType.md5:
            encryptBytes = bytes(prefix,"utf-8")+G7CryptorTool.desBase64_TextEncodeB64(text)
        else:
            encryptBytes = b''
        g7log("finally:"+str(encryptBytes))
        g7log("G7CryptorTool.desBase64_TextEncodeB64(text):"+str(G7CryptorTool.desBase64_TextEncodeB64(text)))
        return G7CryptorTool.bytesToString(encryptBytes)

    def bytesToString(bytesString):
        if type(bytesString) == type(b''):
            return bytesString.decode("utf-8")
        else:
            return ""
