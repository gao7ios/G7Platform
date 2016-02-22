//
//  G7Archiver.h
//  G7Core
//
//  Created by WangMingfu on 15/5/6.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 序列化操作实体
 */
@interface G7Archiver : NSObject

/**
 * 反序列化数据
 *
 * @param key 序列化缓存文件key
 *
 * @return 反序列化后的数据
 */
+ (id)unarchive:(NSString *)key;

/**
 * 序列化实体
 *
 * @param object 要序列化的实体
 * @param key    缓存文件key
 *
 * @return 是否序列化成功
 */
+ (BOOL)persist:(id)object key:(NSString *)key;

/**
 * 移除序列化文件
 *
 * @param key  缓存文件key
 *
 * @return 是否删除成功
 */
+ (BOOL)deleteWith:(NSString *)key;



@end
