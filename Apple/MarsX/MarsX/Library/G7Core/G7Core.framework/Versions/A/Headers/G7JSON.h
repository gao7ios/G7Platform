//
//  G7JSON.h
//  G7Core
//
//  Created by WangMingfu on 15/1/27.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G7JSON : NSObject

+ (NSString *)encode:(id)data;

+ (id)decode:(NSString *)jsonEncoding;

+ (NSString *)encode:(id)data error:(NSError **)error
	  writingOptions:(NSJSONWritingOptions)writingOptions;

+ (id)decode:(NSString *)jsonEncoding error:(NSError **)error;


+ (id)dataWithJSONObject:(id)object error:(NSError **)error;

@end
