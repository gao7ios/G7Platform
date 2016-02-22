//
//  G7ViewController.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-15.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7.h"
#import "G7URLMap.h"
/**
 * <p>G7ViewController 继承自UIViewController，
 *    实现对原生UIViewController功能的扩展。</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7ViewController : UIViewController <G7URLMapDelegate>

/// G7URLMapDelegate
@property (strong, readwrite, nonatomic) NSString *apiPath;

/// 设置视图背景图片
@property (strong, readwrite, nonatomic) UIImage *backgroundImage;

/// 设置视图阴影位置，参考 G7CVSide
@property (assign, readwrite, nonatomic) G7CVSide contentViewShadow;

/// 设置视图显示的暗色比例
@property (assign, readwrite, nonatomic) CGFloat contentViewDarkRatio;

/// 设置视图的阴影大小
@property (assign, readwrite, nonatomic) CGFloat contentViewShadowOffset;

/// 设置视图的阴影透明值
@property (assign, readwrite, nonatomic) CGFloat contentViewShadowAlpha;

/// 设置视图的圆角大小
@property (assign, readwrite, nonatomic) CGFloat contentViewCornerRadius;

/// 未启用
///@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;

/// 获取视图的导航条，重写父类的属性，并使用G7NavigationBar继承实现
@property (nonatomic, strong) UINavigationBar *navigationBar;

/// 获取视图导航条的items
@property (nonatomic, readonly, strong) UINavigationItem *g7NavigationItem;


/**
 * 子类重写，在该方法内实现视图的创建
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
- (void)setupViews;


@end

///-----------------------------------------
/// @name G7ViewController+UINavigationBar
///-----------------------------------------

/**
 * <p>G7ViewController(UINavigationBar)
 *    实现对navigationbar的功能扩展</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7ViewController (UINavigationBar)

/// 设置导航标题
@property (copy, readwrite, nonatomic) NSString *title;

/// 设置导航的titleView
@property (strong, readwrite, nonatomic) UIView *titleView;

/*
 * 是否在导航条上显示返回按钮
 * 如果YES，默认实现按钮点击回调事件 - (void)navBackButtonAction:(id)sender;
 */
@property (assign, readwrite, nonatomic) BOOL showNavigationBackItem;
@property (strong, readonly, nonatomic) UIBarButtonItem *navigationBackItem;

/*
 * 是否在导航条上显示取消按钮
 * 如果YES，默认实现按钮点击回调事件 - (void)navCancelButtonAction:(id)sender;
 */
@property (assign, readwrite, nonatomic) BOOL showNavigationCancelItem;
@property (strong, readonly, nonatomic) UIBarButtonItem *navigationCancelItem;

/*
 * 是否在导航条上显示刷新按钮
 * 如果YES，默认实现按钮点击回调事件 - (void)navRefreshButtonAction:(id)sender;
 */
@property (assign, readwrite, nonatomic) BOOL showNavigationRefreshItem;
@property (strong, readonly, nonatomic) UIBarButtonItem *navigationRefreshItem;

/*
 * 是否在导航条上显示搜索按钮
 * 如果YES，默认实现按钮点击回调事件 - (void)navSearchButtonAction:(id)sender;
 */
@property (assign, readwrite, nonatomic) BOOL showNavigationSearchItem;
@property (strong, readonly, nonatomic) UIBarButtonItem *navigationSearchItem;

/*
 * 是否在导航条上显示分享按钮
 * 如果YES，默认实现按钮点击回调事件 - (void)navShareButtonAction:(id)sender;
 */
@property (assign, readwrite, nonatomic) BOOL showNavigationShareItem;
@property (strong, readonly, nonatomic) UIBarButtonItem *navigationShareItem;


/// 未启用
@property (strong, readwrite, nonatomic) NSArray *rightBarButtonItems;
@property (strong, readwrite, nonatomic) NSArray *leftBarButtonItems;

/**
 * <p>导航条的返回按钮事件，子类可重写
 *   默认调用[self.navigationController popViewControllerAnimated:YES];</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
- (void)navBackButtonAction:(id)sender;

/**
 * <p>导航条的取消按钮事件，子类可重写
 *   默认调用[self dismissViewControllerAnimated:YES completion:NULL];</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
- (void)navCancelButtonAction:(id)sender;

/**
 * <p>导航条的刷新按钮事件，需要子类重写
 *   默认调用不做处理</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
- (void)navRefreshButtonAction:(id)sender;

/**
 * <p>导航条的搜索按钮事件，需要子类重写
 *   默认调用不做处理</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
- (void)navSearchButtonAction:(id)sender;

/**
 * <p>导航条的分享按钮事件，需要子类重写
 *   默认调用不做处理</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
- (void)navShareButtonAction:(id)sender;

@end


///-----------------------------------------
/// @name G7ViewController+UINavigationBar
///-----------------------------------------

/**
 * <p>G7ViewController(UIGestureRecognizer)
 *    实现对手势操作的功能扩展</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7ViewController (UIGestureRecognizer) <UIGestureRecognizerDelegate>

/*
 * 设置是否开启手势操作，默认开启，并实现回退操作；
 * 如果要修改操作结果可以重写方法 - (void)handlerGestureRecognizer;
 */
@property (nonatomic, assign) BOOL enablePanGestureRecognizer;

/// 获取手势操作
@property (nonatomic, readonly, strong) UIPanGestureRecognizer* panGestureRecognizer;

/// 手势滑动操作的有效距离，默认44
@property (nonatomic, assign) CGFloat effectiveDistanceWithGesture;

// can overwrite to custom, default is invoke [self navBackButtonAction:nil]
- (void)handlerGestureRecognizer;

@end