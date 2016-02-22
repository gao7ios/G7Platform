//
//  G7TableFooter.h
//  G7Core
//
//  Created by WangMingfu on 15/10/28.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import "G7.h"

#import "G7Loadable.h"


FOUNDATION_EXTERN CGFloat const kG7FooterViewDefaultHeight;

/**
 * Define table footer style.
 */
typedef NS_ENUM(NSInteger, G7TableFooterStyle) {
	G7TableFooterStyleNone,				// none.
	G7TableFooterStyleAutoLoading,		// when table is scroll to bottom, auto loading and trigger start loading actions
	G7TableFooterStyleUserPerform,		// do not loading, until user perform the action
	G7TableFooterStylePull,				// do not loading, until user drag the scrollview and pull offset to 60
	G7TableFooterStyleCustom			// custom the style, must implement the G7TableFooter.
};

/**
 * Define table footer state. Pull state use when footerstyle is G7TableFooterStylePull.
 */
typedef NS_ENUM(NSInteger, G7TableFooterState) {
	G7TableFooterStateNormal,
	G7TableFooterStateLoading,
	G7TableFooterStateDone,
	G7TableFooterStatePull
};

//pre define
@protocol G7TableFooterDelegate;

/**
 * The protocol for all the tablefooter, that implement the G7Loadable protocol.
 */
@protocol G7TableFooter <G7Loadable>

@required

/// all is required.

@property (nonatomic, readonly) G7TableFooterStyle style;
@property (nonatomic, readonly) G7TableFooterState state;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id<G7TableFooterDelegate> delegate;

@property (nonatomic, copy) NSString *loadingText;
@property (nonatomic, copy) NSString *normalText;
@property (nonatomic, copy) NSString *doneText;

/// 刷新视图高度，默认使用 kG7RefreshViewDefaultHeight
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) BOOL showDoneTextWhenLoadFinished;
@property (nonatomic, assign) CGFloat footerHeight;

+ (instancetype)setupFooterForTableView:(UITableView *)tableView delegate:(id<G7TableFooterDelegate>)delegate;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@optional
/// 下拉刷新动画使用
@property (nonatomic, strong) NSArray *animationImages;
@property (nonatomic, strong) UIImage *normalImage;
/// imageView动画执行间隔时间，默认为0.5秒
@property (nonatomic, assign) NSTimeInterval animationDuration;

/// 设置背景
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *backgroundImage;

@end


@protocol G7TableFooterDelegate <NSObject>

@optional

- (void)footerDidStartLoading:(id<G7TableFooter>)footer;
- (void)footerDidFinishLoading:(id<G7TableFooter>)footer;
- (BOOL)footerIsLoading:(id<G7TableFooter>)footer;
- (CGFloat)footerHeight:(id<G7TableFooter>)footer;

@end


@interface G7TableFooterView : UIView <G7TableFooter>

@property (nonatomic, readonly) G7TableFooterStyle style;
@property (nonatomic, readonly) G7TableFooterState state;


@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id<G7TableFooterDelegate> delegate;

@property (nonatomic, copy) NSString *loadingText;
@property (nonatomic, copy) NSString *normalText;
@property (nonatomic, copy) NSString *doneText;

/// 下拉刷新动画使用
@property (nonatomic, strong) NSArray *animationImages;
@property (nonatomic, strong) UIImage *normalImage;
/// imageView动画执行间隔时间，默认为0.5秒
@property (nonatomic, assign) NSTimeInterval animationDuration;

/// 设置背景
//@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign, getter=isFinished) BOOL finished;
@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, assign) BOOL showDoneTextWhenLoadFinished;
@property (nonatomic, assign) CGFloat footerHeight;


+ (instancetype)setupFooterForTableView:(UITableView *)tableView withStyle:(G7TableFooterStyle)style
							   delegate:(id<G7TableFooterDelegate>)delegate;


@end




