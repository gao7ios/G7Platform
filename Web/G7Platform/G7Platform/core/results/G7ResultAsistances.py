#-*- coding: utf-8 -*-
__author__ = 'yuyang'
import json
from G7Platform.profile.settings.web.G7Results import G7ResultDic

class G7ResultAsistance:

    def resultErrorDataWrapperToJson(code="0", message="",data={}):

        retDic = {}
        if type(code) != type(""):
            code = str(code)
        if code in list(G7ResultDic.keys()):
            retDic = {
                "ResultCode":str(code),
                "ResultMessage":G7ResultDic.get(code),
                "Data":data
            }
        else:
            retDic = {
                "ResultCode":str(code),
                "ResultMessage":"",
                "Data":data
            }

        return retDic

    def resultErrorDataWrapperToJsonString(code="0", message="", data={}):

        retDic = {}
        if type(code) != type(""):
            code = str(code)

        if code in G7ResultDic.keys():
            retDic = {
                "ResultCode":str(code),
                "ResultMessage":G7ResultDic.get(code),
                "Data":data
            }
        else:
            retDic = {
                "ResultCode":str(code),
                "ResultMessage":"",
                "Data":data
            }

        return json.dumps(retDic)


    def resultSuccessDataWrapperToJson(message, data={}):

        retDic = {
                "ResultCode":"0",
                "ResultMessage":message,
                "Data":data
            }

        return retDic
