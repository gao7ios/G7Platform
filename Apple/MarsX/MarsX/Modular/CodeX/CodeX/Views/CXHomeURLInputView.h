//
//  BaseRootNavView.h
//  NewCodeX
//
//  Created by mac on 14-3-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

@class CXHomeViewController;

@protocol CXURLInputDelegate <NSObject>

- (void)triggerInput;
- (void)openQRCode;
- (void)openURL: (NSString *) url;

@end

@interface CXHomeURLInputView : UIView

@property (weak, nonatomic) id<CXURLInputDelegate> delegate;

- (void)keyboardHide;

@end

