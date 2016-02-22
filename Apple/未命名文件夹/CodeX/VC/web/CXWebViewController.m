//
//  CXWebViewController.m
//  TextCodeX
//
//  Created by mac on 14-2-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXWebViewController.h"
#import "CXWebView.h"
#import "CXURLHandler.h"
#import "CXBrowserWebController.h"

@interface CXWebViewController () <CXBrowserWebControllerDelegate>

@property (nonatomic, strong) CXWebView *webView;
@property (nonatomic, strong) CXBrowserWebController *webController;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIBarButtonItem *refreshBtn;

@end

@implementation CXWebViewController

#pragma mark - * [初始化]

- (id)initWithURL:(NSString *)url
{
    if (self = [super init])
    {
        self.url = [CXURLHandler cleanURL:url];
        self.webController = [[CXBrowserWebController alloc] initWithRootViewController:self originalUrl:(NSString *)url];
        self.webController.delegate = self;
    }
    
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView stopLoading];
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.refreshBtn != nil && self.titleLab != nil)
    {
        self.navigationItem.rightBarButtonItem = self.refreshBtn;
        self.navigationItem.titleView = self.titleLab;
    }
}

- (void)loadView
{
    [super loadView];
    
    self.refreshBtn = [[UIBarButtonItem alloc] initWithTitle:@"刷新"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(refreshWeb)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = self.refreshBtn;
    
    if (self.titleLab == nil)
    {
        CGRect navTitleViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame)-2*50, 39);
        self.titleLab = [[UILabel alloc] initWithFrame:navTitleViewFrame];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.center = CGPointMake(160, self.navigationController.navigationBar.frame.size.height / 2);
        self.navigationItem.titleView = self.titleLab;
    }
    
    self.webView = [[CXWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CXNavBarHeight)];
    self.webView.delegate = self.webController;
    [self.view addSubview:_webView];
    
    [self.webView openURL:self.url];
}

- (void)refreshWeb
{
    [self.webView reload];
}

- (void)navCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - delegate CXBrowserWebControllerDelegate

- (void)browserWebController:(CXBrowserWebController *)browserWebController titleFinished:(NSString *)title
{    
    self.titleLab.text = title;
}

@end