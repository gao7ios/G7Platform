//
//  CXWebController.m
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXBrowserWebController.h"

@interface CXBrowserWebController()

@end

@implementation CXBrowserWebController

#pragma mark - * [初始化]

- (id)initWithRootViewController:(UIViewController *)rootViewController originalUrl:(NSString *)url
{
    if (self = [super initWithRootViewController:rootViewController originalUrl:url])
    {
        self.historyType = [[CXHistoryType alloc] init];
        self.historyType.url = url;
        self.historyType.title = @"";
    }
    
    return self;
}

#pragma mark - delegate UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [CXURLHandler handle:self.rootViewController
                        targetURL:request.URL.absoluteString
                      originalURL:self.historyType.url
                   navigationType:navigationType];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.historyType.title = title;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(browserWebController:titleFinished:)])
    {
        [self.delegate browserWebController:self titleFinished:title];
    }
    
    [[CXHistoryModel shareInstance] appendHistoryType:self.historyType];
    [[CXHistoryModel shareInstance] storeHistoryTypeArray];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
