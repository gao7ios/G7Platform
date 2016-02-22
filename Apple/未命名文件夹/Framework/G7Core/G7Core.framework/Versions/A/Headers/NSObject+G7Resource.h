//
//  NSObject+G7Resource.h
//  G7Core
//
//  Created by WangMingfu on 15/1/29.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (G7Resource)

+ (NSString *)stringFromResource:(NSString *)resName;
- (NSString *)stringFromResource:(NSString *)resName;

+ (NSData *)dataFromResource:(NSString *)resName;
- (NSData *)dataFromResource:(NSString *)resName;

//+ (id)objectFromResource:(NSString *)resName;

@end
