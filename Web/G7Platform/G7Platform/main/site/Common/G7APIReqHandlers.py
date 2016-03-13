#-*- coding: UTF-8 -*-
__author__ = 'helios'
'''
    该类作为接口基类
'''

from G7Platform.main.site.Common.G7ReqHandlers import *
from G7Platform.core.tool.cryptor.G7CryptorTool import *
from G7Platform.core.tool.cryptor.G7Cryptor import *

class G7APIReqHandler(G7ReqHandler):
    """api请求基类"""

    @property
    def current_user(self):
        doc = "The current_user property."
        if "userid" in self.httpHeadersJson.keys():
            userid = self.httpHeadersJson["userid"]
            try:
                user = BMUser.objects.get(userid=userid)
                return user
            except BMUser.DoesNotExist:
                return None
        return None

    # 返回http headers头部信息
    @property
    def httpHeadersJson(self):
        jsonDic = {}
        if len(self.request.headers.get_list("User-Agent1")) > 0:
            try:
                http_headers = G7CryptorTool.desBase64_B64DecodeText(self.request.headers.get_list('User-Agent1')[0])
                jsonDic = json.loads(http_headers)
            except:
                pass
        return jsonDic

    @property
    def is_login(self):
        if len(self.httpHeadersJson) == 0:
            return False
        if ("deviceid" not in list(self.httpHeadersJson.keys())) or ("usignature" not in list(self.httpHeadersJson.keys())) or ("userid" not in list(self.httpHeadersJson.keys())):
            return False
        deviceid = self.httpHeadersJson["deviceid"]
        usignature = self.httpHeadersJson["usignature"]
        userid = self.httpHeadersJson["userid"]
        if  self.current_user == None:
            return False

        return self.current_user.userid == userid and self.current_user.usignature == usignature and self.current_user.deviceid == deviceid

    @property
    def params(self):
        g7log("p:"+str(self.get_argument('p')))
        if self.get_argument('p') == None:
            return ""
        else:
            try:
                return G7CryptorTool.desBase64_B64DecodeText(self.get_argument("p"))
            except:
                return self.get_argument("p")

    @property
    def paramsJson(self):
        try:
            g7log(self.params)
            if len(self.params) == 0:
                return {}
            else:
                try:
                    return json.loads(self.params)
                except:
                    return {}

        except:
            return {}

    def responseWrite(self, code="0", message="", data={}):
        self.write(G7APIReqHandler.responseDataText(code, message, data))

    def responseDataText(code="0", message="", data={}):
        code = str(code)
        responseData = G7ResultAsistance.resultErrorDataWrapperToJson(code, message,data)
        if code == "0":
            responseData = G7ResultAsistance.resultSuccessDataWrapperToJson(message, data)

        responseDataText = json.dumps(responseData)
        g7log("responseDataText:"+str(responseDataText))
        return G7CryptorTool.getTextEncryptB64(responseDataText, G7CryptorType.des)
