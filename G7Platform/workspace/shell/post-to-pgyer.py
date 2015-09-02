# coding=utf-8



"""
    * thanks answer.huang  Blog:  answerhuang.duapp.com
    * User:  yumous
    * Email: yumous@hotmail.com
    * Date:  15/0425
    * Time:  18:00
    * Blog:  
"""

#python /Users/jenkins/.jenkins/jobs/post-to-pgyer.py Gao7Wallpaper '壁纸HD' Gao7Wallpaper_v1.6_build150429140140 /Users/jenkins/.jenkins/jobs/Gao7Wallpaper/workspace/ipa/Gao7Wallpaper_v1.6_build150429140140.ipa 150429140140

import sys
import time
import urllib2
import time
import json
import mimetypes
import os
import smtplib
from email.MIMEText import MIMEText
from email.MIMEMultipart import MIMEMultipart
from hurry.filesize import size

import json

reload(sys)
sys.setdefaultencoding("utf-8")

#参数获取
# argv[0] 脚本文件路径 
# argv[1] 项目名      壁纸HD
# argv[2] 产品名称    Gao7Wallpaper
# argv[3] 项目构建版本 Gao7Wallpaper_v1.6_build20150501123211
# argv[4] ipad地址    
# argv[5] 构建版本号   20150501123211

# 运行时环境变量字典
environsDict = os.environ
#项目名称，用在 拼接 tomcat 文件地址
project_name = str(sys.argv[1])
#产品名称
product_name = str(sys.argv[2])
#项目构建版本
project_version = str(sys.argv[3])
#获取ipa地址
ipa_file_path = str(sys.argv[4])
#构建版本号
build_version = str(sys.argv[5])
#邮件接受者
mail_receiver_type = int(sys.argv[6])

    # ,'663971596@qq.com','loolingc@gmail.com','358104996@qq.com','pluwen@gmail.com','245838185@qq.com','lengyao@foxmail.com','542276632@qq.com','shikaimin@qq.com'

mail_receiver_vip = {'Admin' : 'yumous@hotmail.com', '陈文'  : 'pluwen@gmail.com', 
                     '陈冷耀' : 'lengyao@foxmail.com', '王明福':'2851728838@qq.com',
                     '林悯明' : '2851728845@qq.com', '左榕艳' : '245838185@qq.com' ,
                      '郭岚岚' : '2851728857@qq.com', '朱如钢' : '2851728796@qq.com'}

mail_receiver_wallpaper = {'林云枫' : '663971596@qq.com', '黄文彬' : '2851728848@qq.com' , '彭亮亮' : '2851728846@qq.com', 
                            '涂勇彬' : '2851728839@qq.com', '黄兰' : '2851729173@qq.com' , '刘雷' : '2851728844@qq.com', 
                            '施威' : '2851728860@qq.com'}

mail_receiver_tools = {'卢志贤' : '2851728842@qq.com', '吕廷元' : '2851728843@qq.com',
                       '彭亮亮' : '2851728846@qq.com', '余洋' : '2851728841@qq.com','陈璐铃' : '2851728787@qq.com'}
                      
mail_receiver_Gao7 = { '王明福':'2851728838@qq.com','曾伟君' : '2851728800@qq.com','林超' : '234836887@qq.com',
                         '凯敏' : 'shikaimin@qq.com', '陈侃' : '2851728802@qq.com', '董宇' : '2851728998@qq.com',
                         '黄智莺' : '2851728876@qq.com'}

mail_receiver_WeiXin = { '王明福':'2851728838@qq.com', '陈燕华' : '2851728804@qq.com', '郑宇全': '2851728797@qq.com', 
                        '张冰烽' : '2851728817@qq.com', '陈聪慧': '2851728972@qq.com', '林倩依' : '2851728974@qq.com',
                        '黄振达' : '2851728809@qq.com'}

mail_receiver = list(mail_receiver_vip.values())

