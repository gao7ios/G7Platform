//
//  G7DataType.h
//  G7Core
//
//  Created by WangMingfu on 15/1/12.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((deprecated)) //使用G7Object替代
@interface G7DataType : NSObject

///-----------------------------------------
/// @name 数据解析方法
///-----------------------------------------

/// need to be overwrite.
- (G7DataType *)parseFromDictionary:(NSDictionary *)dictionary;

/// return the `G7DataType`,parse from dictionary
+ (G7DataType *)parseFromDictionary:(NSDictionary *)dictionary;

/// return the `G7DataType`,parse from jsonString
+ (G7DataType *)parseFromJSONString:(NSString *)jsonString;

/// return the NSArray ,parse from jsonString
+ (NSArray *)parseObjectsFromJSONString:(NSString *)jsonString;

/// return the NSArray ,parse from array
+ (NSArray *)parseObjectsFromArray:(NSArray *)array;

///-----------------------------------------
/// @name 实体简单属性赋值，暂时无法针对`NSArray`,`NSDictionary`等复杂对象实现解析
///-----------------------------------------

- (void)setValues:(NSDictionary *)values;

@end
