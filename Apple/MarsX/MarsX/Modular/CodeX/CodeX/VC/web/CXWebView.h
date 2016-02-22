//
//  BaseWebView.h
//  TextCodeX
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#define CXWebRefreshHeight 60.0

@protocol CXWebViewDelegate <NSObject>

- (void)willStartFresh;

@end

@interface CXWebView : UIWebView

- (void)openURL:(NSString *)url;

@end
