#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler



class G7PushTestReqHandler(G7WebReqHandler):
    '''
        首页
    '''
    def post(self):

        file_meta = self.request.files['p12file']
        for meta in file_metas:
            meta_body = meta['body']
            from apns import APNs, Frame, Payload
            pushProfiles = G7PushProfile.objects.filter(using=True)
            if len(pushProfiles) > 0 and pushProfiles[0].public_pem_file != None and pushProfiles[0].public_pem_file != "" and pushProfiles[0].private_pem_file != None and pushProfiles[0].private_pem_file != "":
                pushTokens = G7PushNotificatinToken.objects.all()
                for pushToken in pushTokens:
                    apns = APNs(use_sandbox=True, cert_file=pushProfiles[0].public_pem_file.path, key_file=pushProfiles[0].private_pem_file.path)
                    name = application.user.realname
                    if name == None or name == "":
                        name = application.user.username
                    custom= {"url":"http://marsplat.tk/pushNotification?appid={identifier}&tp=4".format(identifier=application.identifier)}
                    payload = Payload(alert="👉 {username}:{appName} 打包成功".format(username=name, appName=application.name), sound="default", badge=1, custom=custom)
                    apns.gateway_server.send_notification(pushToken.token, payload)

        return self.write({"code":0, "message":"success", "data":{}})

    def get(self):
        return self.render("push/push.html", title="推送工具")

