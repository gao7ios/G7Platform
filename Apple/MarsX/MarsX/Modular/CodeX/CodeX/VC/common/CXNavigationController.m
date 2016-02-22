//
//  CXNavigationController.m
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXNavigationController.h"

@interface CXNavigationController ()

@end

@implementation CXNavigationController

- (void)loadView
{
    [super loadView];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = CXNavBarBackgroundColor;
    self.navigationBar.translucent = NO;
    self.navigationBar.barStyle = UIBarStyleBlack;
}

@end
