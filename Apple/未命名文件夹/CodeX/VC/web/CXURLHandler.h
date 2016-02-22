//
//  CXURLHandler.h
//  TextCodeX
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

@interface CXURLHandler : NSObject

+ (BOOL)handle:(UIViewController *)rootViewController
     targetURL:(NSString *)targetURL
   originalURL:(NSString *)originalURL
navigationType:(UIWebViewNavigationType)navigationType;

+ (NSString *)cleanURL:(NSString *)url;

+ (NSString *)headMetaToBase64;

@end
