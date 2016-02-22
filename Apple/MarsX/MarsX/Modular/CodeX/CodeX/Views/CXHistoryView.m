//
//  CXHistoryView.m
//  NewCodeX
//
//  Created by mac on 14-3-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXHistoryView.h"
#import "CXWebViewController.h"


@interface CXHistoryView() <UITableViewDelegate,UITableViewDataSource,CXHistoryURLStoreDelegate>

@property (strong, nonatomic) CXHistoryModel *historyURLs;
@property (strong, nonatomic) NSIndexPath *lastSelectionIndexPath;

@end

static NSString *kHistoryViewReusableCellID = @"historyViewReusableCellID";

@implementation CXHistoryView

- (id)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame])
    {
        self.delegate = self;
        self.dataSource = self;
        self.historyURLs = [[CXHistoryModel alloc]init];
        self.separatorColor = CXTableViewSeperatorColor;
        self.backgroundColor = CXTableViewBackgroundColor;
    }
    
    return self;
}

#pragma mark -HistoryReloadDelegate

- (void)historyReload
{
    [self reloadData];
}

#pragma mark -UITableViewDataSource-cellForRowAtIndexPath

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHistoryViewReusableCellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kHistoryViewReusableCellID];
    }
    
    NSString *title = [[CXHistoryModel shareInstance] getHistoryTypeTitle:indexPath.row];
    title = [title isEqualToString:@""]?@"(无标题)":title;
    cell.backgroundColor = CXTableViewCellBackgroundColor;
    cell.textLabel.text = title;
    cell.textLabel.font = CXTableViewCellTextFont;
    cell.textLabel.textColor = CXDarkColor;
    cell.detailTextLabel.text = [[CXHistoryModel shareInstance] getHistoryTypeURL:indexPath.row];
    cell.detailTextLabel.textColor = CXLightColor;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[CXHistoryModel shareInstance] removeHistoryType:indexPath.row];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark -UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *title = [self cellForRowAtIndexPath:indexPath].textLabel.text;
    NSString *url = [self cellForRowAtIndexPath:indexPath].detailTextLabel.text;

    [self.historyDelegate cellOptionsTrigger:title url:url];
    
    if (self.lastSelectionIndexPath != nil)
    {
        [self cellForRowAtIndexPath:self.lastSelectionIndexPath].selectionStyle = UITableViewCellSelectionStyleNone;
        [self cellForRowAtIndexPath:self.lastSelectionIndexPath].selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    self.lastSelectionIndexPath = indexPath;
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{

    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = [[CXHistoryModel shareInstance] getHistoryTypeURL:indexPath.row];
    [self.historyDelegate urlSelected:url];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSUInteger count = [[CXHistoryModel shareInstance] count];
    
    return count;
}


@end
