#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
import json
from G7Platform.G7Globals import *
from Application.models import *
from Account.models import *

class G7ProjectListReqHandler(G7APIReqHandler): 


    def fetchList(self):
        
        userid = self.paramsJson.get("identifier")
        pageIndex = self.paramsJson.get("pageIndex")
        print(self.paramsJson)
        try:
            user = G7User.objects.get(userid=userid)
            projects = [project.toJsonDict("http://"+self.request.host) for project in G7Project.objects.all() if userid in [user.userid for user in project.members.all()]]
            return self.responseWrite(0, "获取成功", data=projects)
        except:
            return self.responseWrite(1, "获取失败", data=[])

    def get(self):
        
        return self.fetchList()

    def post(self):
        
        return self.fetchList()


class G7ProjectDetailReqHandler(G7APIReqHandler):

    def fetchDetail(self):

        identifier = self.paramsJson.get("identifier")  
        try:
            project = G7Project.objects.get(identifier=identifier)
            if project:
                return self.responseWrite(0, "获取成功", data=project.toJsonDict("http://"+self.request.host))
            else:
                return self.responseWrite(1, "获取成功", data={})
        except:
            return self.responseWrite(1, "获取失败", data={})

    def post(self):
        return self.fetchDetail()

    def get(self):
        return self.fetchDetail()

class G7ApplicationListReqHandler(G7APIReqHandler):
    '''
        首页
    '''
    def fetchList(self):

        userid = self.paramsJson.get("identifier")
        pageIndex = self.paramsJson.get("pageIndex")
        try:
            user = G7User.objects.get(userid=userid)
            applications = [application.toJsonDict("http://"+self.request.host) for application in G7Application.objects.all() if userid == application.user.userid]
            self.responseWrite(0, "获取成功", data=applications)
        except:
            self.responseWrite(1, "获取失败", data=[])

    def get(self):
        return self.fetchList()


    def post(self):
        return self.fetchList()



class G7ApplicationDetailReqHandler(G7APIReqHandler):
    '''
        首页
    '''
    def fetchDetail(self):

        identifier = self.paramsJson.get("identifier")    
        try:
            application = G7Application.objects.get(identifier=identifier)
            if application:
                return self.responseWrite(0, "获取成功", data=application.toJsonDict("http://"+self.request.host))
            else:
                return self.responseWrite(1, "获取成功", data={})
        except:
            return self.responseWrite(1, "获取失败", data={})

    def post(self):
        return self.fetchDetail()

    def get(self):
        return self.fetchDetail()

     