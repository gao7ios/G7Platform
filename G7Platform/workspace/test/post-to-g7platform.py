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

def httpClient(method="GET", domain="127.0.0.1", path="/api/1.0/application/upload", data=None, headers={}):

    conn = HTTPConnection(domain)
    # conn.set_debuglevel(1)
    conn.request(method, path, body=data, headers=headers)
    return conn.getresponse().read()

if __name__ == "__main__":

    if len(sys.argv) >= 6:

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

        #产品组ID
        product_group_id = str(sys.argv[6])

#        ipa_file_path = "test.ipa"
#python post-to-g7platform.py test 测试 10 ./test.ipa 10293 11
        # dSYM包地址
        dSYM_path = path.splitext(ipa_file_path)[0]+"-dSYM.zip"

        params = {
            'file': open(ipa_file_path, 'rb'),
            "product_name":product_name.decode("ISO-8859-1"),
            "uid":"7829b10a2ccc4cbd888d52fdf90bfde8",
            "installPassword":"gao7.com",
            "product_group_id":product_group_id,
            "dSYM_file": open(dSYM_path, 'rb'),
        }
        # print(params)
        coded_params, boundary = _encode_multipart(params)
        headers = {'Content-Type': 'multipart/form-data; boundary={boundary}'.format(boundary=boundary), 'Connection': 'keep-alive'}
        print("正在提交到搞趣开发平台...")
        responseString = httpClient("POST","192.168.205.120", "/api/1.0/application/upload", coded_params.encode('ISO-8859-1'), headers)
        try:
            responseObject = json.loads(responseString.decode("utf-8"))
            if "message" not in list(responseObject.keys()):
                print("提交失败")
            else:
                print(responseObject["message"])
        except:
            print("解析{responseString}失败".format(responseString=responseString))
    else:
        print("备份失败，传入脚本参数数量不匹配")
