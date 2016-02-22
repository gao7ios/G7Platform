//
//  BaseWebViewController.m
//  TextCodeX
//
//  Created by mac on 14-2-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseWebViewController.h"
#import "PhoneViewController.h"
#import "BaseWebView.h"
#import "BaseURLHandler.h"

#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface BaseWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) BaseWebView *webView;
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) UILabel *titleView;

@end

@implementation BaseWebViewController

- (id)initWithURL:(NSString *)url
{
    //NSLog(@"BaseWebViewController-initWithURL");
    if (self = [super init])
    {
        self.url = url;
    }
    
    return self;
}

- (void)loadView
{
    //NSLog(@"BaseWebViewController-loadView");
    [super loadView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(refreshWeb)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    if (self.titleView == nil)
    {
        CGRect navTitleViewFrame = CGRectMake(0, 0, 100, 39);
        self.titleView = [[UILabel alloc] initWithFrame:navTitleViewFrame];
        self.titleView.textAlignment = NSTextAlignmentCenter;
        self.titleView.textColor = [UIColor whiteColor];
        self.titleView.center = CGPointMake(160, self.navigationController.navigationBar.frame.size.height / 2);
        self.navigationItem.titleView = self.titleView;
    }
    
    self.isContainGestureRecognizer = YES;
    
    self.webView = [[BaseWebView alloc] initWithFrame:self.navigationController.view.frame delegateViewCtr:self];
    [self.view addSubview:_webView];
    
    
    __block UINavigationController *navigationController = self.navigationController;
    __block NSString *url = self.url;
    __block UILabel *label = self.titleView;
    
    [self.webView openURL:self.url loaded:^(UIWebView *webView)
    {
        label.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        
    }
    failed:^(UIWebView *webView, NSError *error)
    {
        
    }
    loadStarted:^(UIWebView *webView)
    {
        
    }
    shouldLoad:^BOOL(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType)
    {
        BOOL allowToRequest = [BaseURLHandler handle:navigationController
                                           targetURL:request.URL.absoluteString
                                         originalURL:url
                                      navigationType:navigationType];
        NSLog(@"%@=%@",self.url,request.URL.absoluteString);
        return allowToRequest;
    }];
}

- (void)refreshWeb
{
    //NSLog(@"BaseWebViewController-refreshWeb");
    [self.webView reload];
}

@end