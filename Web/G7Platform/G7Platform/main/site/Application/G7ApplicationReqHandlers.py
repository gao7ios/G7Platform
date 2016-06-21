#-*- coding: utf-8 -*-

import io
import zipfile
import plistlib
import uuid
import sys
import time
import json
import mimetypes
import os
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

if sys.version_info.major == 3:
    from http.client import HTTPConnection
else:
    from httplib import HTTPConnection

import tornado
import tornado.web

from Application.models import *
from Account.models import *
from Push.models import *
from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7ReqHandlers import G7ReqHandler
from G7Platform.main.site.Common.G7ListReqHandlers import G7ListReqHandler

from G7Platform.G7Globals import *
from django.core.files.base import ContentFile
from django.conf import settings


# class G7ApplicationPgyerUploader():

#     def __init__(self):

#         self.domain = ""
#         self.urlPath = ""
#         self.uKey = ""
#         self.api_key = ""
#         self.ipaFile = ""
#         self.installPassword = ""
#         self.mail_receiver = []
#         self.product_name = ""
#         self.build_version = ""
#         self.project_version = ""
#         self.currentG7User = None
#         self.g7CommonSetting = {}
#         self.plist = {}

#     def fileSize(self, byteSize):

#         if byteSize >= 1024 and byteSize < 1024*1024:
#             return str(byteSize*1.0/1024)+"KB"

#         elif byteSize >= 1024*1024 and byteSize < 1024*1024*1024:
#             return str(byteSize*1.0/1024/1024)+"MB"

#         elif byteSize >= 1024*1024*1024 and byteSize < 1024*1024*1024*1024:
#             return str(byteSize*1.0/1024/1024/1024)+"GB"

#         return str(byteSize)+"B"

#     #请求字典编码
#     def _encode_multipart(self, params_dict):
#         boundary = '----------%s' % hex(int(time.time() * 1000))
#         data = []
#         for k, v in params_dict.items():
#             data.append('--%s' % boundary)
#             if hasattr(v, 'read'):
#                 filename = getattr(v, 'name', '')
#                 content = v.read()
#                 decoded_content = content.decode('ISO-8859-1')
#                 data.append('Content-Disposition: form-data; name="%s"; filename="kangda.ipa"' % k)
#                 data.append('Content-Type: application/octet-stream\r\n')
#                 data.append(decoded_content)
#             else:
#                 data.append('Content-Disposition: form-data; name="%s"\r\n' % k)
#                 data.append(v if isinstance(v, str) else v.decode('utf-8'))
#         data.append('--%s--\r\n' % boundary)
#         return '\r\n'.join(data), boundary

#     #处理 蒲公英 上传结果
#     def handle_result(self, result, mail_receiver):
#         json_result = json.loads(result)
#         if json_result['code'] is 0:
#             return self.send_Email(json_result, mail_receiver)
#         else:
#             return G7ReqHandler.responseDataText(10003)

#     #发送邮件
#     def send_Email(self, json_result, mail_receiver):
#         if len(mail_receiver) == 0:
#             return G7ReqHandler.responseDataText(10009)

#         try:
#             pid = self.plist['G7PID']
#             ver = self.plist['G7VER']
#             ch  = self.plist['G7CH']
#             pt  = self.plist['G7PT']
#         except:
#             pid = 0
#             ver = 0
#             ch     = 0
#             pt    = 0

#         appName = json_result['data']['appName']
#         appKey = json_result['data']['appKey']
#         appVersion = json_result['data']['appVersion']
#         appBuildVersion = json_result['data']['appBuildVersion']
#         appShortcutUrl = json_result['data']['appShortcutUrl']
#         appIconKey = json_result['data']['appIcon']
#         appFileSize  = json_result['data']['appFileSize']
#         appIdentifier = json_result['data']['appIdentifier']
#         appUpdated = json_result['data']['appUpdated']
#         appCreated = json_result['data']['appCreated']

#         #根据不同邮箱配置 host，user，和pwd

