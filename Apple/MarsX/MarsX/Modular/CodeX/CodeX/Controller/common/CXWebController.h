//
//  CXWebController.h
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXController.h"

@interface CXWebController : CXController
<
UIWebViewDelegate
>

@property (nonatomic, strong) NSString *originalURL;

- (id)initWithRootViewController:(UIViewController *)rootViewController originalUrl:(NSString *)url;

@end
