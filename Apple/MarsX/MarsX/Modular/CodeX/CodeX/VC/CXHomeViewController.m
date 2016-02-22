//
//  CXHomeViewController.m
//  TextCodeX
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXURLHandler.h"
#import "CXWebViewController.h"

#import "CXHomeURLInputView.h"
#import "CXHomeViewController.h"
#import "CXHistoryView.h"
#import "CXHistoryModel.h"
#import "CXQRCodeViewController.h"
#import "CXSettingsViewController.h"

@interface CXHomeViewController () <CXHistoryViewDelegate,CXURLInputDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) CXHistoryView *historyURLView;
@property (strong, nonatomic) UIButton *maskLayerView;
@property (strong, nonatomic) CXHomeURLInputView *homeURLInputView;
@property (strong, nonatomic) CXQRCodeViewController *qrViewController;
@property (strong, nonatomic) UIButton * tableCellOptions;
@property (strong, nonatomic) UIButton * getTitleBtn;
@property (strong, nonatomic) UIButton * getURLBtn;
@property (strong, nonatomic) NSMutableArray * currentTitleAndURL;

@end

@implementation CXHomeViewController

- (void)loadView
{
    [super loadView];

    self.view.backgroundColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.0];
    self.currentTitleAndURL = [NSMutableArray array];
    [self initialViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    [self.historyURLView reloadData];
}

- (void)initialViews
{
    //地址栏生成
    self.homeURLInputView = [[CXHomeURLInputView alloc] init];
    self.homeURLInputView.delegate = self;
    self.navigationItem.titleView = self.homeURLInputView;

    //历史记录生成
    self.historyURLView = [[CXHistoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-74-30)];
    self.historyURLView.historyDelegate = self;
    [self.view addSubview:self.historyURLView];
    
    //清空按钮
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(-1, self.view.frame.size.height-104, self.view.frame.size.width*0.5, 41)];
    [clearButton setImage:[UIImage imageNamed:@"cx_btn_clear"] forState:UIControlStateNormal];
    clearButton.layer.borderColor = [CXTools colorFromString:@"cccccc"].CGColor;
    clearButton.layer.borderWidth = 1.0f;
    clearButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    [clearButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    clearButton.backgroundColor = [UIColor whiteColor];
    
    [clearButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
    
    //设置按钮
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clearButton.frame)-1, CGRectGetMinY(clearButton.frame), self.view.frame.size.width*0.5+3, 41)];
    settingsButton.layer.borderColor = [CXTools colorFromString:@"cccccc"].CGColor;
    [settingsButton setImage:[UIImage imageNamed:@"cx_btn_settings"] forState:UIControlStateNormal];
    settingsButton.layer.borderWidth = 1.0f;
    settingsButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    [settingsButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    settingsButton.backgroundColor = [UIColor whiteColor];
    
    [settingsButton addTarget:self action:@selector(settingsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingsButton];
    
    self.tableCellOptions = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableCellOptions.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.tableCellOptions addTarget:self action:@selector(tableCellOptionsDisappear) forControlEvents:UIControlEventTouchDown];
    
    UIButton *getTitleBtn = [[UIButton alloc] initWithFrame:CGRectMake((CXScreenWidth-280)*0.5, 150, 280, 45)];
    getTitleBtn.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    [getTitleBtn addTarget:self action:@selector(copyTitle) forControlEvents:UIControlEventTouchUpInside];
    [getTitleBtn setTitle:@"复制标题" forState:UIControlStateNormal];
    [getTitleBtn setTitleColor:[UIColor colorWithRed:78.0/255.0 green:83.0/255.0 blue:95.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    getTitleBtn.layer.cornerRadius = 1.0f;
    
    UIButton *getURLBtn = [[UIButton alloc] initWithFrame:CGRectMake((CXScreenWidth-280)*0.5, 196, 280, 45)];
    getURLBtn.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    [getURLBtn addTarget:self action:@selector(copyURL) forControlEvents:UIControlEventTouchUpInside];
    [getURLBtn setTitle:@"复制链接" forState:UIControlStateNormal];
    [getURLBtn setTitleColor:[UIColor colorWithRed:78.0/255.0 green:83.0/255.0 blue:95.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    getURLBtn.layer.cornerRadius = 1.0f;
    
    UIButton *addBookmarkBtn = [[UIButton alloc] initWithFrame:CGRectMake((CXScreenWidth-280)*0.5, CGRectGetMaxY(getURLBtn.frame)+1, 280, 45)];
    addBookmarkBtn.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    [addBookmarkBtn addTarget:self action:@selector(addBookmark:) forControlEvents:UIControlEventTouchUpInside];
    [addBookmarkBtn setTitle:@"添加默认快捷访问" forState:UIControlStateNormal];
    [addBookmarkBtn setTitleColor:[UIColor colorWithRed:78.0/255.0 green:83.0/255.0 blue:95.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    addBookmarkBtn.layer.cornerRadius = 1.0f;
    
    UIButton *addTodayBookmarkBtn = [[UIButton alloc] initWithFrame:CGRectMake((CXScreenWidth-280)*0.5, CGRectGetMaxY(addBookmarkBtn.frame)+1, 280, 45)];
    addTodayBookmarkBtn.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    [addTodayBookmarkBtn addTarget:self action:@selector(addTodayBookmark:) forControlEvents:UIControlEventTouchUpInside];
    [addTodayBookmarkBtn setTitle:@"添加通知栏快捷访问" forState:UIControlStateNormal];
    [addTodayBookmarkBtn setTitleColor:[UIColor colorWithRed:78.0/255.0 green:83.0/255.0 blue:95.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    addTodayBookmarkBtn.layer.cornerRadius = 1.0f;
    
    [self.tableCellOptions addSubview:getTitleBtn];
    [self.tableCellOptions addSubview:getURLBtn];
    [self.tableCellOptions addSubview:addBookmarkBtn];
//    [self.tableCellOptions addSubview:addTodayBookmarkBtn];
    
    self.tableCellOptions.alpha = 0.0;
    [self.view addSubview:self.tableCellOptions];
}

- (void)clearButtonAction:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除确认"
                                                        message:@"删除后所有历史记录将无法恢复？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"删除", nil];
    [alertView show];
}

- (void)settingsButtonAction:(id)sender
{
    CXSettingsViewController *settingsViewController = [[CXSettingsViewController alloc] init];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)reloadRows:(NSUInteger)index animation:(UITableViewRowAnimation)animation
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.historyURLView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"删除"])
    {
        for (int i=0; i<[[CXHistoryModel shareInstance] count]; i++)
        {
            [self reloadRows:i animation:UITableViewRowAnimationRight];
        }
        [[CXHistoryModel shareInstance] cleanHistoryTypeArray];
        [[CXHistoryModel shareInstance] storeHistoryTypeArray];
        [self.historyURLView historyReload];
    }
}

- (void)maskFadeOut
{
    if (self.maskLayerView)
    {
        self.maskLayerView.alpha = 0.0;
    }
    
    [self.homeURLInputView keyboardHide];
}

- (void)openWeb:(NSString *)url
{
    CXWebViewController *webViewController = [[CXWebViewController alloc] initWithURL:url];
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - delegate URLInputDelegate

- (void)triggerInput
{
    if (self.maskLayerView == nil)
    {
        self.maskLayerView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.maskLayerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.maskLayerView addTarget:self action:@selector(maskFadeOut) forControlEvents:UIControlEventTouchDown];
        self.maskLayerView.alpha = 0.0;
        [self.view addSubview:self.maskLayerView];
        [UIView animateWithDuration:0.5 animations:^
        {
            self.maskLayerView.alpha = 1.0;
        }];
    }
    else
    {
        if (self.maskLayerView.alpha == 0.0)
        {
            self.maskLayerView.alpha = 0.0;
            [UIView animateWithDuration:0.5
                             animations:^{
                                 self.maskLayerView.alpha = 1.0;
                             }];
        }
    }
}

- (void)openQRCode
{
    if (self.qrViewController == nil)
    {
        self.qrViewController = [[CXQRCodeViewController alloc] init];
        __weak UIViewController *weakSelf = self;
        [self.qrViewController setReturningURLProcess:^(NSString *url)
        {
            CXWebViewController *webViewController = [[CXWebViewController alloc] initWithURL:url];
            [weakSelf.navigationController pushViewController:webViewController animated:YES];
        }];
    }
    
    [self presentViewController:self.qrViewController animated:YES completion:nil];
}

- (void)openURL:(NSString *)url
{
    [self openWeb:url];
}

#pragma mark - delegate HistoryDelegate

- (void)urlSelected:(NSString *)url
{
    [self openWeb:url];
}

- (void)cellOptionsTrigger:(NSString *)title url:(NSString *)url
{
    self.currentTitleAndURL[0] = title;
    self.currentTitleAndURL[1] = url;
    self.tableCellOptions.alpha = 1.0;
}

#pragma mark - * functions

- (void)tableCellOptionsDisappear
{
    self.tableCellOptions.alpha = 0.0;
}

- (void)copyTitle
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:self.currentTitleAndURL[0]];
    self.tableCellOptions.alpha = 0.0;
}

- (void)copyURL
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:self.currentTitleAndURL[1]];
    self.tableCellOptions.alpha = 0.0;
}

