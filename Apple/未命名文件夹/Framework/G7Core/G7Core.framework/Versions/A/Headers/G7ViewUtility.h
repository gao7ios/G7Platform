//
//  G7ViewUtility.h
//  G7Core
//
//  Created by WangMingfu on 15/1/20.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "G7SystemInfo.h"

#define G7_SCREEN_WIDTH						[[UIScreen mainScreen] bounds].size.width
#define G7_SCREEN_HEIGHT					[[UIScreen mainScreen] bounds].size.height
#define G7_STATUS_BAR_HEIGHT				(IOS7_OR_LATER ? 0 : 20)
#define G7_TABBAR_BAR_HEIGHT				49
#define G7_NAV_BAR_HEIGHT					(IOS7_OR_LATER ? 64 : 44)
#define G7_NAV_BAR_WITHOUTSTATUS_HEIGHT		44

#define G7_CONTENT_HEIGHT					(G7_SCREEN_HEIGHT - 64)
#define G7_CONTENT_HEIGHT_WITHOUT_TAB		(G7_SCREEN_HEIGHT - 64 - G7_TABBAR_BAR_HEIGHT)
#define G7_CONTENT_MAX_HEIGHT				(G7_SCREEN_HEIGHT - G7_STATUS_BAR_HEIGHT)

@interface G7ViewUtility : NSObject

///-----------------------------------------
/// @name view hierarchy
///-----------------------------------------

/**
 *	@brief	根据rootViewController获取最上层视图
 *
 *  @since  ver 1.0
 *
 */
+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController;

/**
 *	@brief	获取最上层的视图
 *
 *  @since  ver 1.0
 *
 */
+ (UIView *)topView;

/**
 *	@brief	获取最上层的视图控制器
 *			如果视图层次中，包含presentController，则递归获取最上层的presentController
 *
 *  @since  ver 1.0
 *
 */
+ (UIViewController *)topViewController;

/**
 *	@brief	获取最上层的视图导航控制器
 *			如果视图层次中，包含presentController，则递归获取最上层的presentController
 *
 *  @since  ver 1.0
 *
 */
+ (UINavigationController *)topNavigationController;

/**
 *	@brief	获取根视图
 *
 *  @since  ver 1.0
 *
 */
+ (UIWindow *)window;

/**
 *	@brief	获取根视图
 *
 *  @since  ver 1.0
 *
 */
+ (UIView *)rootView;

/**
 *	@brief	获取根视图控制器
 *
 *  @since  ver 1.0
 *
 */
+ (UIViewController *)rootViewController;


///-----------------------------------------
/// @name Orientation
///-----------------------------------------

+ (NSArray *)supportOrientations;
+ (BOOL)isSupportOrientation:(UIInterfaceOrientation)orientation;
+ (NSString *)stringWithOrientation:(UIInterfaceOrientation)orientation;
+ (BOOL)isSupportPortraitOrientation;
+ (BOOL)isSupportLandscapeOrientation;



@end
