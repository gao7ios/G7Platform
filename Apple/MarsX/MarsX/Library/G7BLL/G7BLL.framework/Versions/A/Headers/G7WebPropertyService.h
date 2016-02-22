//
//  G7WebPropertyService.h
//  PhoneTool
//
//  Created by luzhx on 15/11/16.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G7WebPropertyService : NSObject

AS_SINGLETON( G7WebPropertyService )

- (NSString *)g7WebPropertyVersion;

- (void)setDefaultProperty:(UIWebView *)webView;

- (void)propertyWithUrl:(NSString *)url  andWebView:(UIWebView *)webView;

@end
