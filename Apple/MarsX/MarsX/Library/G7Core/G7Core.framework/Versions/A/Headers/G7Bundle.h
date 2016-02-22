//
//  G7Bundle.h
//  G7Core
//
//  Created by WangMingfu on 15/1/22.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "G7Singleton.h"

/**
 * 类文件说明
 *
 * [<p>功能：</p>]
 * [<p>入口：</p>]
 *
 * @author wmf
 * @date 2015-01-22
 */
@interface G7Bundle : NSObject

/**
 * <p>获取当前 BundleURL</p>
 *
 * @author wmf
 * @date 2015-01-22
 */
@property (nonatomic, readonly, copy) NSURL *bundleURL;

/**
 * <p>获取当前 Bundle</p>
 *
 * @author wmf
 * @date 2015-01-22
 */
@property (nonatomic, readonly, strong) NSBundle *bundle;

/**
 * <p>初始化方法</p>
 *
 * [@param name 设置budnle名称; 如果为nil，初始化为[NSBundle mainBundle]]
 *
 * [@return G7Bundle实体]
 *
 * @author wmf
 * @date 2015-01-22
 */
- (instancetype)initWithName:(NSString *)name;

/**
 * <p>获取语言环境下的bundle</p>
 *
 * [@param lang 设置语言环境; 如果为nil，获取系统当前语言环境]
 *
 * [@return 返回语言环境对应的bundle]
 *
 * @author wmf
 * @date 2015-01-22
 */
- (NSBundle *)localBundle:(NSString *)lang;

- (NSString *)localString:(NSString *)string;

- (UIImage *)localImage:(NSString *)imageName;

@end
