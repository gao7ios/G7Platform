//
//  UIActionSheet+G7Extension.h
//  G7Core
//
//  Created by WangMingfu on 15/1/22.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^UIActionSheetBlock) (UIActionSheet *actionSheet);
typedef void (^UIActionSheetCompletionBlock) (UIActionSheet *actionSheet, NSInteger buttonIndex);


@interface UIActionSheet (G7Extension)

+ (UIActionSheet *)showFromTabBar:(UITabBar *)tabBar
						withTitle:(NSString *)title
				cancelButtonTitle:(NSString *)cancelButtonTitle
		   destructiveButtonTitle:(NSString *)destructiveButtonTitle
				otherButtonTitles:(NSArray *)otherButtonTitles
						 tapBlock:(UIActionSheetCompletionBlock)tapBlock;

+ (UIActionSheet *)showFromToolbar:(UIToolbar *)toolbar
						 withTitle:(NSString *)title
				 cancelButtonTitle:(NSString *)cancelButtonTitle
			destructiveButtonTitle:(NSString *)destructiveButtonTitle
				 otherButtonTitles:(NSArray *)otherButtonTitles
						  tapBlock:(UIActionSheetCompletionBlock)tapBlock;

+ (UIActionSheet *)showInView:(UIView *)view
					withTitle:(NSString *)title
			cancelButtonTitle:(NSString *)cancelButtonTitle
	   destructiveButtonTitle:(NSString *)destructiveButtonTitle
			otherButtonTitles:(NSArray *)otherButtonTitles
					 tapBlock:(UIActionSheetCompletionBlock)tapBlock;

+ (UIActionSheet *)showFromBarButtonItem:(UIBarButtonItem *)barButtonItem
								animated:(BOOL)animated
							   withTitle:(NSString *)title
					   cancelButtonTitle:(NSString *)cancelButtonTitle
				  destructiveButtonTitle:(NSString *)destructiveButtonTitle
					   otherButtonTitles:(NSArray *)otherButtonTitles
								tapBlock:(UIActionSheetCompletionBlock)tapBlock;

+ (UIActionSheet *)showFromRect:(CGRect)rect
						 inView:(UIView *)view
					   animated:(BOOL)animated
					  withTitle:(NSString *)title
			  cancelButtonTitle:(NSString *)cancelButtonTitle
		 destructiveButtonTitle:(NSString *)destructiveButtonTitle
			  otherButtonTitles:(NSArray *)otherButtonTitles
					   tapBlock:(UIActionSheetCompletionBlock)tapBlock;

@property (copy, nonatomic) UIActionSheetCompletionBlock tapBlock;
@property (copy, nonatomic) UIActionSheetCompletionBlock willDismissBlock;
@property (copy, nonatomic) UIActionSheetCompletionBlock didDismissBlock;

@property (copy, nonatomic) UIActionSheetBlock willPresentBlock;
@property (copy, nonatomic) UIActionSheetBlock didPresentBlock;
@property (copy, nonatomic) UIActionSheetBlock cancelBlock;

@end
