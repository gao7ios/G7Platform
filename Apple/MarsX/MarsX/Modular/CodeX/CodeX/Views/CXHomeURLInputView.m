//
//  CXHomeURLInputView.m
//  NewCodeX
//
//  Created by mac on 14-3-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXWebViewController.h"

#import "CXHomeViewController.h"
#import "CXHomeURLInputView.h"
#import "CXQRCodeViewController.h"

#define textFieldHeight 29.0
#define textFieldWidth 302.0
#define textFieldMarginHerizontal 10.0

@interface CXHomeURLInputView()

@property (strong, nonatomic) UITextField *urlTextField;
@property (strong, nonatomic) UIButton *qrCodeBtn;

- (void)openURLAction;
- (void)triggerInputAction;
- (void)initialViews;

@end

@implementation CXHomeURLInputView

- (id)init
{
    if (self=[super init])
    {
        self.frame = CGRectMake(textFieldMarginHerizontal, 0, [UIScreen mainScreen].bounds.size.width-2*textFieldMarginHerizontal, textFieldHeight);
        [self initialViews];
    }
    
    return self;
}

- (void)initialViews
{
    UIImage *image = [UIImage imageNamed:@"cx_qrcode"];
    CGSize size = image.size;
    
    //地址栏样式
    self.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1.0];
    self.layer.cornerRadius = 3.0;
    
    //输入框样式
    self.urlTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, [UIScreen mainScreen].bounds.size.width-2*textFieldMarginHerizontal-1.5*qrBtnWidth-0.5*(2*size.height-self.frame.size.height), textFieldHeight)];
    self.urlTextField.textColor = [UIColor colorWithRed:78.0/255.0 green:83.0/255.0 blue:95.0/255.0 alpha:1.0];
    self.urlTextField.text = @"";
    self.urlTextField.placeholder = @"输入地址";
    self.urlTextField.font = [UIFont systemFontOfSize:FontSize];
    self.urlTextField.keyboardType = UIKeyboardTypeURL;
    self.urlTextField.returnKeyType = UIReturnKeyGo;
    [self.urlTextField addTarget:self action:@selector(openURLAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.urlTextField addTarget:self action:@selector(triggerInputAction) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:self.urlTextField];
    
    //二维码样式
    
    self.qrCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-2*textFieldMarginHerizontal-size.width, 4, size.width+29, size.height+29)];
    [self.qrCodeBtn setImage:[UIImage imageNamed:@"cx_qrcode"] forState:UIControlStateNormal];
    [self.qrCodeBtn setImage:[UIImage imageNamed:@"cx_qrcode_on"] forState:UIControlStateHighlighted];
    [self.qrCodeBtn setContentMode:UIViewContentModeCenter];
    [self.qrCodeBtn setFrame:CGRectMake( self.urlTextField.frame.size.width, -0.5*(2*size.height-self.frame.size.height), 2*size.width, 2*size.height)];
    [self.qrCodeBtn addTarget:self  action:@selector(qrAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.qrCodeBtn];
}

- (void)qrAction
{
    self.qrCodeBtn.backgroundColor = [UIColor clearColor];
    if (self.delegate != nil)
    {
        [self.delegate openQRCode];
    }
}

- (void)alertShow:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

//打开连接
- (void)openURLAction
{
    if (self.urlTextField.text.length == 0)
    {
        [self alertShow:@"地址栏不能为空"];
    }
    else
    {
        self.urlTextField.text = [self.urlTextField.text lowercaseString];
        if (self.delegate != nil)
        {
            [self.delegate openURL:self.urlTextField.text];
        }
        else
        {
            [self alertShow:@"程序出错"];
        }
    }
}

- (void)triggerInputAction
{
    [self.delegate triggerInput];
}

//隐藏键盘
- (void)keyboardHide
{
    if ([self.urlTextField isFirstResponder])
    {
        [self.urlTextField resignFirstResponder];
    }
}

@end
