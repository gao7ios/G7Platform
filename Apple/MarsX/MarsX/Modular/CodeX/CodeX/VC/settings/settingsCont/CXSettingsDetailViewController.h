//
//  CXSettingsDetailViewController.h
//  CodeX
//
//  Created by yuyang on 14-12-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXPhoneViewController.h"
#import "CXKeyValueType.h"

@protocol CXSettingsDetailViewControllerDelegate;

@interface CXSettingsDetailViewController : CXPhoneViewController

- (id)initWith:(CXKeyValueType *)keyValueType;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) CXKeyValueType *keyValueType;
@property (nonatomic, assign) id<CXSettingsDetailViewControllerDelegate> delegate;

@end

@protocol CXSettingsDetailViewControllerDelegate <NSObject>

- (void)settingsDetailViewController:(CXSettingsDetailViewController *)settingsDetailViewController
                         confirmData:(CXKeyValueType *)keyValueType;

@end
