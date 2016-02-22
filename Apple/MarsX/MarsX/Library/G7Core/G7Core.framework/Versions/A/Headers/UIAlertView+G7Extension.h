//
//  UIAlertView+G7Extension.h
//  G7Core
//
//  Created by WangMingfu on 15/1/22.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^UIAlertViewBlock) (UIAlertView *alertView);
typedef void (^UIAlertViewCompletionBlock) (UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (G7Extension)

+ (instancetype)showWithTitle:(NSString *)title
					  message:(NSString *)message
						style:(UIAlertViewStyle)style
			cancelButtonTitle:(NSString *)cancelButtonTitle
			otherButtonTitles:(NSArray *)otherButtonTitles
					 tapBlock:(UIAlertViewCompletionBlock)tapBlock;

+ (instancetype)showWithTitle:(NSString *)title
					  message:(NSString *)message
			cancelButtonTitle:(NSString *)cancelButtonTitle
			otherButtonTitles:(NSArray *)otherButtonTitles
					 tapBlock:(UIAlertViewCompletionBlock)tapBlock;

@property (copy, nonatomic) UIAlertViewCompletionBlock tapBlock;
@property (copy, nonatomic) UIAlertViewCompletionBlock willDismissBlock;
@property (copy, nonatomic) UIAlertViewCompletionBlock didDismissBlock;

@property (copy, nonatomic) UIAlertViewBlock willPresentBlock;
@property (copy, nonatomic) UIAlertViewBlock didPresentBlock;
@property (copy, nonatomic) UIAlertViewBlock cancelBlock;

@property (copy, nonatomic) BOOL(^shouldEnableFirstOtherButtonBlock)(UIAlertView *alertView);


@end
