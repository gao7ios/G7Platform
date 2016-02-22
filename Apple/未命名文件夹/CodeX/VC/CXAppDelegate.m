//
//  BaseAppDelegate.m
//  NewCodeX
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 YuYang. All rights reserved.
//

#import "CXAppDelegate.h"
#import "CXHomeViewController.h"
#import "CXHistoryModel.h"
#import "CXNavigationController.h"

@interface CXAppDelegate()

@end

@implementation CXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"g7IdfaStr"];
    CXHomeViewController *rootViewController = [[CXHomeViewController alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.rootViewController = [[CXNavigationController alloc] initWithRootViewController:rootViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[CXHistoryModel shareInstance] storeHistoryTypeArray];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"g7IdfaStr"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[CXSettingsModel shareInstance] updateData];
}

@end
