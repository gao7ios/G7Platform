//
//  CXSettingsContController.h
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXTableController.h"
#import "CXKeyValueType.h"

@interface CXSettingsContController : CXTableController

@property (nonatomic, assign) CXSettingsItemType itemType;

- (void)pushSettingsDetailViewControllerWith:(CXKeyValueType *)keyValueType index:(NSInteger)index;
- (void)updateModelList;

@end
