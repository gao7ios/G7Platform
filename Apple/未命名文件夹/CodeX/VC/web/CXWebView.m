//
//  BaseWebView.m
//  TextCodeX
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//
#import <objc/runtime.h>

#import "CXWebView.h"
#import "CXWebViewController.h"
#import "CXURLHandler.h"

@interface CXWebView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSString *url;

@end

@implementation CXWebView

- (id)initWithFrame:(CGRect)frame
{
    if (&frame == NULL)
    {
        frame = CGRectMake(0, 0, frame.size.width, frame.size.height-64);
    }

    return [super initWithFrame:frame];
}

- (void)openURL:(NSString *)url
{
    self.url = url;
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                   timeoutInterval:NETWORK_TIMEOUT];
    [req setValue:[CXURLHandler headMetaToBase64] forHTTPHeaderField:@"User-Agent1"];
    [self performSelector:@selector(loadRequest:) withObject:req afterDelay:0.5];
}

- (void)reload
{
    [self openURL:self.url];
}

- (void)stopLoading
{
    [super stopLoading];
}

@end