#         if self.currentG7User != None and self.currentG7User.mail_pwd and self.currentG7User.mail_pwd != "":
#             mail_host = "smtp."+self.currentG7User.email.split("@")[1]
#             mail_user = self.currentG7User.email
#             mail_username = self.currentG7User.username
#             mail_pwd = self.currentG7User.mail_pwd
#         else:
#             mail_host = 'smtp.163.com'
#             mail_user = 'g7platform@163.com'
#             mail_username = 'g7platform'
#             mail_pwd = 'epuyvjpmusfwbzwr'

#         mail_to = ','.join(mail_receiver)
#         mail_smtpPort = '25'
#         mail_sslPort  = '465'

#         msg = MIMEMultipart()

#         appInstallUrl = 'http://www.pgyer.com/' + str(appShortcutUrl)
#         appIconUrl = 'http://pgy-app-icons.qiniudn.com/image/view/app_icons/' + str(appIconKey)
#         appQRCodeUrl = 'http://qr.liantu.com/api.php?text=' + str(appInstallUrl)
#         appATOInstallUrl = 'itms-services://?action=download-manifest&url=https://ssl.pgyer.com/app/plist/' + str(appKey)

#         appInstallUrl = 'http://www.pgyer.com/' + str(appShortcutUrl)
#         appIconUrl = 'http://pgy-app-icons.qiniudn.com/image/view/app_icons/' + str(appIconKey)
#         appQRCodeUrl = 'http://qr.liantu.com/api.php?text=' + str(appInstallUrl)
#         appATOInstallUrl = 'itms-services://?action=download-manifest&url=https://ssl.pgyer.com/app/plist/' + str(appKey)

#         environsString = '<table width="700" border="0" cellpadding="0" cellspacing="0" align="center">'
#         environsString += '<tbody><tr>'
#         environsString += '     <td width="100%" style="" align="center" bgcolor="#f7f7f7">'
#         environsString += '         <table border="0" cellpadding="0" cellspacing="0" align="center" style="width:100%;">'
#         environsString += '             <tbody><tr>'
#         environsString += '                 <td valign="top" class="ecxleft" style="width:100%;">'
#         environsString += '                     <table border="0" cellpadding="15" cellspacing="0" width="100%" bgcolor="#F6F6F6">'
#         environsString += '                         <tbody><tr>'
#         environsString += '                             <td>'
#         environsString += '                                 <table border="0" cellpadding="0" cellspacing="0" width="100%">'
#         environsString += '                                      <tbody><tr>'
#         environsString += '                                         <td align="left" width="65">'
#         environsString += '                                             <img src="' + str(appIconUrl) + '" style="width:50px;height:50px;border-radius:10px;border-radius:10px;border:1px solid #ddd;">'
#         environsString += '                                         </td> '
#         environsString += '                                         <td align="left">'
#         environsString += '                                             <font color="#55555" size="3" style="font-size:16px;"><b>' + str(self.product_name) + '</b></font><br>'
#         environsString += '                                             <font color="#55555" size="2" style="font-size:14px;">版本 ' + str(appVersion) + ' (build ' + str(self.build_version) +  ')</font>'
#         environsString += '                                         </td>'
#         environsString += '                                         <td width="50">'
#         environsString += '                                             <font color="#55555" face="Trebuchet MS,Arial" size="3">'
#         environsString += '                                             <a href="' + str(appATOInstallUrl) + '" target="_blank" style="background-color:#56bc94;display:inline-block;font-size:14px;width:90px;height:32px;text-align:center;line-height:32px;color:white;text-decoration:none;font-weight:bold;">设备直接安装</a>  '
#         environsString += '                                             </font>'
#         environsString += '                                         </td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table>'

