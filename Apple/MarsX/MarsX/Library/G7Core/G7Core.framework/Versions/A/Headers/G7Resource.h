//
//  G7Resource.h
//  G7Core
//
//  Created by WangMingfu on 15/1/29.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7.h"

#define G7_CORE_BUNDLE ([G7Resource bundleWithName:@"G7Core"])
#define G7_CORE_BUNDLE_LOCATE(_string) ([G7Resource locationWithString:_string])

@interface G7Resource : NSObject

AS_SINGLETON( G7Resource )

/// 默认取G7Core.bundle nav_bg.png
@property (strong, readwrite, nonatomic) UIImage *navbarImage;

+ (NSBundle *)bundleWithName:(NSString *)name ;

+ (NSString *)locationWithString:(NSString *)string;

//+ (NSString *)pathWithResName:(NSString *)resName;
//
//+ (UIImage *)imageWithName:(NSString *)name;
//
//+ (UIImage *)imageWithName:(NSString *)name bundle:(NSBundle *)bundle;

/**
 * 获取当前语言，不包含区域设置标识符
 *
 * @author WangMingfu
 * @date 2015-08-14 14:08:44
 *
 * @return 
 */
+ (NSString *)resourceName;

@end
