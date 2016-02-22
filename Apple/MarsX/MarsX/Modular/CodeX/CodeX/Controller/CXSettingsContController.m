//
//  CXSettingsContController.m
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsContController.h"
#import "CXSettingsContTableViewCell.h"
#import "CXSettingsDetailViewController.h"
#import "CXNavigationController.h"

@interface CXSettingsContController()
<
CXSettingsDetailViewControllerDelegate
>

@property (nonatomic, strong) UIViewController *rootViewController;

@end

@implementation CXSettingsContController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        self.rootViewController = rootViewController;
    }
    
    return self;
}

- (void)pushSettingsDetailViewControllerWith:(CXKeyValueType *)keyValueType index:(NSInteger)index
{
    CXSettingsDetailViewController *settingsDetailViewController = [[CXSettingsDetailViewController alloc] initWith:keyValueType];
    settingsDetailViewController.delegate = self;
    settingsDetailViewController.index = index;
    settingsDetailViewController.title = @"添加参数";
    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:settingsDetailViewController];
    [self.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)updateModelList
{
    NSMutableArray *newModelList = [NSMutableArray array];
    for (CXKeyValueType *keyValueType in self.dataSource)
    {
        NSArray *arr = [NSArray arrayWithObjects:keyValueType.keyName, keyValueType.value,nil];
        [newModelList addObject:arr];
    }
    
    [[CXSettingsModel shareInstance] updateItemWith:newModelList itemType:self.itemType];
}

#pragma mark - delegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXSettingsContTableViewCell *cell = (CXSettingsContTableViewCell *)[tableView dequeueReusableCellWithIdentifier:self.tableViewCellID];
    if (cell == nil)
    {
        cell = [[CXSettingsContTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.tableViewCellID];
    }
    
    CXKeyValueType *keyValueType = [self.dataSource objectAtIndex:indexPath.row];
    cell.keyValueType = keyValueType;
    
    return cell;
}

#pragma mark - delegate UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXKeyValueType *keyValueType = [self.dataSource objectAtIndex:indexPath.row];
    [self pushSettingsDetailViewControllerWith:keyValueType index:indexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self updateModelList];
        [[CXSettingsModel shareInstance] updateData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSInteger sourceRow = sourceIndexPath.row;
    NSInteger destRow = destinationIndexPath.row;
    id object = [self.dataSource objectAtIndex:sourceRow];
    
    [self.dataSource removeObjectAtIndex:sourceRow];
    [self.dataSource insertObject:object atIndex:destRow];
    
    [self updateModelList];
    [[CXSettingsModel shareInstance] updateData];
}

#pragma mark - delegate CXSettingsDetailViewControllerDelegate

- (void)settingsDetailViewController:(CXSettingsDetailViewController *)settingsDetailViewController confirmData:(CXKeyValueType *)keyValueType
{
    NSInteger index = settingsDetailViewController.index;
    if (self.dataSource.count == 0)
    {
        [self.dataSource addObject:keyValueType];
    }
    else
    {
        if (index < self.dataSource.count)
        {
            [self.dataSource replaceObjectAtIndex:index withObject:keyValueType];
        }
        else
        {
            [self.dataSource insertObject:keyValueType atIndex:index];
        }
    }
    
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [settingsDetailViewController dismissViewControllerAnimated:YES completion:nil];
    [self updateModelList];
    [[CXSettingsModel shareInstance] updateData];
}

@end