#         environsString += '<h3>构建包信息</h3><p>'
#         # environsString += '<p>ipa 包下载地址 : ' + '暂不提供' + '<p>'\
#         environsString += '<p>版本号 : ' + self.project_version + '<p>'
#         environsString += '<p>产品信息 :  PID:' + str(pid)+ '  CH:'+ str(ch)+ '  VER:' + str(ver)+ '  PT:' + str(pt) + ' <p>'
#         environsString += '<p>App名称 : ' + str(self.product_name) + '<p>'
#         environsString += '<p>BundleId : ' + str(appIdentifier) + '<p>'
#         environsString += '<p>App文件大小 : ' + str(self.fileSize(int(appFileSize))) + '<p>'
#         environsString += '<p>更新时间 : ' + str(appUpdated) + '<p>'
#         environsString += '<p>在线安装 : ' + 'http://www.pgyer.com/' + str(appShortcutUrl) + '   密码 : ' + self.installPassword + '<p>'
#         environsString += '<p>二维码安装 :'
#         environsString += '<img src="' + str(appQRCodeUrl) + '" style="width:100px;height:100px;border-radius:10px;border-radius:10px;border:1px solid #ddd;"><p>'

#         message = environsString
#         body = MIMEText(message, _subtype='html', _charset='utf-8')
#         msg.attach(body)
#         msg['To'] = mail_to
#         msg['from'] = mail_user
#         msg['subject'] = '[测试]'+ self.product_name + '_v' + appVersion + '_' + self.build_version

#         try:
#             s =  smtplib.SMTP_SSL(mail_host, mail_sslPort)
#             s.ehlo()
#             s.login(mail_user, mail_pwd)
#             s.sendmail(mail_user, mail_receiver, msg.as_string())
#             s.quit()
#             return G7ReqHandler.responseDataText(0, "打包成功", {})#self.responseWrite(0, "打包成功", {})
#         except Exception as e:
#             return G7ReqHandler.responseDataText(10004)


#     #############################################################
#     #请求参数字典
#     def httpClient(self, method="GET", domain="", path="", data=None, headers={}):

#         conn = HTTPConnection(domain)
#         # conn.set_debuglevel(1)
#         conn.request(method, path, body=data, headers=headers)
#         return conn.getresponse().read().decode('utf-8')

#     def uploadToPgyer(self):
#         params = {
#             'uKey': self.uKey,
#             '_api_key': self.api_key,
#             'file': self.ipaFile,
#             'publishRange': '2',
#             'password': self.installPassword
#         }

#         coded_params, boundary = self._encode_multipart(params)
#         headers = {'Content-Type': 'multipart/form-data; boundary={boundary}'.format(boundary=boundary)}
#         try:
#             responseObject = self.httpClient("POST",self.domain, self.urlPath, coded_params.encode('ISO-8859-1'), headers)
#             return self.handle_result(responseObject, self.mail_receiver)
#         except:
#             return G7ReqHandler.responseDataText(10003)

