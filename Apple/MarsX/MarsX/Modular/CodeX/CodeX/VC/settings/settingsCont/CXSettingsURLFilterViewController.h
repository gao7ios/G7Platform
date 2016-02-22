//
//  CXSettingsURLFilterViewController.h
//  CodeX
//
//  Created by yuyang on 14-12-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXPhoneViewController.h"

@protocol CXSettingsURLFilterViewControllerDelegate <NSObject>

- (void)choicedOpenTypeWithText:(NSString *)text;

@end

@interface CXSettingsURLFilterViewController : CXPhoneViewController

@property (nonatomic, assign) id<CXSettingsURLFilterViewControllerDelegate> delegate;

@end


