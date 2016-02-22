//
//  UIImage+GIF.h
//  G7Network
//
//  Created by WangMingfu on 15/8/18.
//  Copyright (c) 2015年 tandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIF)

+ (UIImage *)g7_animatedGIFNamed:(NSString *)name;

+ (UIImage *)g7_animatedGIFWithData:(NSData *)data;

- (UIImage *)g7_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
