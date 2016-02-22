//
//  G7Object.h
//  G7Core
//
//  Created by WangMingfu on 15/5/6.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * G7Object 实体基础类
 */
@interface G7Object : NSObject <NSCoding>

///-----------------------------------------
/// @name INITIALIZER
///-----------------------------------------
#pragma mark - INITIALIZER

/**
 * 初始化实体
 *
 * @param dictionary 实体对应的字典集合
 *
 * @return 使用dictionary赋值后的实体
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


///-----------------------------------------
/// @name NSCoding
///-----------------------------------------
#pragma mark - NSCoding

/**
 * 自动实现NSCoding`encode方法
 *
 * @param coder coder
 */
- (void)autoEncodeWithCoder: (NSCoder *)coder;

/**
 * 自动实现NSCoding`decode方法
 *
 * @param coder coder
 */
- (void)autoDecode:(NSCoder *)coder;


///-----------------------------------------
/// @name Property
///-----------------------------------------

#pragma mark - Property

/**
 * 获取所有属性集合
 *
 * @return { key=属性名，value=属性值 }
 */
- (NSDictionary *)properties;

/**
 * 获取所有的属性和属性类型集合
 *
 * @return { key=属性名，value=属性类型 }
 */
- (NSDictionary *)attributes;



///-----------------------------------------
/// @name 实体序列化
///-----------------------------------------

#pragma mark - JSON

/**
 * 实体序列化为二进制的NSData
 *
 * @return
 */
- (NSData *)jsonDataWithError:(NSError **)error;

/**
 * 实体序列化为JSON字符串
 *
 * @return
 */
- (NSString *)jsonStringWithError:(NSError **)error;


///-----------------------------------------
/// @name 数据解析方法
///-----------------------------------------

#pragma mark - 数据解析方法

/**
 * 从字典获取数据，并为实体的属性赋值
 *
 * @param dictionary 数据源字典
 *
 */
- (void)parseFromDictionary:(NSDictionary *)dictionary;

/**
 * 创建实体，并使用字典为实体属性赋值
 *
 * @param dictionary 数据源字典
 *
 * @return 赋值后的实体
 */
+ (instancetype)parseFromDictionary:(NSDictionary *)dictionary;

/**
 * 创建实体，并使用JSON数据位实体属性赋值
 *
 * @param jsonString 数据源JSON
 *
 * @return 赋值后的实体
 */
+ (instancetype)parseFromJSONString:(NSString *)jsonString;

/**
 * 使用JSON数据创建实体数组
 *
 * @param jsonString JSON数据源
 *
 * @return 实体数组
 */
+ (NSArray *)parseObjectsFromJSONString:(NSString *)jsonString;

/**
 * 使用字典数组创建实体数组
 *
 * @param array 字典数组数据源
 *
 * @return 实体数组
 */
+ (NSArray *)parseObjectsFromArray:(NSArray *)array;

/**
 * 属性映射表
 *
 * @author ShiKaimin
 * @date 2015-04-08 15:04:36
 *
 * @code
 * // 格式：属性名:字典key
 * + (NSDictionary *)propertyMapping {
 *	return @{
 *		@"appObj":@"app"
 *	};
 * }
 */
+ (NSDictionary *)propertyMapping;

/**
 * 类型映射表
 *
 * @author ShiKaimin
 * @date 2015-04-08 15:04:46
 *
 * @code
 * // 格式：属性名:自定义类型
 * + (NSDictionary *)classMapping {
 *	return @{
 *		@"appObj":App.class
 *	};
 * }
 */
+ (NSDictionary *)classMapping;

/**
 * 转换属性值
 *
 * @author ShiKaimin
 * @date 2015-04-08 11:04:23
 */
+ (id)transformValueByPropertyName:(NSString *)name originalValue:(id)value;



@end
