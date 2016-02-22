//
//  CXController.m
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXController.h"

@implementation CXController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init])
    {
        self.rootViewController = rootViewController;
    }
    
    return self;
}

@end
