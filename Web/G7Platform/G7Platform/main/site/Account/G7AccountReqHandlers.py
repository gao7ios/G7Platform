#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.G7Globals import *
from Account.models import G7User
from G7Platform.main.site.Common.G7APIReqHandlers import *
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler

class G7AccountLoginReqHandler(G7APIReqHandler):

    def login(self):

        username = self.paramsJson.get("username")
        password = self.paramsJson.get("password")
        users = G7User.objects.filter(username=username)

        isExist =  len(users) > 0
        if isExist == True:
            user = users.first()

            isSuccess = user.check_password(password)
            if isSuccess:
                if self.httpHeadersJson.get("g7udid"):
                    user.deviceId = self.httpHeadersJson.get("g7udid")
                    user.save()
                    
                resultData = user.toJsonDict("http://"+self.request.host)
                self.responseWrite(0, "登录成功", data=resultData)
            else:  
                self.responseWrite(1, "用户密码错误", data={})
        else:
            self.responseWrite(1, "用户不存在", data={})

    def get(self):
        
        return self.login()

    def post(self):

        return self.login()


class G7AccountProfileReqHandler(G7APIReqHandler):

    def profile(self):

        userid = self.paramsJson.get("userid")
        if self.current_user and userid == self.current_user.userid:
            resultData = self.current_user.toJsonDict("http://"+self.request.host)
            self.responseWrite(0, "获取成功", data=resultData)
        else:
            users = G7User.objects.filter(userid=userid)
            if len(users) > 0:
                user = users.first()
                resultData = user.toJsonDict("http://"+self.request.host)
                self.responseWrite(0, "获取成功", data=resultData)
            else:
                self.responseWrite(1, "获取失败", data={})

    def get(self):
        return self.profile()

    def post(self):
        return self.profile()



                       



