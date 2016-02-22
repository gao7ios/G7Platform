//
//  CXSettingsViewController.m
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsViewController.h"
#import "CXSettingsMenuType.h"
#import "CXSettingsController.h"
#import "CXTableView.h"
#import "CXTableViewCell.h"

@interface CXSettingsViewController()

@property (nonatomic, strong) CXSettingsController *settingsController;

@end

@implementation CXSettingsViewController

- (void)loadView
{
    [super loadView];
    
    self.title = @"设置";
    
    self.settingsController = [[CXSettingsController alloc] initWithRootViewController:self];
    self.settingsController.tableViewCellID = @"CXSettingsViewCellID";
    
    CXTableView *tableView = [[CXTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CXNavBarHeight) style:UITableViewStylePlain];
    [tableView registerClass:[CXTableViewCell class] forCellReuseIdentifier:self.settingsController.tableViewCellID];
    [self.view addSubview:tableView];
    self.settingsController.tableView = tableView;
}

@end
