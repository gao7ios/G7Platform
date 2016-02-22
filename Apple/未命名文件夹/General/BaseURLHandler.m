//
//  BaseURLHandler.m
//  TextCodeX
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseURLHandler.h"
#import "BaseWebViewController.h"

@interface BaseURLHandler()

@end

@implementation BaseURLHandler

+ (BOOL)handle:(UINavigationController *)navigationController
     targetURL:(NSString *)targetURL
   originalURL:(NSString *)originalURL
navigationType:(UIWebViewNavigationType)navigationType
{
    //NSLog(@"BaseURLHandler-handle");
    BOOL allowToLoad = YES;
    
    NSString *reqURL = [self cleanURL:targetURL];
    
    if ([originalURL isEqualToString:reqURL])
    {
        allowToLoad = YES;
    }
    else if([reqURL rangeOfString:@"about:blank"].length > 0){
        
		allowToLoad = NO;
	}
    else
    {
        BaseWebViewController *webViewController = [[BaseWebViewController alloc] initWithURL:reqURL];
        [navigationController pushViewController:webViewController animated:YES];
        allowToLoad = NO;
    }
    
    return allowToLoad;
}

+ (NSString *)cleanURL:(NSString *)url
{
    //NSLog(@"BaseURLHandler-cleanURL");
    NSString *newURL;
    //判断url最后一个字符是否是/或者是#,防止url判断时候出现异常
    if ([[url substringFromIndex:(url).length-1] isEqualToString:@"/"])
    {
        newURL = [url substringToIndex:(url).length-1];
    }
    else if ([[url substringFromIndex:(url).length-1] isEqualToString:@"#"])
    {
        newURL = [url substringToIndex:(url).length-1];
    }
    else
    {
        newURL = url;
    }
    
    return newURL;
}

@end