//
//  G7EGORefresh.h
//  G7Core
//
//  Created by WangMingfu on 15/2/3.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

#import "G7Refresh.h"

//refresh pull direcation
typedef enum{
	G7EGORefreshDirectionDropDown = 100,
	G7EGORefreshDirectionRightPull,
	G7EGORefreshDirectionRightPullWithHTable,
	
} G7EGORefreshDirection;

//refresh state
typedef enum{
	G7EGORefreshStatePulling = 0,
	G7EGORefreshStateNormal,
	G7EGORefreshStateLoading
} G7EGORefreshState;

/**
 * EGO refresh header view, implement G7RefreshDelegate
 */
@interface G7EGORefresh : G7RefreshView 

@property(nonatomic, strong) UILabel *statusLabel;

@property(nonatomic, strong) NSString *statusStr;

/// init
- (id)initWithFrame:(CGRect)frame andDirection:(G7EGORefreshDirection)direction;

/// refresh operation
- (void)refreshLastUpdatedDate;

@end
