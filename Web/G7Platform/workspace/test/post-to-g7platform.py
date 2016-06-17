# -*- coding: utf-8 -*-
# author yuyang

import sys
import time
import os
import json
from os import path

reload(sys)
sys.setdefaultencoding('utf-8')

if sys.version_info.major == 3:
    from http.client import HTTPConnection
else:
    from httplib import HTTPConnection

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
            data.append('Content-Disposition: form-data; name="{k}"; filename="kangda.ipa"'.format(k=k))
            data.append('Content-Type: application/octet-stream\r\n')
            data.append(decoded_content)
        else:
            data.append('Content-Disposition: form-data; name="{k}"\r\n'.format(k=k))
            data.append(v if isinstance(v, str) else v.decode('utf-8'))
    data.append('--{boundary}--\r\n'.format(boundary=boundary))
    return '\r\n'.join(data), boundary

def httpClient(method="GET", domain="192.168.3.80", path="/api/1.0/application/upload", data=None, headers={}):

    conn = HTTPConnection(domain)
    # conn.set_debuglevel(1)
    conn.request(method, path, body=data, headers=headers)
    return conn.getresponse().read()

if __name__ == "__main__":

    if len(sys.argv) >= 6:

        #项目名称，用在 拼接 tomcat 文件地址
        project_name = ""
        if len(sys.argv) >= 2:
            project_name = str(sys.argv[1])

        #产品名称
        product_name = ""
        if len(sys.argv) >= 3:
             product_name = str(sys.argv[2])

        #项目构建版本
        project_version = ""
        if len(sys.argv) >= 4:
            project_version = str(sys.argv[3])

        #获取ipa地址
        ipa_file_path = ""
        if len(sys.argv) >= 5:
            ipa_file_path = str(sys.argv[4])

        #构建版本号
        build_version = ""
        if len(sys.argv) >= 6:
            build_version = str(sys.argv[5])

        #产品组ID
        product_group_id = ""
        if len(sys.argv) >= 7:
            product_group_id = str(sys.argv[6])

        plist_path = ""
        if len(sys.argv) >= 8: 
            plist_path=sys.argv[7]

        uid = "d87389f861f041889ae0042bb60f5a41"
        if len(sys.argv) >= 9: 
            uid=sys.argv[8]



        info_plist = {}
        try:
            from biplist import *
            info_plist = readPlist(plist_path)
        except:
            info_plist = {}
            
        # dSYM包地址
        dSYM_path = path.splitext(ipa_file_path)[0]+"-dSYM.zip"
        ipa_file = ""
        try:
            print("ipa_file_path:{ipa_file_path}".format(ipa_file_path=ipa_file_path))
            print(ipa_file)
            ipa_file = open(ipa_file_path, 'rb')
            
        except:
            ipa_file = ""

        dsym_file = ""
        try:
            print("dSYM_path:{dSYM_path}".format(dSYM_path=dSYM_path))
            print(dsym_file)
            dsym_file = open(dSYM_path, 'rb')

        except:
            dsym_file = ""

        params = {
            'file': ipa_file,
            "product_name":product_name.decode("ISO-8859-1"),
            "uid":uid,
            "installPassword":"gao7.com",
            "product_group_id":product_group_id,
            "dSYM_file": dsym_file,
            "TDPID":info_plist.get("TDPID"),
            "TDPT":info_plist.get("TDPT"),
            "TDCH":info_plist.get("TDCH"),
            "TDVER":info_plist.get("TDVER"),
        }
        

        print(sys.argv)
        print(params)
        
        # print(params)
        coded_params, boundary = _encode_multipart(params)
        headers = {'Content-Type': 'multipart/form-data; boundary={boundary}'.format(boundary=boundary), 'Connection': 'keep-alive'}
        print("正在提交到搞趣开发平台...")

        responseString = httpClient("POST", "marsplat.tk", "/api/1.0/application/upload", coded_params.encode('ISO-8859-1'), headers)
        try:
            responseObject = json.loads(responseString.decode("utf-8"))
            if "message" not in list(responseObject.keys()):
                print("提交失败")
            else:
                print(responseObject["message"])
        except:
            print("解析{responseString}失败".format(responseString=responseString))

        try:
            ipa_file.close()
            dsym_file.close()
        except:
            pass
    else:
        print("备份失败，传入脚本参数数量不匹配")
