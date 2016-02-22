//
//  G7Common.h
//  G7Universal
//
//  Created by wang mingfu on 12-8-16.
//  Copyright (c) 2012年 tandy. All rights reserved.
//

#import <G7Core/G7.h>


//#define kG7Uno @"kG7Uno" // 用户编号
//#define kG7UserId @"kG7UserId"  //用户编号
//#define kG7DevicToken @"kG7DeviceToken" // 用户devictToken
//#define kG7BBSLoginScript @"kG7BBSLoginScript" //论坛登录脚本
//#define kG7LoginKey @"kG7LoginKey" // 用户登录成功标识
//#define kG7LoginType @"kG7LoginType" //登录类型   0 搞趣登录 1 微薄登录
//#define kG7UserNickName @"kG7UserNickName"  //用户昵称
//#define kG7UserSign @"kG7UserSign"   //用户签名
//#define kG7ProfileImageUrl @"kG7ProfileImageUrl" //用户头像下载地址
//#define kG7UserSex @"kG7UserSex"   //用户性别
//#define kG7UserProfileUrl @"kG7UserProfileUrl" //用户weibo地址
//#define kG7ProfileImage @"kG7ProfileImage"
//#define kG7UserAgent @"kG7UserAgent" ///ver=8 新增useragent add by wmf

//登录使用key 配置加密使用key
#define kEncryptorAesKey @"bjg0bVVja3pGQ2w2eXMxQTZXSmk3UTFwaTVpVmxnVjc="
#define kEncryptorBlockSize 8

