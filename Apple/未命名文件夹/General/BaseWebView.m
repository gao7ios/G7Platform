//
//  BaseWebView.m
//  TextCodeX
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseWebView.h"
#import "BaseWebViewController.h"

#import "SRRefreshView.h"
#import "SRSlimeView.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"


@interface BaseWebView()<NJKWebViewProgressDelegate,SRRefreshDelegate,UIScrollViewDelegate,UIWebViewDelegate>

@property (copy, nonatomic) NSString *url;

@property (strong, nonatomic) NJKWebViewProgress *progressProxy;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@property (strong, nonatomic) SRRefreshView *refreshHeaderView;

@property (assign, nonatomic) UIViewController<NJKWebViewProgressDelegate,UIWebViewDelegate> *delegateViewCtr;

@end

static void (^__loadedBlock)(UIWebView *webView);
static void (^__failureBlock)(UIWebView *webView, NSError *error);
static void (^__loadStartedBlock)(UIWebView *webView);
static BOOL (^__shouldLoadBlock)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType);

#define ProgressViewTag 100100101

#define TRUE_END_REPORT NO

@implementation BaseWebView

- (id)initWithFrame:(CGRect)frame
    delegateViewCtr:(id)delegateViewCtr
{
    if (self = [super initWithFrame:frame])
    {
        
        self.delegateViewCtr = delegateViewCtr;
        [self initData];
        
        [self addEGORefreshHeaderView];
        [self addProgressView];
    }
    //NSLog(@"BaseWebView-initWithFrame");
    return self;
}


- (void)initData
{
    //NSLog(@"BaseWebView-initData");
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
}

/*
 *添加下拉刷新
 */
- (void)addEGORefreshHeaderView
{
    //NSLog(@"BaseWebView-addEGORefreshHeaderView");
	if (self.refreshHeaderView == nil)
    {
        self.refreshHeaderView = [[SRRefreshView alloc] init];
        self.refreshHeaderView.delegate = self;
        self.refreshHeaderView.upInset = 0;
        self.refreshHeaderView.slimeMissWhenGoingBack = YES;
        self.refreshHeaderView.slime.bodyColor = [UIColor grayColor];
        self.refreshHeaderView.slime.skinColor = [UIColor whiteColor];
        self.refreshHeaderView.slime.lineWith = 1;
        self.refreshHeaderView.slime.shadowBlur = 4;
    }
    
    [self scrollView].delegate = self;
    [[self scrollView] addSubview:self.refreshHeaderView];
}

/*
 *获取webview的UIScrollView
 */
- (UIScrollView *)scrollView
{
    //NSLog(@"BaseWebView-scrollView");
    return (UIScrollView *)[[self subviews]objectAtIndex:0];
}

- (void)addProgressView
{
    //NSLog(@"BaseWebView-addProgressView");
    if (self.progressView == nil)
    {
        UIView *view = [self.delegateViewCtr.navigationController.navigationBar viewWithTag:ProgressViewTag];
        
        if (view == nil)
        {
            CGFloat progressBarHeight = 2.5f;
            CGRect navigaitonBarBounds = self.delegateViewCtr.navigationController.navigationBar.bounds;
            CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
            self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
            self.progressView.tag = ProgressViewTag;
            [self.delegateViewCtr.navigationController.navigationBar addSubview:_progressView];
        }
        else
        {
            self.progressView = (NJKWebViewProgressView *)view;
        }
    }
}

-(void)openURL:(NSString *)url
        loaded:(void (^)(UIWebView *webView))loadedBlock
        failed:(void (^)(UIWebView *webView, NSError *error))failureBlock
   loadStarted:(void (^)(UIWebView *webView))loadStartedBlock
    shouldLoad:(BOOL (^)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType))shouldLoadBlock
{
    //NSLog(@"BaseWebView-openURL");
    __loadedBlock       = loadedBlock;
    __failureBlock      = failureBlock;
    __loadStartedBlock  = loadStartedBlock;
    __shouldLoadBlock   = shouldLoadBlock;
    
    self.url = url;
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                   timeoutInterval:NETWORK_TIMEOUT];
    [self loadRequest:req                                                                                                             ];
    [self.progressView setProgress:0];
}

- (void)reload
{
    //NSLog(@"BaseWebView-reload");
    [self openURL:self.url
           loaded:__loadedBlock
           failed:__failureBlock
      loadStarted:__loadStartedBlock
       shouldLoad:__shouldLoadBlock];
}


#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress
         updateProgress:(float)progress
{
    //NSLog(@"BaseWebView-webViewProgress");
    [self.progressView setProgress:progress animated:YES];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"BaseWebView-scrollViewDidScroll");
    [self.refreshHeaderView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //NSLog(@"BaseWebView-scrollViewDidEndDragging");
    [self.refreshHeaderView scrollViewDidEndDraging];
}


#pragma mark - SLimeRefresh Delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    //NSLog(@"BaseWebView-slimeRefreshStartRefresh");
    if ([self isLoading] == NO)
    {
        [self openURL:self.url loaded:__loadedBlock failed:__failureBlock loadStarted:__loadStartedBlock shouldLoad:__shouldLoadBlock];
    }
}


#pragma mark - UIWebview delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //NSLog(@"BaseWebView-webViewDidFinishLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.refreshHeaderView endRefresh];
    
    if(__loadedBlock)
    {
        __loadedBlock(webView);
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //NSLog(@"BaseWebView-didFailLoadWithError");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if(__failureBlock)
    {
        __failureBlock(webView, error);
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //NSLog(@"BaseWebView-webViewDidStartLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    if(__loadStartedBlock)
    {
        __loadStartedBlock(webView);
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //NSLog(@"BaseWebView-shouldStartLoadWithRequest");
    if(__shouldLoadBlock)
    {
        return __shouldLoadBlock(webView, request, navigationType);
    }
    
    return YES;
}

@end