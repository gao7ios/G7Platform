//
//  BaseQRCodeViewController.m
//  NewCodeX
//
//  Created by mac on 14-3-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "CXQRCodeViewController.h"
#import "CXWebViewController.h"
#import "CXQRCodeView.h"

@interface CXQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,CXQRCodeDelegate>

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) CXQRCodeView *qrCodeView;
@property (strong, nonatomic) UIView *scanBound;

@end

@implementation CXQRCodeViewController

- (void)loadView
{
    [super loadView];
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device
                                                       error:&error];

    if (error)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意"
                                                            message:@"相机不存在"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    self.output = [[AVCaptureMetadataOutput alloc] init];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc] init];
    
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.previewLayer setFrame:self.view.bounds];
    [self.view.layer insertSublayer:self.previewLayer atIndex:1];
    
    self.qrCodeView = [[CXQRCodeView alloc] initWithDelegate:self
                                                     frame:CGRectMake(0, 0, 320, 558)];
    [self.view addSubview:self.qrCodeView];

    self.scanBound = [[UIView alloc]init];
    [self.view addSubview:self.scanBound];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.session startRunning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}

- (void)cancelScan
{
    [self.qrCodeView cleanQRResult];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && metadataObjects.count > 0)
    {
        NSString *returningURL = [metadataObjects[0] stringValue];
        [self.qrCodeView receiveQRResult:returningURL];
        CGRect bounds = [metadataObjects[0] bounds];
        CGRect frame = CGRectMake(CXScreenWidth*(1-bounds.origin.y-bounds.size.height),
                                  CXScreenHeight*(bounds.origin.x),
                                  CXScreenWidth*bounds.size.height,
                                  CXScreenHeight*bounds.size.width);
        self.scanBound.frame = frame;
        self.scanBound.layer.borderWidth = 1.0;
        self.scanBound.layer.borderColor = [UIColor redColor].CGColor;
    }
    else
    {
        self.scanBound.frame = CGRectMake(0, 0, 0, 0);
    }
}

#pragma mark - delegate CXQRCodeDelegate

- (void)selectScanResult:(NSString *)url
{
    self.returningURLProcess(url);
}

@end
