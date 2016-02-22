//
//  CXSettingsContViewController.h
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXPhoneViewController.h"
#import "CXSettingsContController.h"

@interface CXSettingsContViewController : CXPhoneViewController

- (id)initWithItemType:(CXSettingsItemType)itemType;

@property (nonatomic, strong) CXSettingsContController *settingsContController;

@end