class G7ApplicationUploadReqHandler(G7APIReqHandler):

    def infoPlistFrom(self, buffer):
        info = {}
        try:
            info = plistlib.readPlistFromBytes(buffer)
        except:
            pass

        return info

    def g7CommonPlistFrom(self, buffer):
        info = {}

        try:
            info = plistlib.readPlistFromBytes(buffer)
        except:
            pass

        return info

    def dataFromFile(self, fileBytes):

        data = {
            "InfoPlist":{},
            # "G7CommonSettingPlist":{},
            "Icon":None,
        }

        # 获取info.plist
        info = {}

        # 获取G7CommonSetting.plist
        g7CommonSetting = {}

        # 获取图标
        icon = None

        zipBuffer = io.BytesIO()
        zipBuffer.write(fileBytes)

        zipBuffer.seek(0)
        zf = zipfile.ZipFile(zipBuffer, "r")
        for zipInfo in zf.infolist():

            # 获取名字和bundleid
            if ".app/Info.plist" in zipInfo.filename:
                info = self.infoPlistFrom(zf.read(zipInfo.filename))

            # 获取G7CommonSetting.plist
            # if ".app/G7CommonSetting.plist" in zipInfo.filename:
            #     g7CommonSetting = self.g7CommonPlistFrom(zf.read(zipInfo.filename))

            # 获取图标
            if ".app/AppIcon60x60" in zipInfo.filename:
                icon = ContentFile(zf.read(zipInfo.filename))
            # else:
            #     if ".app/AppIcon60x60@2x.png" in zipInfo.filename:
            #         icon = ContentFile(zf.read(zipInfo.filename))
            #     else:
            #         if ".app/AppIcon60x60.png" in zipInfo.filename:
            #             icon = ContentFile(zf.read(zipInfo.filename))
        zipBuffer.close()
        zf.close()

        if info and len(info) > 0:
            data["InfoPlist"] = info

        # if g7CommonSetting and len(g7CommonSetting) > 0:
        #     data["G7CommonSettingPlist"] = g7CommonSetting

        if icon:
            data["Icon"] = icon
        return data

    def intFilter(self, integerValue):

        returnedInteger = integerValue
        if type(integerValue) != type(0):
            try:
                returnedInteger = int(integerValue)
            except:
                returnedInteger = 0

        return integerValue



    @tornado.web.asynchronous
    @tornado.gen.coroutine
    def post(self):

        product_name = self.get_argument('product_name')
        uid = self.get_argument("uid")
        installPassword = self.get_argument("installPassword")
        # product_group_id = int(self.get_argument("product_group_id"))
        # pgyer_uKey = ""
        # pgyer_apiKey = ""
        currentG7User = None

        if uid == None or uid == "":
            # 请提交搞趣开发平台的用户ID
            return self.write({"message":"请提交搞趣开发平台的用户ID"})
        else:
            uidUsers = G7User.objects.filter(userid=uid)
            if len(uidUsers) == 0:
                # 提交的用户ID对应的用户不存在
                return self.write({"message":"提交的用户ID对应的用户不存在"})
            else:
                currentG7User = uidUsers[0]
            #     pgyer_uKey = currentG7User.pgyer_ukey
            #     pgyer_apiKey = currentG7User.pgyer_apiKey
            #     g7log("uid:{uid}, username:{username} ,pgyer_uKey:{pgyer_uKey}, pgyer_apiKey:{pgyer_apiKey}".format(uid=uid, username=currentG7User.username, pgyer_uKey=pgyer_uKey, pgyer_apiKey=pgyer_apiKey))
            #     if pgyer_uKey == None or pgyer_uKey == "" or pgyer_apiKey == None or pgyer_apiKey == "":
            #         # 请填写该用户所拥有的蒲公英uKey和apiKey
            #         return self.responseWrite(10008)

        fileBody = self.request.files["file"][0]["body"]
        if fileBody == None:
            return self.write("无法获取提交的IPA包文件")

        data = self.dataFromFile(fileBody)

        # Info.plist
        info = data["InfoPlist"]

        # G7CommonSetting.plist
        # g7CommonSetting = data["G7CommonSettingPlist"]

        # 获取BundleID 必须
        bundleID = ""
        if "CFBundleIdentifier" in list(info.keys()):
            bundleID = info["CFBundleIdentifier"]

        if bundleID == None or len(bundleID) == 0 or type(bundleID) != type(""):
            # 返回失败
            # ipa包备份失败, BundleID不合法!!!
            return self.write({"message":"ipa包备份失败, BundleID不合法!!!"})


        ######### 进入备份操作 ########

        # 获取G7CH G7PID G7VER G7PT, 若无，取默认值

        # 渠道
        TDCH = 0
        if "TDCH" in list(info.keys()):
            TDCH = self.intFilter(info["TDCH"])

        # 产品标识
        TDPID = 0
        if "TDPID" in list(info.keys()):
            TDPID = self.intFilter(info["TDPID"])

        # 内部版本
        TDVER = 0
        if "TDVER" in list(info.keys()):
            TDVER = self.intFilter(info["TDVER"])

        # 产品类型
        TDPT = 0
        if "TDPT" in list(info.keys()):
            TDPT = self.intFilter(info["TDPT"])

        # 获取应用名
        appName = product_name
        if "CFBundleDisplayName" in list(info.keys()) and (appName == None or appName == ""):
            appName = info["CFBundleDisplayName"]

        # 应用版本
        appVersion = "1.0"
        if "CFBundleShortVersionString" in list(info.keys()):
            appVersion = info["CFBundleShortVersionString"]

        localTime = time.localtime()
        timeNow = time.strftime("%Y%m%d%H%M%S", localTime)
        # g7log("timeNow:"+timeNow)
        # 编译版本
        buildVersion = "{timeNow}".format(timeNow=timeNow)  # 默认获取当前时间
        if "CFBundleVersion" in list(info.keys()):
            buildVersion = info["CFBundleVersion"]

        # 获取图标 若无, 取默认值
        icon = data["Icon"]

        # 判断当前产品中是否使用了接收到的Project_id
        projects = G7Project.objects.filter(project_id = TDPID)
        if len(projects) > 0:
            project = projects[0]
        else:
            project = G7Project(bundleID=bundleID, project_id=TDPID, project_type=0, icon=icon, name=appName, identifier=uuid.uuid4().hex)
            if icon:
                project.icon.save("application/icon/"+timeNow+".png", icon)
            else:
                project.icon = "application/icon/default_icon.png"
            project.save()

        try:
            # 创建新的包
            ipaFile = ContentFile(fileBody)
            ipaFileDir = time.strftime("%Y%m%d",localTime)
            ipaFileName = "{appName}_V{appVersion}_Build{build_version}_{timeNow}.ipa".format(appName=appName,
                appVersion=appVersion, build_version=buildVersion, timeNow=timeNow)
            dsymFile = ContentFile(fileBody)
            dsymFileDir = time.strftime("%Y%m%d",localTime)
            dsymFileName = "{appName}_V{appVersion}_Build{build_version}_{timeNow}-dSYM.zip".format(appName=appName,
                appVersion=appVersion, build_version=buildVersion, timeNow=timeNow)

            # g7log(ipaFileName)
            application = G7Application(bundleID=bundleID, project_id=TDPID, project_type=TDPT, name=appName, channel=TDCH, version=appVersion, build_version=buildVersion, inner_version=TDVER, identifier=uuid.uuid4().hex)
            if icon:
                application.icon.save("application/icon/"+timeNow+".png", icon)
            else:
                application.icon = "application/icon/default_icon.png"
            application.user = currentG7User
            application.save()
            application.file.save(ipaFileName, ipaFile)
            application.dsymFile.save(dsymFileName, dsymFile)

            project.applications.add(application)
            project.latest_build_version = application.build_version
            project.latest_version = application.version
            project.latest_inner_version = application.inner_version
            project.members.add(currentG7User)
            project.save()

            from apns import APNs, Frame, Payload
            pushProfiles = G7PushProfile.objects.filter(using=True)
            if len(pushProfiles) > 0 and pushProfiles[0].public_pem_file != None and pushProfiles[0].public_pem_file != "" and pushProfiles[0].private_pem_file != None and pushProfiles[0].private_pem_file != "":
                pushTokens = G7PushNotificatinToken.objects.all()
                for pushToken in pushTokens:
                    apns = APNs(use_sandbox=True, cert_file=pushProfiles[0].public_pem_file.path, key_file=pushProfiles[0].private_pem_file.path)
                    name = application.user.realname
                    if name == None or name == "":
                        name = application.user.username
                    payload = Payload(alert="😃 {username}:{appName} 打包成功".format(username=name, appName=application.name), sound="default", badge=1)
                    apns.gateway_server.send_notification(pushToken.token, payload)
            


        #     # buff = io.BufferedReader(ipaFile.file)
        #     # # 上传到蒲公英
        #     uploader = G7ApplicationPgyerUploader()
        # #    #蒲公英应用上传地址

        #     uploader.domain = 'www.pgyer.com'
        #     uploader.urlPath = "/apiv1/app/upload"
        #     uploader.uKey = pgyer_uKey
        #     uploader.api_key = pgyer_apiKey
        #     uploader.ipaFile = open(application.file.path, "rb")
        #     uploader.installPassword = installPassword
        #     uploader.product_name = appName
        #     uploader.currentG7User = currentG7User
        #     uploader.plist = {'G7PID':g7PID, 'G7VER':g7VER, 'G7CH':g7CH, 'G7PT':g7PT}

        #     users = list(G7User.objects.filter(email_vip=True))+list(project.members.all())

        #     try:
        #         if type(int(product_group_id)) == type(0) and int(product_group_id) > 0:
        #             users = list(G7User.objects.filter(email_vip=True))+list(project.members.all())+[user for user in G7User.objects.all() if len([group for group in list(user.groups.all()) if group.id == int(product_group_id)])>0]
        #     except:
        #         pass

        #     emails = [user.email for user in users]
        #     uploader.mail_receiver = list({}.fromkeys(emails).keys())
        #     uploader.build_version = buildVersion
        #     uploader.project_version = appVersion
        #     uploader.g7CommonSetting = g7CommonSetting
            return self.write({"message":"提交成功"})
        except:
            # ipa包备份失败, 储存资料失败!!!
            return self.write({"message":"ipa包备份失败!!!"})


