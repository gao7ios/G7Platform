//
//  UIImage+G7Extension.h
//  G7Core
//
//  Created by WangMingfu on 15/1/28.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

@interface UIImage (G7Extension)

/// 增加水印图片
- (UIImage *)coverWithLogo:(UIImage *)coverImage;

- (UIImage *)coverWithLogo:(UIImage *)coverImage position:(CGPoint)point;

- (UIImage *)coverWithLogo:(UIImage *)coverImage frame:(CGRect)frame;

@end