#undef	DEF_COMMON_PROPERTY
#define DEF_COMMON_PROPERTY(__property) \
    + (NSString *)__property { \
            NSString *__temp = [[NSUserDefaults standardUserDefaults] valueForKey:G7_USERINFO_##__property];  \
            if (__temp == nil || [@"" isEqualToString:__temp]) { \
                return @""; \
            } \
            return __temp; \
        } \
    - (void)set##__property:(NSString *)__value { \
            if (__value == nil || [@"" isEqualToString:__value]) { \
                return; \
            } \
            [[NSUserDefaults standardUserDefaults] setValue:__value forKey:G7_USERINFO_##__property]; \
        } \
    - (NSString *)__property { \
            return [[self class] __property]; \
        }


/*!
 @class G7Common
 
 @abstract
 该类用于存放程序中用到的公共常量、变量
 
 @discussion
 1.所有`UA_`开头的常量，都用于UserAgent1参数定义。
 2.所有`G7_USERINFO_`开头的常量，都用于定义保存在`NSUserDefaults`中变量的Key值。
 3.如果需要在`NSUserDefaults`中添加共享的变量 `PARAM`，则需要按以下步骤实现：
    a.定义常量 `G7_USERINFO_PARAM`
    b.声明属性 `PARAM`
    c.在.m文件中，重写属性的`get`、`set`访问方法，`DEF_COMMON_PROPERTY(__property)`
 
 */
@interface G7Common : NSObject


@property (nonatomic, copy) NSString *UNO;
@property (nonatomic, copy) NSString *LOGINKEY;
@property (nonatomic, copy) NSString *LOGINMODE;
@property (nonatomic, copy) NSString *DEVICETOKEN;
@property (nonatomic, copy) NSString *USERID;
@property (nonatomic, copy) NSString *USERNICKNAME;
@property (nonatomic, copy) NSString *USERSIGN;
@property (nonatomic, copy) NSString *USERPROFILEIMAGE;
@property (nonatomic, copy) NSString *USERSEX;
@property (nonatomic, copy) NSString *USERPROFILEURL;
@property (nonatomic, copy) NSString *USERTOKEN;
@property (nonatomic, copy) NSString *USERBIRTHDAY;

@property (nonatomic, copy) NSString *USEREMAIL;		//用户邮箱 add by wmf 20141211
@property (nonatomic, copy) NSString *USERNAME;			//用户名 add by wmf 20141211
@property (nonatomic, copy) NSString *USERIDSIGNATURE;	//用户ID签名 add by wmf 20141211
@property (nonatomic, copy) NSString *BBSID;			//Bbs ID add by wmf 20141211
@property (nonatomic, copy) NSString *BBSIDSIGNATURE;	//BbsID签名 ID add by wmf 20141211
@property (nonatomic, copy) NSString *ITUNESID;			//itunes账号唯一id add by wmf 20150210
@property (nonatomic, copy) NSString *APPLANG;			//应用版本号 add by wmf 20150604

@property (nonatomic, assign) int ts;  //服务端校验码，add by wmf 20150604

@property (nonatomic, assign) BOOL ISUSERLOGIN;

@property (nonatomic, assign) BOOL enableIDFA;

- (NSString *)userAgent1;

+ (NSString *)userAgent1;

/**
 * userAgent精简版本
 *
 * @return userAgent
 */
- (NSString *)userAgent2;
+ (NSString *)userAgent2;

/**
 * 三部使用的UserAgent
 *
 * @return userAgent
 */
- (NSString *)userAgent3;
+ (NSString *)userAgent3;


//注销登录
- (void)userLoginOut;
+ (void)userLoginOut;

//过期数据处理
+ (void)deprecateUpdatedForVersion:(int)ver;

+ (int)currentNetworkStatus;

/// 更新服务端校验码
- (void)refreshTS;

AS_SINGLETON(G7Common)

@end

//******************************
//      UserAgent1 参数定义
//
//  modify log
//
//  2012/07/13 添加loginkey nickName loginMode osver
//  2013.07.17 添加web ua
//
//******************************


//system info

//---------- 系统基本信息 ----------//

//设备唯一编号UDID等
extern NSString *const UA_SID;  //Stop on 2013-01-21

//设备类型
//    0，未知iOS设备
//    1，iPhone
//    2，iPod
//    3，iPad
//    50，未知的Android设备
//    51，Android（未启用）
extern NSString *const UA_DT;

//设备类型
//dt<50:
//    iPhone1,1
//    iPhone1,2
//    iPhone2,1
//dt>=50:
//    HTC Aria A6380
extern NSString *const UA_MTYPE;

//用户当前语言环境
//  n, 英文
//  zh-Hans，简体中文
//  zh-Hant，繁体中文
extern NSString *const UA_LANG;

//上网方式，int
//  不填，未知
//  0,未知
//  1，Wifi
//  2，非wifi上网方式（3G/EDGE）
//  3，3G(未实现)
//  4，EDGE（未实现）
extern NSString *const UA_NET;

//mac地址
extern NSString *const UA_MAC;

//固件版本
//  dt<50:
//      3.1.3
//      4.0
//      4.1
extern NSString *const UA_OSVER;

//广告跟踪id  iOS6.0 后引入
extern NSString *const UA_ADTID;

//第三方替代sid解决方案
extern NSString *const UA_OPENID;

//路由id
extern NSString *const UA_BSSID;

//屏幕分辨率
extern NSString *const UA_SCREEN;

//系统内核启动时间
extern NSString *const UA_RTIME;

//是否越狱
//  0，未知
//  1，没越狱
//  2，已越狱
extern NSString *const UA_JBFLAG;

//设备token
extern NSString *const UA_DEVICETOKEN;

extern NSString *const UA_IDFV;  //add on 20141229

//g7 info

//---------- 程序自带信息 ----------//
//产品编号，int
extern NSString *const UA_PID;

//产品系列－仅用于推送获取证书，int
extern NSString *const UA_PT;

//用户下载本产品的渠道编号  不填,默认自己的渠道
extern NSString *const UA_CH;

//程序版本号，用数值表示  若非数值，则以0计算
extern NSString *const UA_VER;

//webview useragent
extern NSString *const UA_WEBUA;

//---------- 用户信息 ----------//

//各种编号 如 pushed、deviceid、userid 集合体,格式如下 xxxx,xxxxx,xxxxx
extern NSString *const UA_UNO;

//userid
extern NSString *const UA_USERID;

//用户guid  与用户id类似，只是由guid生成
extern NSString *const UA_LOGINKEY;

//用户昵称
extern NSString *const UA_NICKNAME;

//登陆方式  1、新浪微博 2、QQ
extern NSString *const UA_LOGINMODE;       //option

//是否绑定论坛
extern NSString *const UA_ISBINDBBS;  //option

//登陆后token 每次登陆都不一样的
extern NSString *const UA_USERTOKEN;  //option

extern NSString *const UA_USERIDSIGNATURE;
extern NSString *const UA_BBSID;
extern NSString *const UA_BBSIDSIGNATURE;

extern NSString *const UA_SERIAL;

extern NSString *const UA_AID;

//接口版本
extern NSString *const UA_PV;
extern NSString *const UA_SDKVER;

//******************************
//      userinfo key定义
//******************************

//
// 用户编号
extern NSString *const G7_USERINFO_UNO;
// 用户id
extern NSString *const G7_USERINFO_USERID;
// 设备token
extern NSString *const G7_USERINFO_DEVICETOKEN;
// 用户guid
extern NSString *const G7_USERINFO_LOGINKEY;
// 登陆方式
extern NSString *const G7_USERINFO_LOGINMODE;
// 用户昵称
extern NSString *const G7_USERINFO_USERNICKNAME;
// 用户签名
extern NSString *const G7_USERINFO_USERSIGN;
// 用户头像下载地址
extern NSString *const G7_USERINFO_USERPROFILEIMAGE;
// 用户性别
extern NSString *const G7_USERINFO_USERSEX;
// 用户主页
extern NSString *const G7_USERINFO_USERPROFILEURL;
// 登陆后token
extern NSString *const G7_USERINFO_USERTOKEN;
// 用户生日
extern NSString *const G7_USERINFO_USERBIRTHDAY;

extern NSString *const G7_USERINFO_USEREMAIL;

extern NSString *const G7_USERINFO_USERNAME;

extern NSString *const G7_USERINFO_USERIDSIGNATURE;

extern NSString *const G7_USERINFO_BBSID;

extern NSString *const G7_USERINFO_BBSIDSIGNATURE;
// itunesid
extern NSString *const G7_USERINFO_ITUNESID;

// applang
extern NSString *const G7_USERINFO_APPLANG;

