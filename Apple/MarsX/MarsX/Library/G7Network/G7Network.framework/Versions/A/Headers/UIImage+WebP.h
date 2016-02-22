//
//  UIImage+WebP.h
//  G7Network
//
//  Created by WangMingfu on 15/8/18.
//  Copyright (c) 2015年 tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Fix for issue #416 Undefined symbols for architecture armv7 since WebP introduction when deploying to device
//void WebPInitPremultiplyNEON(void);
//
//void WebPInitUpsamplersNEON(void);
//
//void VP8DspInitNEON(void);

@interface UIImage (WebP)

+ (UIImage *)g7_imageWithWebPData:(NSData *)data;

@end
