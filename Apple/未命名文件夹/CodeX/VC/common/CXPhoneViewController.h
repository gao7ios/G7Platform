//
//  CXPhoneViewController.h
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

typedef enum : NSUInteger {
    MaskStyleFade,
    MaskStylePop,
} MaskStyle;

typedef enum : NSUInteger {
    MaskDirectionUp,
    MaskDirectionDown,
    MaskDirectionLeft,
    MaskDirectionRight,
} MaskDirection;

@interface CXPhoneViewController : UIViewController

// 非全屏弹窗
- (void)showMaskCoverWithView:(UIView *)popView
                      animate:(BOOL)animated
                        style:(MaskStyle)style
                    direction:(MaskDirection)direction;

- (void)hideMaskCoverWithView:(UIView *)popView
                      animate:(BOOL)animated
                        style:(MaskStyle)style
                    direction:(MaskDirection)direction;

// 指示器
- (void)startIndicator;
- (void)stopIndicator;

@end
