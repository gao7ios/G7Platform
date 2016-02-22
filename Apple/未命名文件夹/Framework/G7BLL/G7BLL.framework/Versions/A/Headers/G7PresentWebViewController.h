//
//  G7PresentWebViewController.h
//  G7BLL
//
//  Created by WangMingfu on 15/1/29.
//  Copyright (c) 2015年 gao7. All rights reserved.
//

#import <G7Core/G7.h>

@interface G7PresentWebViewController : G7ViewController

- (instancetype)initWithWebReqeustURL:(NSString *)reqeustURLString;

@property (strong, readonly, nonatomic) G7CommonWebView *webView;

/// 设置是否在viewwillappear时候，自动刷新.
@property (nonatomic, readwrite, assign) BOOL autoRefreshWhenViewWillAppear;

@end
