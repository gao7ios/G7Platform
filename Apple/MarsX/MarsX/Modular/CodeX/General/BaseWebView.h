//
//  BaseWebView.h
//  TextCodeX
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseWebViewController.h"


@interface BaseWebView : UIWebView

- (id)initWithFrame:(CGRect)frame
    delegateViewCtr:(id)delegateViewCtr;

-(void)openURL:(NSString *)url
        loaded:(void (^)(UIWebView *webView))loadedBlock
        failed:(void (^)(UIWebView *webView, NSError *error))failureBlock
   loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
    shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock;

@end
