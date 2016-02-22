//
//  CXWebCore.h
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXHistoryType.h"
#import "CXHistoryModel.h"
#import "CXURLHandler.h"
#import "CXWebController.h"

@protocol CXBrowserWebControllerDelegate;

@interface CXBrowserWebController : CXWebController

@property (nonatomic, assign) id<CXBrowserWebControllerDelegate> delegate;
@property (nonatomic, strong) CXHistoryType *historyType;

@end

@protocol CXBrowserWebControllerDelegate <NSObject>

@optional
- (void)browserWebController:(CXBrowserWebController *)browserWebController titleFinished:(NSString *)title;

@end
