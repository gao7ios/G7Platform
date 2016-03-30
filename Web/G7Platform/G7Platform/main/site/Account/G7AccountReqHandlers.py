#-*- coding: UTF-8 -*-
__author__ = 'yuyang'

from G7Platform.G7Globals import *
from Account.models import G7User
from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler

class G7AccountReqHandler(G7APIReqHandler):

        def get(self):
                username = self.paramsJson.get("username")
                password = self.paramsJson.get("password")

                users = G7User.objects.filter(username=username)

                isExist =  len(users) > 0

                if isExist == True:
                        user = users.first()
                        isSuccess =  user.check_password(password)
                        if  isSuccess:
                                resultData = {

                                                "des":"登录成功",
                                                "data": {
                                                "is_active":int(user.is_active),
                                                "is_admin":int(user.is_admin),
                                                "username":user.username,
                                                "userid":user.userid,
                                                "nickname":user.nickname,
                                                "job":user.job,
                                                "sex":user.sex,
                                                "mobile":user.mobile,
                                                "email":user.email,
                                                "thumb":str(user.thumb),
                                                "date_of_birth":str(user.date_of_birth),
                                                "age":user.age,
                                                "expires_time":str(user.expires_time),
                                                "usignature":user.usignature,
                                                "nickname":user.nickname,
                                                "clientid":str(user.clientid),
                                                "groups":str(user.groups),
                                                "description":user.description,
                                                "email_vip":user.email_vip,
                                                "mail_pwd":user.mail_pwd
                                            }
                                }
                                self.responseWrite(0, "登录成功", data=resultData)
                        else:
                                resultData = {

                                                "des":"用户密码错误",
                                                "data": {}

                                }
                                self.responseWrite(0, "请求成功", data=resultData)
                else:
                        resultData = {
                                                "des":"用户不存在",
                                                "data": {}
                                }
                        self.responseWrite(0, "请求成功", data=resultData)

                       



