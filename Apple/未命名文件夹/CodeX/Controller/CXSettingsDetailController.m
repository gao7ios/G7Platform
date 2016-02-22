//
//  CXSettingsDetailController.m
//  CodeX
//
//  Created by yuyang on 14-12-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsDetailController.h"
#import "CXSettingsDetailTableViewCell.h"
#import "CXSettingsURLFilterViewController.h"
#import "CXNavigationController.h"
#import "CXSettingsDetailViewController.h"

@interface CXSettingsDetailController()
<
CXSettingsURLFilterViewControllerDelegate
>

@end

@implementation CXSettingsDetailController

#pragma mark - delegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXSettingsDetailTableViewCell *cell = [[CXSettingsDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.tableViewCellID];
    
    cell.text = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:0];
    cell.placeholder = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:1];
    if (self.itemType == CXSettingsItemTypeURLFilter && indexPath.section == 1)
    {
        cell.enable = NO;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

#pragma mark - delegate UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemType == CXSettingsItemTypeURLFilter && indexPath.section == 1)
    {
        CXSettingsURLFilterViewController *urlFilterViewController = [[CXSettingsURLFilterViewController alloc] init];
        urlFilterViewController.delegate = self;
        CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:urlFilterViewController];
        [self.rootViewController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 30.0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - delegate CXSettingsURLFilterViewControllerDelegate

- (void)choicedOpenTypeWithText:(NSString *)text
{
    NSArray *valueArr = [NSArray arrayWithObjects:text, @"参数", nil];
    [self.dataSource  replaceObjectAtIndex:1 withObject:valueArr];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    CXSettingsDetailTableViewCell *cell = (CXSettingsDetailTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.text = text;
}

@end
