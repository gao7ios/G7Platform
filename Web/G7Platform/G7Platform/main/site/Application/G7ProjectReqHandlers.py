#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
from G7Platform.main.site.Common.G7ListReqHandlers import G7ListReqHandler
import json
from G7Platform.G7Globals import *
from Application.models import *
from Account.models import *


class G7ProjectListReqHandler(G7ListReqHandler): 
    '''
        获取所有产品列表
    '''
    def fetchList(self):
        
        # try:
        print(self.paramsJson)
        pageIndex = int(self.paramsJson.get("pageIndex"))
        allProjects = [project.toJsonDict("http://"+self.request.host) for project in G7Project.objects.all()]
        isLastPage = self.isLastPage(allList=allProjects, pageIndex=pageIndex)
        projects = self.sourceList(allList=allProjects, pageIndex=pageIndex)
        return self.responseWrite(0, "获取成功", data={"list":projects, "isLastPage":isLastPage})
        # except:
        #     return self.responseWrite(1, "获取失败", data=[])

    def get(self):
        
        return self.fetchList()

    def post(self):
        
        return self.fetchList()

class G7MyProjectListReqHandler(G7ListReqHandler):

    '''
        获取我的产品列表
    '''

    def fetchList(self):
        try:
            # 用户id
            userid = self.paramsJson.get("identifier")
            if self.paramsJson.get("identifier") != None and self.paramsJson.get("identifier") != "":
                userid = self.current_user.userid

            pageIndex = int(self.paramsJson.get("pageIndex"))
            projects = [project.toJsonDict("http://"+self.request.host) for project in G7Project.objects.all() if userid in [user.userid for user in project.members.all() if user != None]]
            isLastPage = self.isLastPage(allList=projects, pageIndex=pageIndex)
            projects = self.sourceList(allList=projects, pageIndex=pageIndex)
            return self.responseWrite(0, "获取成功", data={"list":projects, "isLastPage":isLastPage})
        except:
            return self.responseWrite(1, "获取失败", data=[])

    def get(self):
        return self.fetchList()

    def post(self):
        return self.fetchList()


class G7ProjectDetailReqHandler(G7APIReqHandler):
    '''
        获取产品详情
    '''
    def fetchDetail(self):

        try:
            # 产品identifier
            identifier = self.paramsJson.get("identifier")  
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

class G7ProjectMembersReqHandler(G7ListReqHandler):

    def fetchMembers(self):
        try:
            # project id
            projectId = self.paramsJson.get("identifier")
            project = G7Project.objects.get(identifier=projectId)
            if project != None:
                pageIndex = int(self.paramsJson.get("pageIndex"))
                users = [user.toJsonDict("http://"+self.request.host) for user in project.members.all() ]
                isLastPage = self.isLastPage(allList=users, pageIndex=pageIndex)
                users = self.sourceList(allList=users, pageIndex=pageIndex)
                return self.responseWrite(0, "获取成功", data={"list":users, "isLastPage":isLastPage})
            else:
                return self.responseWrite(1, "获取失败", data=[])
        except:
            return self.responseWrite(1, "获取失败", data=[])

    def post(self):
        return self.fetchMembers()

    def get(self):
        return self.fetchMembers()


     