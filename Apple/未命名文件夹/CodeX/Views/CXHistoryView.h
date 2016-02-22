//
//  CXHistoryView.h
//  NewCodeX
//
//  Created by mac on 14-3-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXHistoryModel.h"

@protocol CXHistoryViewDelegate <NSObject>

- (void)urlSelected:(NSString *)url;
- (void)cellOptionsTrigger:(NSString *)title url:(NSString *)url;

@end

@interface CXHistoryView : UITableView

@property (weak, nonatomic) id<CXHistoryViewDelegate> historyDelegate;

- (void)historyReload;

@end
