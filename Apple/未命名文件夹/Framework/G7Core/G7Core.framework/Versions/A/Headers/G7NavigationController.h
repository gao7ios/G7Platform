//
//  G7NavigationController.h
//  G7Core
//
//  Created by WangMingfu on 15/1/28.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7.h"

/**
 * <p>G7NavigationController 继承自UINavigationController，
 *    实现对原生UINavigationController功能的扩展。</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7NavigationController : UINavigationController

/// 设置视图的背景图片
@property (strong, readwrite, nonatomic) UIImage *backgroundImage;

/// 是否取消iOS7系统自带的边缘退出手势
@property (assign, readwrite, nonatomic) BOOL enableInterPopGestureRecognizer;

@end

///-----------------------------------------
/// @name G7NavigationController+UIGestureRecognizer
///-----------------------------------------

/**
 * <p>G7NavigationController(UINavigationBar) 
 *    实现对navigationbar的功能扩展</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7NavigationController (UINavigationBar)

// 是否移除navigationbar的黑色边框和阴影
@property (assign, readwrite, nonatomic) BOOL removeBarBackgroundImageView;

@end


///-----------------------------------------
/// @name G7NavigationController+UIGestureRecognizer
///-----------------------------------------

/**
 * <p>G7NavigationController(UIGestureRecognizer)
 *    实现对视图手势操作的功能扩展</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7NavigationController (UIGestureRecognizer) <UIGestureRecognizerDelegate>

/// 获取手势操作
@property (strong, readonly, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

/*
 * 设置是否开启手势操作，默认开启，并实现回退操作；
 * 如果要修改操作结果可以重写方法 - (void)handlerGestureRecognizer;
 */
@property (assign, readwrite, nonatomic) BOOL enablePanGestureRecognizer;

/// 手势滑动操作的有效距离，默认50
@property (assign, readwrite, nonatomic) CGFloat effectiveDistanceWithGesture;
/// 操作动画的运行时长，默认0.3s
@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;

/// can overwrite to custom, default is invoke [self navBackButtonAction:nil]
- (void)handlerGestureRecognizer;

@end

