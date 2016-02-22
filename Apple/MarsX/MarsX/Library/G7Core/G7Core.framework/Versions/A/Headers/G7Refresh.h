//
//  G7Refresh.h
//  G7Core
//
//  Created by WangMingfu on 15/10/27.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "G7Loadable.h"

/* define refresh style，mostly use slime style or ego refresh style, but if you
 * want to custom the style,then use the `G7RefreshStyleCustom`.
 */
typedef NS_ENUM(NSInteger, G7RefreshStyle) {
	G7RefreshStyleNone,				// none.
	G7RefreshStyleSlime,			// slime style refresh table header
	G7RefreshStyleEGORefresh,		// use ego refresh table header
	G7RefreshStyleCustom
};

FOUNDATION_EXTERN CGFloat const kG7RefreshViewDefaultHeight;

@protocol G7RefreshDelegate;

/*
 * The protocol of refresh header.
 */
@protocol G7Refresh <G7Loadable>

@required

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) id<G7RefreshDelegate> delegate;
@property (nonatomic, assign, readonly) G7RefreshStyle style;

/// 刷新视图高度，默认使用 kG7RefreshViewDefaultHeight
@property (nonatomic, assign) CGFloat height;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

+ (instancetype)setupRefreshForScrollView:(UIScrollView *)scrollView delegate:(id<G7RefreshDelegate>)delegate;

@optional

/// 下拉刷新动画使用
@property (nonatomic, strong) NSArray *animationImages;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *pullingImage;
/// imageView动画执行间隔时间，默认为0.5秒
@property (nonatomic, assign) NSTimeInterval animationDuration;

/// 设置背景
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *backgroundImage;

@end


/*
 * The delegate of refresh header
 */
@protocol G7RefreshDelegate <NSObject>

@optional

- (void)refreshDidStartRefreshing:(id<G7Refresh>)refresh;
- (void)refreshDidFinishRefresh:(id<G7Refresh>)refresh;

- (NSDate *)refreshDataSourceLastUpdated:(id<G7Refresh>)refresh;

@end


@interface G7RefreshView : UIView <G7Refresh>

@property (nonatomic, assign, getter=isFinished) BOOL finished;
@property (nonatomic, assign, getter=isLoading) BOOL loading;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) id<G7RefreshDelegate> delegate;
@property (nonatomic, assign, readonly) G7RefreshStyle style;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSArray *animationImages;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *pullingImage;
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *backgroundImage;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;


+ (instancetype)setupRefreshForScrollView:(UIScrollView *)scrollView withStyle:(G7RefreshStyle)style
							   delegate:(id<G7RefreshDelegate>)delegate;


@end
