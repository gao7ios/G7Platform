//
//  CXSettingsDetailViewController.m
//  CodeX
//
//  Created by yuyang on 14-12-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsDetailViewController.h"
#import "CXTableView.h"
#import "CXSettingsDetailController.h"
#import "CXSettingsDetailTableViewCell.h"

@interface CXSettingsDetailViewController()

@property (nonatomic, strong) CXSettingsDetailController *detailController;

@end

@implementation CXSettingsDetailViewController

- (id)initWith:(CXKeyValueType *)keyValueType
{
    if (self = [super init])
    {
        [self inititalViews];
        self.keyValueType = keyValueType;
    }
    
    return self;
}

- (void)inititalViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction:)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *confirmButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmButtonAction:)];
    self.navigationItem.rightBarButtonItem = confirmButtonItem;
    
    self.detailController = [[CXSettingsDetailController alloc] initWithRootViewController:self];
    CXTableView *tableView = [[CXTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[CXSettingsDetailTableViewCell class] forCellReuseIdentifier:self.detailController.tableViewCellID];
    [self.view addSubview:tableView];
    self.detailController.tableView = tableView;
}

- (void)setKeyValueType:(CXKeyValueType *)keyValueType
{
    _keyValueType = keyValueType;
    if (keyValueType)
    {
        self.detailController.dataSource = [NSMutableArray arrayWithObjects:@[keyValueType.keyName,keyValueType.keyNameDesc], @[keyValueType.value,keyValueType.valueDesc], nil];
        self.detailController.itemType = keyValueType.itemType;
    }
}

- (void)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmButtonAction:(id)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CXSettingsDetailTableViewCell *cell = (CXSettingsDetailTableViewCell *)[self.detailController.tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.text isEqualToString:@""] || (![cell.text isEqualToString:self.keyValueType.keyName] && [[CXSettingsModel shareInstance] checkWithKeyName:cell.text itemType:self.detailController.itemType]))
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"参数名不能为空或者重复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(settingsDetailViewController:confirmData:)])
        {
            NSString *keyName;
            NSString *value;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            CXSettingsDetailTableViewCell *cell = (CXSettingsDetailTableViewCell *)[self.detailController.tableView cellForRowAtIndexPath:indexPath];
            keyName = cell.text;
            indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
            cell = (CXSettingsDetailTableViewCell *)[self.detailController.tableView cellForRowAtIndexPath:indexPath];
            value = cell.text;
            
            CXKeyValueType *keyValueType = [[CXKeyValueType alloc] initWithParams:@[keyName,value,[NSNumber numberWithInteger:self.keyValueType.itemType], self.keyValueType.keyNameDesc,self.keyValueType.valueDesc]];
            [self.delegate settingsDetailViewController:self confirmData:keyValueType];
        }
    }
}

@end
