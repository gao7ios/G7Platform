//
//  G7CommonWebView.h
//  G7BLL
//
//  Created by WangMingfu on 15/1/31.
//  Copyright (c) 2015年 gao7. All rights reserved.
//

#import <G7Core/G7.h>

#import "G7ShareObject.h"

@interface G7CommonWebView : G7WebView

@property (weak, readwrite, nonatomic) id <G7WebViewDelegate> proxydelegate;

@property (strong, readwrite, nonatomic) G7ShareObject *shareObject;

@end
