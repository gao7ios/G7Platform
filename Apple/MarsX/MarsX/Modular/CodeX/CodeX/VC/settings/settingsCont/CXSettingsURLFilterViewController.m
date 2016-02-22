//
//  CXSettingsURLFilterViewController.m
//  CodeX
//
//  Created by yuyang on 14-12-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsURLFilterViewController.h"
#import "CXTableView.h"

@interface CXSettingsURLFilterViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) CXTableView *tableView;

@end

@implementation CXSettingsURLFilterViewController

- (void)loadView
{
    [super loadView];
    
    self.title = @"打开方式";
    
    self.dataSource = [NSMutableArray arrayWithObjects:CXWebOpenNavPushKey,CXWebOpenModalPresentKey, nil];
    
    self.tableView = [[CXTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction:)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
}

- (void)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - delegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tableViewCellID"];
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - delegate UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self.dataSource objectAtIndex:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(choicedOpenTypeWithText:)])
    {
        [self.delegate choicedOpenTypeWithText:text];
    }
    
}

@end
