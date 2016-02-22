//
//  PhoneViewController.m
//  Gao7Free20
//
//  Created by wang mingfu on 12-8-24.
//  Copyright (c) 2012年 tandy. All rights reserved.
//

#import "PhoneViewController.h"

@interface PhoneViewController () <UIGestureRecognizerDelegate>
{
    CGPoint _beganPoint;//拖动的时候的最开始的位置
    BOOL _isPanHandlerDuty;  //判断是否重复pan手势操作
    
    BOOL _isUseCustomNavigationBar;   //是否自定义导航条
    
}

@end


@implementation PhoneViewController

#pragma mark - Orientation

- (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0)
{
    //NSLog(@"PhoneViewController-shouldAutorotate");
    return NO;
    
}


#pragma mark - lifecycle


- (void)loadView
{
    //NSLog(@"PhoneViewController-loadView");
	[super loadView];
    
    self.navigationController.navigationBarHidden = _isUseCustomNavigationBar;

}

- (void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"PhoneViewController-viewWillAppear");
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = _isUseCustomNavigationBar;

}

- (void)viewWillDisappear:(BOOL)animated
{
    //NSLog(@"PhoneViewController-viewWillDisappear");
    [super viewWillDisappear:animated];

    self.navigationController.navigationBarHidden = _isUseCustomNavigationBar;
}


#pragma mark - gesture recognizer

/** 
 * 添加手势操作属性控制
 * @param  
 * @result  
 * @creator wangmingfu
 */
- (void)setIsContainGestureRecognizer:(BOOL)isContainGestureRecognizer
{
    //NSLog(@"PhoneViewController-setIsContainGestureRecognizer");
    _isContainGestureRecognizer = isContainGestureRecognizer;
    
    if (_isContainGestureRecognizer) {
        
        UIPanGestureRecognizer* recognizer; 
        recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)]; 
        recognizer.delegate = self;
        [self.view addGestureRecognizer:recognizer];
        
        _isPanHandlerDuty = NO;
    }
    
}

/** 
 * called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to 
 * transition to UIGestureRecognizerStateFailed
 * @param  
 * @result 
 */
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    //NSLog(@"PhoneViewController-gestureRecognizerShouldBegin");
    CGPoint translation = [gestureRecognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
    
    _isPanHandlerDuty = NO;
    
    if (sqrt(translation.x * translation.x) / sqrt(translation.y * translation.y) > 1) return YES;
    
    return NO;
    
}
/** 
 * 手势捕获事件
 * @param  
 * @result 
 */
- (void)handlePanFrom:(UIPanGestureRecognizer*)recognizer { 
    //NSLog(@"PhoneViewController-handlePanFrom");
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        _beganPoint = [recognizer translationInView:[[UIApplication sharedApplication] keyWindow]];

    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint endPoint = [recognizer translationInView:[[UIApplication sharedApplication] keyWindow]];
        
        float offset = endPoint.x - _beganPoint.x;
        
        //如果移动距离大于 kGestureValideWidth，调用手势移动handler，子类重写该方法以实现
        if (fabs(offset) > kGestureValideWidth && !_isPanHandlerDuty) {
            
            [self gestureRecognizerHandler:_beganPoint EndPoint:endPoint];
            
            _isPanHandlerDuty = YES;
            
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
    }
}


/** 
 * 手势移动调用
 * @param  
 * @result  
 * @creator wangmingfu
 */
- (void)gestureRecognizerHandler:(CGPoint)beginPoint EndPoint:(CGPoint)endPoint{
    //NSLog(@"PhoneViewController-gestureRecognizerHandler");
    if (beginPoint.x < endPoint.x -30){
        
        [self.navigationController popViewControllerAnimated:YES];
        //[self navBackButtonAction:nil];
        
    }
    
}


@end
