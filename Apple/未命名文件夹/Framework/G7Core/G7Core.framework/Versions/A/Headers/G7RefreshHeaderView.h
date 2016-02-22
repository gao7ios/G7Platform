//
//  G7RefreshHeaderView.h
//  G7Core
//
//  Created by WangMingfu on 15/2/3.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

//拖动方向
typedef enum{
	G7RefreshDropDown = 100,
	G7RefreshRightPull,
	G7RefreshRightPullWithHTable,
	
} G7PullRefreshDirection;

typedef enum{
	G7OPullRefreshPulling = 0,
	G7OPullRefreshNormal,
	G7OPullRefreshLoading,
} G7PullRefreshState;

@protocol G7RefreshHeaderDelegate;
@interface G7RefreshHeaderView : UIView {
	
	G7PullRefreshState _state;
	
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
	
	G7PullRefreshDirection _pullDirection;
}

@property(nonatomic,weak) id <G7RefreshHeaderDelegate> delegate;
@property(nonatomic, strong) UILabel *statusLabel;

//下拉刷新提示语
@property(nonatomic, copy) NSString *statusStr;


- (id)initWithFrame:(CGRect)frame andDirection:(G7PullRefreshDirection)direction;

- (void)refreshLastUpdatedDate;
- (void)g7RefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)g7RefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)g7RefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
- (void)g7RefreshScrollView:(UIScrollView *)scrollView animated:(BOOL)animated;

@end
@protocol G7RefreshHeaderDelegate <NSObject>

- (void)g7RefreshHeaderDidStartRefresh:(G7RefreshHeaderView*)view;
- (BOOL)g7RefreshHeaderDataSourceIsLoading:(G7RefreshHeaderView*)view;

@optional
- (NSDate *)g7RefreshHeaderDataSourceLastUpdated:(G7RefreshHeaderView*)view;
@end
