//
//  CXSettingsContViewController.m
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsContViewController.h"
#import "CXTableView.h"
#import "CXSettingsContTableViewCell.h"
#import "CXKeyValueType.h"

@interface CXSettingsContViewController()
<
UIAlertViewDelegate
>

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation CXSettingsContViewController

- (id)initWithItemType:(CXSettingsItemType)itemType
{
    if (self = [super init])
    {
        self.settingsContController = [[CXSettingsContController alloc] initWithRootViewController:self];
        self.settingsContController.itemType = itemType;
        self.settingsContController.tableViewCellID = @"CXSettingsContTableViewCellID";
        NSMutableArray *arr = [[CXSettingsModel shareInstance] itemsWithItemType:itemType];
        for (NSArray *item in arr)
        {
            CXKeyValueType *keyValueType = [[CXKeyValueType alloc] initWithParams:@[item[0],item[1],[NSNumber numberWithInteger:itemType],@"参数名",@"值"]];
            [self.settingsContController.dataSource addObject:keyValueType];
        }
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CXTableView *tableView = [[CXTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CXNavBarHeight-CXToolBarHeight) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[CXSettingsContTableViewCell class] forCellReuseIdentifier:self.settingsContController.tableViewCellID];
    [self.view addSubview:tableView];
    self.settingsContController.tableView = tableView;
    
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(-1, CGRectGetMaxY(self.settingsContController.tableView.frame), CGRectGetWidth(self.view.frame)+2, CXToolBarHeight+2)];
    self.addButton.layer.borderColor = [CXTools colorFromString:@"cccccc"].CGColor;
    self.addButton.layer.borderWidth = 1.0f;
    [self.addButton setImage:[UIImage imageNamed:@"cx_btn_add"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addButton];
    
    UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = editBarButton;
}

- (void)addButtonAction:(id)sender
{
    if (self.settingsContController.tableView.editing)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意" message:@"将会删除所有设置信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else
    {
        CXKeyValueType *keyValueType = [[CXKeyValueType alloc] initWithParams:@[@"",@"", [NSNumber numberWithInteger:self.settingsContController.itemType],@"参数名",@"值"]];
        if (self.settingsContController.itemType == CXSettingsItemTypeURLFilter)
        {
            keyValueType = [[CXKeyValueType alloc] initWithParams:@[@"",@"", [NSNumber numberWithInteger:self.settingsContController.itemType],@"参数名",@"点击选择打开方式"]];
        }
        
        [self.settingsContController pushSettingsDetailViewControllerWith:keyValueType index:self.settingsContController.dataSource.count];
    }
}

- (void)editBarButtonAction:(id)sender
{
    UITableView *tableView = self.settingsContController.tableView;
    [tableView setEditing:!tableView.editing animated:YES];
    if (tableView.editing)
    {
        self.navigationItem.rightBarButtonItem.title = @"完成";
       [self.addButton setImage:[UIImage imageNamed:@"cx_btn_clear"] forState:UIControlStateNormal];
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        [self.addButton setImage:[UIImage imageNamed:@"cx_btn_add"] forState:UIControlStateNormal];
    }
}

#pragma mark - delegate UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        self.settingsContController.dataSource = [NSMutableArray array];
        [self.settingsContController.tableView reloadData];
        [self.settingsContController updateModelList];
        [[CXSettingsModel shareInstance] updateData];
    }
}

@end
