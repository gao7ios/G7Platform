//
//  CXWebController.m
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXWebController.h"

@implementation CXWebController

- (id)initWithRootViewController:(UIViewController *)rootViewController originalUrl:(NSString *)url
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        self.originalURL = url;
    }
    
    return self;
}

@end