class G7MyApplicationListReqHandler(G7ListReqHandler):
    '''
        获取我的应用包列表接口
    '''
    def fetchList(self):

        try:
            # 用户id
            
            userid = self.paramsJson.get("identifier")
            if userid == None or userid == "":
                if self.current_user != None:
                    userid = self.current_user.userid
            g7log(userid)
            pageIndex = 0
            if self.paramsJson.get("pageIndex") != None and self.paramsJson.get("pageIndex") != "":
                pageIndex = int(self.paramsJson.get("pageIndex"))
            allApplications = G7Application.objects.all()
            allApplications = [application.toJsonDict("http://"+self.request.host) for application in allApplications if application.user != None and userid == application.user.userid]
            isLastPage = self.isLastPage(allList=allApplications, pageIndex=pageIndex)
            applications = self.sourceList(allList=allApplications, pageIndex=pageIndex)
            applications.reverse()
            return self.responseWrite(0, "获取成功", data={"list":applications, "isLastPage":isLastPage})
        except:
            return self.responseWrite(1, "获取失败", data=[])

    def get(self):
        return self.fetchList()


    def post(self):
        return self.fetchList()



class G7ApplicationListReqHandler(G7ListReqHandler):
    '''
        获取应用包列表接口
    '''
    def fetchList(self):

        # try:
        identifier = self.paramsJson.get("identifier")
        if identifier == None or identifier == "":
            pageIndex = 0
            if self.paramsJson.get("pageIndex") != None:
                pageIndex = int(self.paramsJson.get("pageIndex"))
            applications = [application.toJsonDict("http://"+self.request.host) for application in G7Application.objects.all()]
            isLastPage = self.isLastPage(allList=applications, pageIndex=pageIndex)
            applications = self.sourceList(allList=applications, pageIndex=pageIndex)
            self.responseWrite(0, "获取成功", data={"list":applications, "isLastPage":isLastPage})
        else:
            # 根据projectID获取应用列表
            project = G7Project.objects.get(identifier=identifier)
            if project != None:
                pageIndex = 0
                if self.paramsJson.get("pageIndex") != None:
                    pageIndex = int(self.paramsJson.get("pageIndex"))
                applications = [application.toJsonDict("http://"+self.request.host) for application in G7Application.objects.all() if application.project_id==project.project_id]
                isLastPage = self.isLastPage(allList=applications, pageIndex=pageIndex)
                applications = self.sourceList(allList=applications, pageIndex=pageIndex)
                self.responseWrite(0, "获取成功", data={"list":applications, "isLastPage":isLastPage})
            else:
                self.responseWrite(1, "获取失败", data=[])
            
        # except:
        #     self.responseWrite(1, "获取失败", data=[])

    def get(self):
        return self.fetchList()


    def post(self):
        return self.fetchList()

class G7ApplicationDetailReqHandler(G7APIReqHandler):
    '''
        获取应用包详情
    '''
    def fetchDetail(self):

        try:
            # 应用包的identifier
            identifier = self.paramsJson.get("identifier")
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
