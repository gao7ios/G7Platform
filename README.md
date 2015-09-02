# G7Platform使用方法

# 最新版本 v1.1 添加ipa包备份管理以及上传到蒲公英和对接jenkins

系统环境：Mac OSX 10.10， 阿里云(Red Hat 4.4.7-4)

1.简单介绍

	G7Platform是一个利用nginx转发操作系统中部署的基于python-tornado框架和
	python-django框架以及一个php的服务。
	其中的原理是在操作系统中开启4个tornado服务的端口，1个django服务的端口以及
	一个php服务的端口。
	4个tornado服务的端口是使用python开启tornado4个端口的服务，
	使用supervisor去管理这4个进程。
	1个django服务是django部署在python的uwsgi环境中，而nginx为uwsgi进行转发。
	1个php服务是php部署在fastcgi环境中，nginx通过fastcgi和php进行发送和接收消息。
	另外，G7Platform目前使用的数据库是Mysql-5.6。

2.目录说明

	以下的目录都不是绝对路径，而是相对于项目路径G7Platform

	0.0 根目录 － G7Platform: 项目路径，包含整个项目所有开发所需要的路径。

	1.0 项目主目录 - G7Platform/G7Platform: 项目主目录，包含所有主要业务的代码，
	其中包含core（核心工具）
	library（第三方维护的代码） 
	main(主业务) 
	profile(项目公共配置与设置) 
	sql(数据库sql脚本) 
	test(调试与测试)

	1.1 资源目录 - G7Platform/media: 当前由于部署在单机上，
	所以从客户端或者前端上传的资源都部署在
	这个目录下

	1.2 模块测试 - G7Platform/moduletest: 与服务无关的模块代码自测的目录

	1.3 静态资源 - G7Platform/static: 静态资源目录，
	如css js png

	1.4 模板 - G7Platform/template: 网页模板,json模板等资源

	1.5 工作区 - G7Platform/workspace: 工作区，主要存放
	log（日志），
	profile（部署配置），
	shell（便捷操作脚本）

	1.5.1 日志 - G7Platform/workspace/log: 日志，
	django（存放django运行中的日志报告） 
	supervisor(存放supervisor监听的tornado服务的运行日志报告)

	1.5.2 配置 - G7Platform/workspace/profile:
	nginx（关于nginx的配置，其中nginx/log是nginx服务的日志报告） 
	php（关于php部署配置） 
	supervisor（关于supervisor部署的配置） 
	uwsgi（django部署uwsgi环境的配置）

	1.5.3 脚本 - G7Platform/workspace/shell: 存放着G7Platform的操作脚本，
	其中G7PlatformInitial.command是自动在mac操作系统上部署环境，
	G7PlatformRestart.command是重新开启G7Platform服务，
	G7PlatformStart.command是开启G7Platform的服务，
	G7PlatformStop.command是关闭G7Platform的服务，
	G7PlatformShell.command是开启调试对话框的脚本，
	packages是存放需要安装的包，
	tools是在shell脚本运行中需要的其他脚本工具

3.初始化环境
	 
	 双击G7Platform/workspace/shell/G7PlatformInitial.command


4.运行服务
	
	双击G7Platform/workspace/shell/G7PlatformRestart.command

	测试模式下：
		默认可以访问: http://localhost:8884    和    http://localhost:8881/admin

	正式模式下：
		默认可以访问: http://localhost    和    http://localhost/admin

5.部署目的

	使用这样的部署目的是利用django框架对于admin开发的友好以及在django中建立数据模型的方便性上，
	我们使用django进行对网站后台的开发，并且由于后台的用户量大大少于前台的服务。所以，正是因为这一点，
	前台主要利用tornado进行开发，由于未来的许多项目可能出现BS和CS架构，利用tornado高并发以及对接口开
	发的友好程度。在前台以及整个G7Platform主要利用tornado去操作。由于团队中技术的多样性以及在一些特
	殊的需求上，我们加入了php的环境。

6.URL说明:
	
	一些基本的url配置是在nginx的配置是固定的

	当URL的根目录下第一个目录是admin，那么就会访问django服务，类似http://domain.com/admin/
	和http://domain.com/admin/login，
	当URL的根目录下第一个目录是static，那么就会访问G7Platform/static中的文件
	当URL的根目录下第一个目录是media，那么就会访问G7Platform/media中的文件
	当URL中以.php为结尾，就会访问php的服务
	其他情况下默认访问tornado提供的服务

7.如何开发

	在G7Platform/main/site目录中创建一个新的脚本（如：BMIndexReqHandlers.py）并且新建一个类
	(BMIndexReqHandler继承G7Platform/main/site/Common的G7ReqHandlers模块中的G7ReqHandler)，
	在G7Platform/profile/settings/web/BMURLs.py中的urlList按照格式加入一个你需要新建的url，
	并且跟之前建立的BMIndexReqHandler类关联，然后就可以根据路径去访问你建立的接口了。

8.代码调试

	# v1.0新增

	双击G7Platform/workspace/shell/G7PlatformShell.command文件，将会打开一个python-shell
	对话框，该对话框中已经加载了项目环境配置，另外如果需要帮助请用命令行添加脚本参数:
	G7Platform/workspace/shell/G7PlatformShell.command help
	将会出现其他命令帮助，
	其中一个例子：
	G7Platform/workspace/shell/G7PlatformShell.command createsuperuser
	就是为后台创建一个新用户

	注：该对话框环境主要是后台和数据库相关工具。开发中主要利用它来进行对数据的操作以及实时调试写好的代码。