if mail_receiver_type == 1:  # 壁纸
    mail_receiver += list(mail_receiver_wallpaper.values());
elif mail_receiver_type == 2:  #助手
    mail_receiver += list(mail_receiver_tools.values());
elif mail_receiver_type == 3:  #搞趣网
    mail_receiver = list(mail_receiver_Gao7.values());
elif mail_receiver_type == 4:  #微信精选
    mail_receiver = list(mail_receiver_WeiXin.values());

#蒲公英应用上传地址
url = 'http://www.pgyer.com/apiv1/app/upload'
#蒲公英提供的 用户Key
uKey = '10bfec8a0ad76ec4513d0a1a911c0070'
#上传文件的文件名（这个可随便取，但一定要以 ipa 结尾）
file_name = project_name + '.ipa'
#蒲公英提供的 API Key
_api_key = '7aa43e0355b94a671f5ae11cecea6972'
#安装应用时需要输入的密码，这个可不填
installPassword = 'gao7.com'

#ipa 文件在 tomcat 服务器上的地址
# ipa_file_tomcat_http_url = 'http://localhost/' + project_name + '/static/' + jenkins_build_number + '/' + jenkins_build_number + '.ipa'

#请求字典编码
def _encode_multipart(params_dict):
    boundary = '----------%s' % hex(int(time.time() * 1000))
    data = []
    for k, v in params_dict.items():
        data.append('--%s' % boundary)
        if hasattr(v, 'read'):
            filename = getattr(v, 'name', '')
            content = v.read()
            decoded_content = content.decode('ISO-8859-1')
            data.append('Content-Disposition: form-data; name="%s"; filename="kangda.ipa"' % k)
            data.append('Content-Type: application/octet-stream\r\n')
            data.append(decoded_content)
        else:
            data.append('Content-Disposition: form-data; name="%s"\r\n' % k)
            data.append(v if isinstance(v, str) else v.decode('utf-8'))
    data.append('--%s--\r\n' % boundary)
    return '\r\n'.join(data), boundary


#处理 蒲公英 上传结果
def handle_resule(result):
    json_result = json.loads(result)
    if json_result['code'] is 0:
        send_Email(json_result)

