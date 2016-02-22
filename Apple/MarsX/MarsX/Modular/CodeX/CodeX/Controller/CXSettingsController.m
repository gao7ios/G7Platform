//
//  CXSettingsCore.m
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsController.h"
#import "CXSettingsContViewController.h"

@implementation CXSettingsController

#pragma mark - * [初始化]

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init])
    {
        self.dataSource = [NSMutableArray arrayWithObjects:
                                                                 @[@"头部参数",@"设置http头部参数"],
                                                                 @[@"隐藏域",@"设置指定的url隐藏域和对应的页面推出方式"],
                                                                 @[@"默认快捷访问",@"设置默认的首页列表的链接"],
//                                                                 @[@"通知栏快捷访问",@"设置通知栏快捷访问（仅支持iOS8及以上）"],
                                                                 @[@"点击复制idfa", [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]],
                                                                 nil];
        self.rootViewController = rootViewController;
    }
    
    return self;
}

#pragma mark - functions

- (void)triggerSettingAtIndex:(NSInteger)index
{
    if (index == 3) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
        [G7UIHelpers showStatusWithCompletedText:@"复制成功"];
    }
    else {
        CXSettingsContViewController *settingsContViewController = settingsContViewController = [[CXSettingsContViewController alloc] initWithItemType:index];
        settingsContViewController.title = self.dataSource[index][0];
        [self.rootViewController.navigationController pushViewController:settingsContViewController animated:YES];
    }
    
}

#pragma mark - delegate UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.tableViewCellID];
    
    NSArray *arr = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = arr[0];
    cell.detailTextLabel.text = arr[1];
    
    cell.backgroundColor = CXTableViewCellBackgroundColor;
    cell.textLabel.font = CXTableViewCellTextFont;
    cell.textLabel.textColor = CXDarkColor;
    cell.detailTextLabel.textColor = CXLightColor;

    return cell;
}

#pragma mark - delegate UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self triggerSettingAtIndex:indexPath.row];
}

@end
