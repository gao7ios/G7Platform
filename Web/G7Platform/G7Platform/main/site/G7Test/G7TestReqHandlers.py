#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
import json
from G7Platform.G7Globals import *
from Application.models import G7Application,G7Project
from django.forms.models import model_to_dict

class G7TestReqHandler(G7APIReqHandler):
    '''
        首页
    '''
    def get(self):
        resultData = {"requestData":self.paramsJson, "User-Agent1":self.httpHeadersJson}
        # g7log(resultData)
        print(resultData)

        proID = self.paramsJson["id"];
        proID = int(proID)

        allProjects = G7Project.objects.all()
        length = len(allProjects)

# 查询id异常处理和服务器数据空处理
        if proID<=0 or length==0:
            self.responseWrite(0, "id错误", data="")
            return

        resultPro = 0
        for i in range(0,length):
            temp = allProjects[i]
            if temp.id ==proID:
                resultPro=temp

# 查询不到
        if resultPro == 0:
            self.responseWrite(0, "id错误", data="")
            return


        project1 = resultPro
        jsonData=model_to_dict(project1)
        jsonData['icon']=project1.icon.path

# 解析产品里面的所有打包记录
        applications=project1.applications.all()
        appArr=[]
        for i in range(0,len(applications)):
            app=applications[i]
            appJson=model_to_dict(app)
            appJson['dsymFile']=app.dsymFile.path
            appJson['file']=app.file.path
            appJson['icon']=app.icon.path
            appArr.append(appJson)

        jsonData['applications']=appArr

# 请求成功返回
        self.responseWrite(0, "请求成功", data=jsonData)




    def post(self):
        resultData = {"requestData":self.paramsJson, "User-Agent1":self.httpHeadersJson}
        print(resultData)
        self.responseWrite(0, "asdfasdf2", data=resultData)

