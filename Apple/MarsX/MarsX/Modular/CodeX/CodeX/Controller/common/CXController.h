//
//  CXController.h
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXController : NSObject

@property (nonatomic, strong) UIViewController *rootViewController;

- (id)initWithRootViewController:(UIViewController *)rootViewController;

@end
