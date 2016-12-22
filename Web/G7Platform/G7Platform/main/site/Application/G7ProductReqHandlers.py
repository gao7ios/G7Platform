#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler
from G7Platform.main.site.Common.G7ListReqHandlers import G7ListReqHandler
import json
from G7Platform.G7Globals import *
from Application.models import *
from Account.models import *


class G7ProductListReqHandler(G7ListReqHandler): 
    '''
        获取所有产品列表
    '''
    def fetchList(self):
        
        try:
            retDict = self.list(modelAllObjects=G7Product.objects.all().distinct())
            return self.responseWrite(0, "获取成功", data=retDict)
        except:
            return self.responseWrite(1, "获取失败", data=[])

    def get(self):
        
        return self.fetchList()

    def post(self):
        
        return self.fetchList()

class G7MyProductListReqHandler(G7ListReqHandler):

    '''
        获取我的产品列表
    '''

    def fetchList(self):
        try:
            # 用户id
            userid = self.paramsJson.get("identifier")
            if self.paramsJson.get("identifier") != None and self.paramsJson.get("identifier") != "":
                userid = self.current_user.userid
                
            products = [product for product in G7Product.objects.all() if userid in [user.userid for user in product.members.all() if user != None]]
            retDict = self.list(modelAllObjects=products)
            return self.responseWrite(0, "获取成功", data=retDict)
        except:
            return self.responseWrite(1, "获取失败", data={})

    def get(self):
        return self.fetchList()

    def post(self):
        return self.fetchList()


class G7ProductDetailReqHandler(G7APIReqHandler):
    '''
        获取产品详情
    '''
    def fetchDetail(self):

        try:
            # 产品identifier
            identifier = self.paramsJson.get("identifier")  
            product = G7Product.objects.get(identifier=identifier)
            if product:
                return self.responseWrite(0, "获取成功", data=product.toJsonDict("http://"+self.request.host))
            else:
                return self.responseWrite(1, "获取成功", data={})
        except:
            return self.responseWrite(1, "获取失败", data={})

    def post(self):
        return self.fetchDetail()

    def get(self):
        return self.fetchDetail()

class G7ProductMembersReqHandler(G7ListReqHandler):

    def fetchMembers(self):
        try:
            # product id
            productId = self.paramsJson.get("identifier")
            product = G7Product.objects.get(identifier=productId)
            if product != None:
                users = [user.toJsonDict("http://"+self.request.host) for user in product.members.all() ]
                retDict = self.list(modelAllObjects=users)
                return self.responseWrite(0, "获取成功", data=retDict)
            else:
                return self.responseWrite(1, "获取失败", data=[])
        except:
            return self.responseWrite(1, "获取失败", data=[])

    def post(self):
        return self.fetchMembers()

    def get(self):
        return self.fetchMembers()


     