//
//  G7SystemInfo.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-11.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Singleton.h"

#pragma mark -

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS9_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )
#define IOS8_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define IOS8_OR_EARLIER		( !IOS9_OR_LATER )
#define IOS7_OR_EARLIER		( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER		( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER		( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER		( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER		( !IOS4_OR_LATER )

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#define IS_IPHONE (	!IS_IPAD )

#define IS_IPHONE4 (IS_SCREEN_35_INCH)
#define IS_IPHONE5 (IS_SCREEN_4_INCH)
#define IS_IPHONE6 (IS_SCREEN_47_INCH)
#define IS_IPHONE6_PLUS (IS_SCREEN_55_INCH)

#define IS_SCREEN_55_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define IS_SCREEN_47_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH (CGSizeEqualToSize(CGSizeMake(640, 960), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size))

#define APP_STATUSBAR_ORIENTATION ([[UIApplication sharedApplication] statusBarOrientation])
#define IS_PORTRAIT   UIInterfaceOrientationIsPortrait(APP_STATUSBAR_ORIENTATION)
#define IS_LANDSCAPE    UIInterfaceOrientationIsLandscape(APP_STATUSBAR_ORIENTATION)


#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS9_OR_LATER		(NO)
#define IOS8_OR_LATER		(NO)
#define IOS7_OR_LATER		(NO)
#define IOS6_OR_LATER		(NO)
#define IOS5_OR_LATER		(NO)
#define IOS4_OR_LATER		(NO)
#define IOS3_OR_LATER		(NO)

#define IS_SCREEN_4_INCH	(NO)
#define IS_SCREEN_35_INCH	(NO)
#define IS_SCREEN_47_INCH	(NO)
#define IS_SCREEN_55_INCH	(NO)

#define IS_IPAD (NO)
#define IS_IPOD (NO)
#define IS_IPHONE (NO)

#define APP_STATUSBAR_ORIENTATION (0)
#define IS_PORTRAIT   (NO)
#define IS_LANDSCAPE  (NO)

#define IS_IPHONE4 (NO)
#define IS_IPHONE5 (NO)
#define IS_IPHONE6 (NO)
#define IS_IPHONE6_PLUS (NO)


#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

@interface G7SystemInfo : NSObject

///系统版本号
+ (NSString *)OSVersion;
///应用版本号
+ (NSString *)appVersion;
///应用唯一标识
+ (NSString *)appIdentifier;
///设备型号
+ (NSString *)deviceModel;
+ (int)deviceModelStatus;
///设备唯一标识
+ (NSString *)deviceUUID;
+ (NSString *)openUDID;
///浏览器UserAgent
+ (NSString *)webUserAgent;
///mac地址
+ (NSString *)MACAddress;
///广告ID
+ (NSString *)adtID;
//设备identifierForVendor
+ (NSString *)idfvString;
///设备名
+ (NSString *)machineName;
///系统语言环境
+ (NSString *)currentLanguage;
///系统网络状态
+ (int)currentNetworkStatus;
///获取路由信息
+ (NSString *)fetchSSIDInfo;
//获取屏幕分辨率
+ (NSString *)screenResolution;
//获取设备内核启动时间
+ (NSString *)rtime;
///判断设备是否越狱
+ (BOOL)isJailBroken		NS_AVAILABLE_IOS(4_0);
+ (NSString *)jailBreaker	NS_AVAILABLE_IOS(4_0);
///设备序列号
+ (NSString *)serialNumber;
///G7UDID
+ (NSString *)g7udid;

/**
 * 系统内部版本 (版本号*100)
 * 7.1.1 = 711
 *
 * @author WangMingfu
 * @date 2015-06-04 16:06:58
 *
 * @return
 */
+ (int)OSIntVersion;


///判断设备是否iPhone,iPod,iTouch
+ (BOOL)isDevicePhone;
+ (BOOL)isDevicePad;
+ (BOOL)requiresPhoneOS;
//+ (BOOL)isPhone;
+ (BOOL)isPhone35;
+ (BOOL)isPhoneRetina35;
+ (BOOL)isPhoneRetina4;
+ (BOOL)isPad;
+ (BOOL)isPadRetina;
+ (BOOL)isScreenSize:(CGSize)size;

@end
