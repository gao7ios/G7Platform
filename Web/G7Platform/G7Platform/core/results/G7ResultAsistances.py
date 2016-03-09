#-*- coding: utf-8 -*-
__author__ = 'yuyang'
import json
from G7Platform.profile.settings.web.G7Results import G7ResultDic

class G7ResultAsistance:

    def resultErrorDataWrapperToJson(code, data={}):

        retDic = {}
        if type(code) == type(""):
            try:
                code = int(code)
            except:
                return retDic
        if code in list(G7ResultDic.keys()):
            retDic = {
                "ResultCode":code,
                "ResultMessage":G7ResultDic[code],
                "ResultData":data
            }

        return retDic

    def resultErrorDataWrapperToJsonString(code, data={}):

        retDic = {}
        if type(code) == type(""):
            try:
                code = int(code)
            except:
                return json.dumps(retDic)

        if code in G7ResultDic.keys():
            retDic = {
                "ResultCode":code,
                "ResultMessage":G7ResultDic[code],
                "ResultData":data
            }

        return json.dumps(retDic)


    def resultSuccessDataWrapperToJson(message, data={}):

        retData = {}
        retDic = {
                "ResultCode":0,
                "ResultMessage":message,
                "ResultData":data
            }

        return retDic
