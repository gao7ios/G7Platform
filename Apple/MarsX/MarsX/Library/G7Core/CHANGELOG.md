
# 1.1.2.20151223

**To update:**
*	1.重构日志模块


[关于日志]
	
	原所有INFO 替换成 G7LogInfo
	
	查看App Trace日志 	G7LogSetAppLoggingLevel(G7lcl_vTrace)
	查看App Info日志		G7LogSetAppLoggingLevel(G7lcl_vInfo)

	关闭App日志	G7LogSetAppLoggingLevel(G7lcl_vOff)
	
	指定设置模块日志	G7LogConfigureByName("Gao7ADK", G7lcl_vTrace);
	
	在每个App内，全局头文件设置
		#undef G7LogComponent
		#define G7LogComponent G7lcl_cApp


#---------------------------------------------------------------------------------------------------
#--------------------------------------------我   是   分   割   线-----------------------------------
#---------------------------------------------------------------------------------------------------

# 1.1.1.15121001_beta
2015.12.10
**To update:**
	* 

# 1.1.1.1512021051_beta

2015.12.02
**To update:**
	* 修改导航返回动画，使用系统自带效果，取消iOS7以下的动画效果，优化内存。
	* 修改IDFA


# 1.0.7.150624092401

2015.06.24

**To update:**
	* 添加bitcode选项，兼容iOS9

 