#发送邮件
def send_Email(json_result):

    appName = json_result['data']['appName']
    appKey = json_result['data']['appKey']
    appVersion = json_result['data']['appVersion']
    appBuildVersion = json_result['data']['appBuildVersion']
    appShortcutUrl = json_result['data']['appShortcutUrl']
    appIconKey = json_result['data']['appIcon']
    appFileSize  = json_result['data']['appFileSize']
    appIdentifier = json_result['data']['appIdentifier']
    appUpdated = json_result['data']['appUpdated']
    appCreated = json_result['data']['appCreated']



    #根据不同邮箱配置 host，user，和pwd
    mail_host = 'smtp.vip.163.com'
    mail_user = 'yumous@vip.163.com'
    mail_username = 'yumous'
    mail_pwd = 'JIM@19871017'
    mail_to = ','.join(mail_receiver)
    mail_smtpPort = '25'
    mail_sslPort  = '465'

    msg = MIMEMultipart()

    appInstallUrl = 'http://www.pgyer.com/' + str(appShortcutUrl)
    appIconUrl = 'http://pgy-app-icons.qiniudn.com/image/view/app_icons/' + str(appIconKey)
    appQRCodeUrl = 'http://qr.liantu.com/api.php?text=' + str(appInstallUrl)
    appATOInstallUrl = 'itms-services://?action=download-manifest&url=https://ssl.pgyer.com/app/plist/' + str(appKey)

    environsString = '<table width="700" border="0" cellpadding="0" cellspacing="0" align="center">'
    environsString += '<tbody><tr>'
    environsString += '     <td width="100%" style="" align="center" bgcolor="#f7f7f7">'
    environsString += '         <table border="0" cellpadding="0" cellspacing="0" align="center" style="width:100%;">'
    environsString += '             <tbody><tr>'
    environsString += '                 <td valign="top" class="ecxleft" style="width:100%;">'
    environsString += '                     <table border="0" cellpadding="15" cellspacing="0" width="100%" bgcolor="#F6F6F6">'
    environsString += '                         <tbody><tr>'
    environsString += '                             <td>'
    environsString += '                                 <table border="0" cellpadding="0" cellspacing="0" width="100%">'
    environsString += '                                      <tbody><tr>'
    environsString += '                                         <td align="left" width="65">'
    environsString += '                                             <img src="' + str(appIconUrl) + '" style="width:50px;height:50px;border-radius:10px;border-radius:10px;border:1px solid #ddd;">'
    environsString += '                                         </td> '
    environsString += '                                         <td align="left">'
    environsString += '                                             <font color="#55555" size="3" style="font-size:16px;"><b>' + str(product_name) + '</b></font><br>'
    environsString += '                                             <font color="#55555" size="2" style="font-size:14px;">版本 ' + str(appVersion) + ' (build ' + str(build_version) +  ')</font>'
    environsString += '                                         </td>'
    environsString += '                                         <td width="50">'
    environsString += '                                             <font color="#55555" face="Trebuchet MS,Arial" size="3">'
    environsString += '                                             <a href="' + str(appATOInstallUrl) + '" target="_blank" style="background-color:#56bc94;display:inline-block;font-size:14px;width:90px;height:32px;text-align:center;line-height:32px;color:white;text-decoration:none;font-weight:bold;">设备直接安装</a>  '
    environsString += '                                             </font>'
    environsString += '                                         </td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table>'

    environsString += '<h3>构建包信息</h3><p>'
    # environsString += '<p>ipa 包下载地址 : ' + '暂不提供' + '<p>'
    environsString += '<p>构建版本号 : ' + project_version + '<p>'
    environsString += '<p>App名称 : ' + str(product_name) + '<p>'
    environsString += '<p>BundleId : ' + str(appIdentifier) + '<p>'
    environsString += '<p>App文件大小 : ' + str(size(int(appFileSize))) + '<p>'
    environsString += '<p>版本号 : ' + str(appVersion) + '<p>'
    environsString += '<p>上传时间 : ' + str(appCreated) + '<p>'
    environsString += '<p>更新时间 : ' + str(appUpdated) + '<p>'
    environsString += '<p>在线安装 : ' + 'http://www.pgyer.com/' + str(appShortcutUrl) + '   密码 : ' + installPassword + '<p>'
    environsString += '<p>二维码安装 :<p>'
    environsString += '<p><img src="' + str(appQRCodeUrl) + '" style="width:100px;height:100px;border-radius:10px;border-radius:10px;border:1px solid #ddd;"><p>'
    

    message = environsString
    body = MIMEText(message, _subtype='html', _charset='utf-8')
    msg.attach(body)
    msg['To'] = mail_to
    msg['from'] = mail_user
    msg['subject'] = '[测试]'+ product_name + '_v' + appVersion + '_' + build_version
    
    try:
        s =  smtplib.SMTP_SSL(mail_host, mail_sslPort)
        s.ehlo()
        s.login(mail_username, mail_pwd)
        s.sendmail(mail_user, mail_receiver, msg.as_string())
        s.quit()
        print 'successfully sent the mail'
    except Exception, e:
        print "failed to send mail"
        print e

#############################################################
#请求参数字典
params = {
    'uKey': uKey,
    '_api_key': _api_key,
    'file': open(ipa_file_path, 'rb'),
    'publishRange': '2',
    'password': installPassword

}

coded_params, boundary = _encode_multipart(params)
req = urllib2.Request(url, coded_params.encode('ISO-8859-1'))
req.add_header('Content-Type', 'multipart/form-data; boundary=%s' % boundary)
try:

    resp = urllib2.urlopen(req)
    body = resp.read().decode('utf-8')
    handle_resule(body)

except urllib2.HTTPError as e:
    print(e.fp.read())







