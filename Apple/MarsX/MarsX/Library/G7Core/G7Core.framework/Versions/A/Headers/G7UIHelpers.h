//
//  G7UIHelpers.h
//  G7Core
//
//  Created by WangMingfu on 15/1/20.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "G7ProgressHUD.h"
#import "G7Button.h"
#import "G7TextField.h"
#import "G7PageControl.h"
#import "G7SlimeRefresh.h"
#import "G7EGORefresh.h"
#import "G7WebView.h"
#import "G7ProgressBar.h"
#import "G7NavigationBar.h"
#import "G7TableView.h"

#import "UIImage+G7Extension.h"
#import "UIView+G7Extension.h"
#import "UIControl+G7Extension.h"
#import "UIAlertView+G7Extension.h"
#import "UIActionSheet+G7Extension.h"
#import "G7WebView+G7Extension.h"

/**
 * G7UIHelpers 创建UI的帮助类
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7UIHelpers : NSObject

///-----------------------------------------
/// @name UIColor
///-----------------------------------------




///-----------------------------------------
/// @name progress
///-----------------------------------------

+ (void)showProgress;
+ (void)showProgressWithText:(NSString *)text;
+ (void)showProgressWithText:(NSString *)text detailText:(NSString *)detail;
+ (void)showProgressWhileExecutingBlock:(dispatch_block_t)block;
+ (void)showProgressWithText:(NSString *)text whileExecutingBlock:(dispatch_block_t)block;
+ (void)showProgressWhileExecuting:(SEL)method onTarget:(id<G7ProgressHUDDelegate>)target withObject:(id)object;
+ (void)showProgressWithText:(NSString *)text whileExecuting:(SEL)method onTarget:(id<G7ProgressHUDDelegate>)target withObject:(id)object;

+ (void)removeProgress;

///-----------------------------------------
/// @name status
///-----------------------------------------

+ (void)showStatusWithText:(NSString *)text;
+ (void)showStatusWithCustomView:(UIView *)customView withText:(NSString *)text;
+ (void)showStatusWithCustomView:(UIView *)customView withText:(NSString *)text delay:(NSTimeInterval)delay;

+ (void)showStatusWithCompleted;
+ (void)showStatusWithCompletedText:(NSString *)text;
+ (void)showStatusWithCompletedText:(NSString *)text delay:(NSTimeInterval)delay;

+ (void)showStatusWithFailed;
+ (void)showStatusWithFailedText:(NSString *)text;
+ (void)showStatusWithFailedText:(NSString *)text delay:(NSTimeInterval)delay;


///-----------------------------------------
/// @name alert
///-----------------------------------------

// use UIAlertView+G7Extension funcs.
/*
	[UIAlertView showWithTitle:title
					   message:message
		     cancelButtonTitle:@"NO"
		     otherButtonTitles:@"YES",nil
				      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
				      }];
 or
 
	[UIAlertView showWithTitle:title
					   message:message
						 style:style
			 cancelButtonTitle:@"NO"
			 otherButtonTitles:@"YES",nil
					  tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
					  }];
 */

///-----------------------------------------
/// @name action-sheet
///-----------------------------------------

// use UIActionSheet+G7Extension funcs.
/*
+ (UIActionSheet *)showFromTabBar:(UITabBar *)tabBar
						withTitle:(NSString *)title
				cancelButtonTitle:(NSString *)cancelButtonTitle
		   destructiveButtonTitle:(NSString *)destructiveButtonTitle
				otherButtonTitles:(NSArray *)otherButtonTitles
						 tapBlock:(UIActionSheetCompletionBlock)tapBlock
*/


///-----------------------------------------
/// @name create
///-----------------------------------------

// G7Button
+ (G7Button *)buttonWithFrame:(CGRect)frame;
+ (G7Button *)buttonWithFrame:(CGRect)frame titleRect:(CGRect)titleRect;
+ (G7Button *)buttonWithFrame:(CGRect)frame imageRect:(CGRect)imageRect;
+ (G7Button *)buttonWithFrame:(CGRect)frame backgroundRect:(CGRect)backgroundRect;
+ (G7Button *)buttonWithFrame:(CGRect)frame
					  titleRect:(CGRect)titleRect
					  imageRect:(CGRect)imageRect
				 backgroundRect:(CGRect)backgroundRect;

// G7TextField
+ (G7TextField *)textFieldWithFrame:(CGRect)frame;
+ (G7TextField *)textFieldWithFrame:(CGRect)frame textRect:(CGRect)textRect;
+ (G7TextField *)textFieldWithFrame:(CGRect)frame placeholderRect:(CGRect)placeholderRect;
+ (G7TextField *)textFieldWithFrame:(CGRect)frame editingRect:(CGRect)editingRect;
+ (G7TextField *)textFieldWithFrame:(CGRect)frame
							 textRect:(CGRect)textRect
					  placeholderRect:(CGRect)placeholderRect
						  editingRect:(CGRect)editingRect;
+ (G7TextField *)textFieldWithFrame:(CGRect)frame
						  defaultText:(NSString *)defaultText
							 textRect:(CGRect)textRect
						  placeholder:(NSString *)placehodler
					  placeholderRect:(CGRect)placeholderRect
						  editingRect:(CGRect)editingRect;


// G7PageControl
+ (G7PageControl *)pageControlWithNumber:(NSUInteger)number;
+ (G7PageControl *)pageControlWithNumber:(NSUInteger)number
								 pageStyle:(G7PageControlStyle)style;
+ (G7PageControl *)pageControlWithNumber:(NSUInteger)number
								thumbImage:(UIImage *)thumbImage
						selectedThumbImage:(UIImage *)selectedThumbImage;
+ (G7PageControl *)pageControlWithNumber:(NSUInteger)number
								 pageStyle:(G7PageControlStyle)style
								thumbImage:(UIImage *)thumbImage
						selectedThumbImage:(UIImage *)selectedThumbImage;

// G7WebView
+ (G7WebView *)webviewWithFrame:(CGRect)frame;
+ (G7WebView *)webviewWithFrame:(CGRect)frame delegate:(id<G7WebViewDelegate>)delegate;

// use G7WebView+G7Extension funcs.
/*
+ (G7WebView *) loadURLString:(NSString *) urlString
						 loaded:(void (^)(UIWebView *webView)) loadedBlock
						 failed:(void (^)(UIWebView *webView, NSError *error)) failureBlock;

+ (G7WebView *) loadURLString:(NSString *) urlString
				   headerFields:(NSDictionary *)headerFields
						 loaded:(void (^)(UIWebView *webView)) loadedBlock
						 failed:(void (^)(UIWebView *webView, NSError *error)) failureBlock
					loadStarted:(void (^)(UIWebView *webView)) loadStartedBlock
					 shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType)) shouldLoadBlock;
 */


@end
