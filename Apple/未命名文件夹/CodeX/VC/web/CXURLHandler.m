//
//  CXURLHandler.m
//  TextCodeX
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXURLHandler.h"
#import "CXWebViewController.h"
#import "CXHistoryModel.h"
#import "CXWebView.h"
#import "CXNavigationController.h"
#import <G7Core/NSString+G7Extension.h>

@interface CXURLHandler()

@end

@implementation CXURLHandler

+ (BOOL)handle:(UIViewController *)rootViewController
     targetURL:(NSString *)targetURL
   originalURL:(NSString *)originalURL
navigationType:(UIWebViewNavigationType)navigationType
{    
    BOOL allowToLoad = YES;
    NSString *newOriginalURL;
    NSString *reqURL;
    if (targetURL != nil && originalURL != nil)
    {
        newOriginalURL = [self cleanURL:originalURL];
        reqURL = [self cleanURL:targetURL];

        if (navigationType == UIWebViewNavigationTypeReload)
        {
            allowToLoad = YES;
        }
        else if ([reqURL rangeOfString:@"itms-apps://"].length > 0)
        {
            allowToLoad = YES;
        }
        else if (![newOriginalURL isEqualToString:reqURL] && navigationType == UIWebViewNavigationTypeOther)
        {
            allowToLoad = YES;
        }
        else if ([newOriginalURL isEqualToString:reqURL] && navigationType == UIWebViewNavigationTypeOther)
        {
            allowToLoad = YES;
        }
        else if ([reqURL rangeOfString:@"about:blank"].length > 0)
        {
            allowToLoad = NO;
        }
        else
        {
            if (navigationType == UIWebViewNavigationTypeLinkClicked)
            {
                CXWebViewController *webViewController = [[CXWebViewController alloc] initWithURL:reqURL];
                NSString *openTypeKeyName = [[CXSettingsModel shareInstance] openTypeKeyWith:reqURL];
                if ([openTypeKeyName isEqualToString:CXWebOpenNavPushKey])
                {
                    [rootViewController.navigationController pushViewController:webViewController animated:YES];
                }
                else if ([openTypeKeyName isEqualToString:CXWebOpenModalPresentKey])
                {
                    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:webViewController];
                    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:webViewController action:@selector(navCancel)];
                    webViewController.navigationItem.leftBarButtonItem = leftItem;
                    nav.modalPresentationStyle = UIModalPresentationFormSheet;
                    [rootViewController presentViewController:nav animated:YES completion:nil];
                }
                else
                {
                    [rootViewController.navigationController pushViewController:webViewController animated:YES];
                }
            }
            
            allowToLoad = NO;
        }
    }
    else
    {
        allowToLoad = NO;
    }
    
    return allowToLoad;
}

// 过滤url
+ (NSString *)cleanURL:(NSString *)url
{
    NSString *newURL;
    newURL = [self tailFiltering:url];
    newURL = [self headFiltering:newURL];
    return newURL;
}

+ (NSString *)headMetaToBase64
{
    NSString *headMetaBase;
    NSDictionary* jsonDict = [[CXSettingsModel shareInstance] headMetaDictionary];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    NSData *nsdata = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    headMetaBase = [nsdata base64EncodedStringWithOptions:0];
    return [NSString stringWithFormat:@"0%@",headMetaBase];
}

+ (NSString *)tailFiltering:(NSString *)url
{
    NSString *newURL;
    
    //判断url最后一个字符是否是/或者是#,防止url判断时候出现异常
    if ([[url substringFromIndex:(url).length-1] isEqualToString:@"/"])
    {
        newURL = [url substringToIndex:(url).length-1];
        newURL = [self tailFiltering:newURL];
    }
    else if ([[url substringFromIndex:(url).length-1] isEqualToString:@"#"])
    {
        newURL = [url substringToIndex:(url).length-1];
        newURL = [self tailFiltering:newURL];
    }
    else
    {
        newURL = url;
    }

    return newURL;
}

+ (NSString *)headFiltering:(NSString *)url
{
    NSString *newURL;
    NSString *schemaHeadPat = @"^(http|https|ftp|itms-apps):\\/\\/{1}";
    NSString *fileHeadPat = @"^(file):\\/\\/{1}";
    NSRegularExpression *schemaHeadReg = [[NSRegularExpression alloc] initWithPattern:schemaHeadPat options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRegularExpression *fileHeadReg = [[NSRegularExpression alloc] initWithPattern:fileHeadPat options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSArray *schemaHeadMatch = [schemaHeadReg matchesInString:url options:NSMatchingReportCompletion range:NSMakeRange(0, [url length])];
    NSArray *fileHeadMatch = [fileHeadReg matchesInString:url options:NSMatchingReportCompletion range:NSMakeRange(0, [url length])];
    if (schemaHeadMatch.count == 0)
    {
        if (fileHeadMatch.count != 0)
        {
            newURL = [NSString stringWithFormat:@"http://%@",[url substringFromIndex:7]];
        }
        else
        {
            newURL = [NSString stringWithFormat:@"http://%@",url];
        }
    }
    else
    {
        newURL = url;
    }
    return newURL;
}

@end