- (void)addBookmark:(id)sender
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[[CXSettingsModel shareInstance].settingsProfile valueForKey:CXSettingsItemKeyHomeShortcuts]];
    BOOL validate = YES;
    for (NSArray *item in arr)
    {
        if ([item[0] isEqualToString: self.currentTitleAndURL[0]])
        {
            validate = NO;
        }
    }
    
    if (validate)
    {
        [arr addObject:self.currentTitleAndURL];
        [[CXSettingsModel shareInstance] updateItemWith:arr itemType:CXSettingsItemTypeHomeShortcuts];
        [[CXSettingsModel shareInstance] updateData];
    }
    
    self.tableCellOptions.alpha = 0.0;
}

- (void)addTodayBookmark:(id)sender
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[[CXSettingsModel shareInstance].settingsProfile valueForKey:CXSettingsItemKeyTodayShortcuts]];
    
    BOOL validate = YES;
    for (NSArray *item in arr)
    {
        if ([item[0] isEqualToString: self.currentTitleAndURL[0]])
        {
            validate = NO;
        }
    }
    
    if (validate)
    {
        [arr addObject:self.currentTitleAndURL];
        [[CXSettingsModel shareInstance] updateItemWith:arr itemType:CXSettingsItemTypeTodayShortcuts];
        [[CXSettingsModel shareInstance] updateData];
    }
    
    self.tableCellOptions.alpha = 0.0;
}

@end