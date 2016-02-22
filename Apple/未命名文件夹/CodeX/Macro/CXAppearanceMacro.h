//
//  AppearanceMacro.h
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#ifndef CodeX_AppearanceMacro_h
#define CodeX_AppearanceMacro_h

// devices

#define IS_IPHONE4 ([UIScreen mainScreen].bounds.size.height == 480)
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size):NO)
#define IS_IPHONE6 ([UIScreen mainScreen].bounds.size.height == 667)
#define IS_IPHONE6_PLUS ([UIScreen mainScreen].bounds.size.height == 736)

// ios

#define IS_IOS7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

#define IS_IOS6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)

#define IS_IOS8_OR_LATER    ([[UIDevice currentDevice].systemVersion compare:@"8.0"] != NSOrderedAscending)

#define IS_IOS8_0_OR_LATER  ([[UIDevice currentDevice].systemVersion compare:@"8.0"] != NSOrderedAscending)

#define IS_IOS7_1_OR_LATER  ([[UIDevice currentDevice].systemVersion compare:@"7.1"] != NSOrderedAscending)

// sizes

#define CXScreenWidth      [UIScreen mainScreen].bounds.size.width
#define CXScreenHeight     [UIScreen mainScreen].bounds.size.height

#define CXStatusBarHeight 20.0f
#define CXNavBarHeight 64.0f
#define CXNavBarHeightNoStatusBar (CXNavBarHeight-CXStatusBarHeight)
#define CXToolBarHeight 40.0f
#define CXMarginLeftRight 20.0f

// colors

#define CXTableViewCellBackgroundColor [CXTools colorFromString:@"f7f7f7"]
#define CXTableViewBackgroundColor [CXTools colorFromString:@"f2f2f2"]
#define CXTableViewSeperatorColor [CXTools colorFromString:@"e5e5e5"]
#define CXNavBarBackgroundColor [CXTools colorFromString:@"4A525FFF"]

#define CXDarkColor [CXTools colorFromString:@"3c414c"]
#define CXLightColor [CXTools colorFromString:@"b4b4b4"]
#define CXHighlightColor [CXTools colorFromString:@"0079ff"]

// fonts

#define CXTableViewCellTextFont [UIFont fontWithName:@"helvetica-bold" size:16.0]

#endif
