//
//  CXQRCodeView.m
//  NewCodeX
//
//  Created by mac on 14-3-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "CXQRCodeView.h"
#import "CXWebViewController.h"
#import "CXQRCodeResultType.h"

#define scanHistoryIdentifier @"scanHistory"
#define TIMEDELAY 5.0

@interface CXQRCodeView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIButton *cancelScanBtn;
@property (strong, nonatomic) UITableView *scanHistoryTableView;
@property (strong, nonatomic) NSMutableArray *scanResults;

- (void)cancelScanBtnAction;

@end

@implementation CXQRCodeView

- (id)initWithDelegate:(id)delegate
                 frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = delegate;
        [self initialViews];
    }
    return self;
}

- (void)initialViews
{
    //加入取消扫描的按钮
    self.cancelScanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-39, [[UIScreen mainScreen] bounds].size.width, 39)];
    [self.cancelScanBtn setTitle:@"返回" forState:UIControlStateNormal];
    self.cancelScanBtn.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    [self.cancelScanBtn setBackgroundImage:[UIImage imageNamed:@"historyclear.png"]
                                  forState:UIControlStateNormal];
    [self.cancelScanBtn setBackgroundImage:[UIImage imageNamed:@"historyclear_hig.png"]
                                  forState:UIControlStateSelected];
    [self.cancelScanBtn addTarget:self
                           action:@selector(cancelScanBtnAction)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.cancelScanBtn];
    
    //扫描历史记录列表
    self.scanHistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 60, 300, 130)];
    self.scanHistoryTableView.backgroundColor = [UIColor clearColor];
    [self.scanHistoryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.scanHistoryTableView.scrollEnabled = NO;
    self.scanHistoryTableView.delegate = self;
    self.scanHistoryTableView.dataSource = self;
    [self addSubview:self.scanHistoryTableView];
    
    //扫描历史记录列表数据
    self.scanResults = [NSMutableArray array];
    
    //遍历列表时间生成
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(checkTimeoutResult)
                                                    userInfo:nil
                                                     repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)checkTimeoutResult
{
    double now = [[NSDate date] timeIntervalSince1970];

    for (int i=0;i<[self.scanResults count];i++)
    {
        CXQRCodeResultType *result = self.scanResults[i];
        if ((now - result.scanTime)>=TIMEDELAY)
        {
            [self.scanResults removeObject:result];
            [self reloadRows:[self.scanResults indexOfObject:result]
                   animation:UITableViewRowAnimationTop];
        }
    }
    [self.scanHistoryTableView reloadData];
}

- (void)cancelScanBtnAction
{
    [self.delegate cancelScan];
}

- (void)reloadRows:(NSUInteger)index animation:(UITableViewRowAnimation)animation
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.scanHistoryTableView reloadRowsAtIndexPaths:@[indexPath]
                                     withRowAnimation:animation];
}

- (void)addQRResult:(NSString *)QRResultURL
{
    CXQRCodeResultType *newResult = [[CXQRCodeResultType alloc] init];
    newResult.qrResultURL = QRResultURL;
    newResult.scanTime = [[NSDate date] timeIntervalSince1970];
    [self.scanResults addObject:newResult];
    AudioServicesPlaySystemSound(1305);
    [self.scanHistoryTableView reloadData];
    [self reloadRows:[self.scanResults count]-1 animation:UITableViewRowAnimationFade];
}

- (void)receiveQRResult:(NSString *)returningURL
{
    int meetCount = 0;
    
    if ([self.scanResults count] > 0)
    {
        for (int i=0;i<[self.scanResults count];i++)
        {
            CXQRCodeResultType *result = self.scanResults[i];
            if ([result.qrResultURL isEqualToString:returningURL])
            {
                result.scanTime = [[NSDate date] timeIntervalSince1970];
                meetCount++;
            }
        }
        
        if (meetCount == 0)
        {
            [self addQRResult:returningURL];
            
            if ([self.scanResults count] > 3)
            {
                [self.scanResults removeObjectAtIndex:0];
                [self.scanHistoryTableView reloadData];
                [self reloadRows:0 animation:UITableViewRowAnimationTop];
            }
        }
    }
    else
    {
        [self addQRResult:returningURL];
    }
}

- (void)cleanQRResult
{
    [self.scanResults removeAllObjects];
    [self.scanHistoryTableView reloadData];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scanResults count];
}

#pragma mark -UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scanHistoryIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:scanHistoryIdentifier];
    }
    
    CXQRCodeResultType *result = self.scanResults[indexPath.row];
    cell.textLabel.text = result.qrResultURL;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:FontSize];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXQRCodeResultType *result = [self.scanResults objectAtIndex:indexPath.row];
    NSString *targetURL = result.qrResultURL;
    if (targetURL != nil)
    {
        [self.delegate selectScanResult:targetURL];
        [self.delegate cancelScan];
    }
}

@end
