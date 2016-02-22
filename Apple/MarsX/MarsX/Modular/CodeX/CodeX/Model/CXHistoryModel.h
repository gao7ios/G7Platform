//
//  CXHistoryModel.h
//  NewCodeX
//
//  Created by mac on 14-3-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXHistoryType.h"

@protocol CXHistoryURLStoreDelegate <NSObject>

- (void)historyReload;

@end

@interface CXHistoryModel : NSObject

@property (strong, nonatomic) UITableViewCell * (^viewCellHandler)(UITableView *,NSIndexPath *);

+ (CXHistoryModel *) shareInstance;

- (NSString *)getHistoryTypeURL:(NSUInteger)index;

- (NSString *)getHistoryTypeTitle:(NSUInteger)index;

- (void)removeHistoryType:(NSUInteger)index;

- (void)appendHistoryType:(CXHistoryType *)historyType;

- (void)cleanHistoryTypeArray;

- (NSUInteger)count;

- (void)storeHistoryTypeArray;

@end
