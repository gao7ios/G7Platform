//
//  G7RequestSerializer.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-16.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//


@interface G7RequestSerializer : G7NetworkSerializer

/**
 Options for writing the request JSON data from Foundation objects. For possible values, see the `NSJSONSerialization` documentation section "NSJSONWritingOptions". `0` by default.
 */
@property (nonatomic, assign) NSJSONWritingOptions writingOptions;

/**
 Creates and returns a JSON serializer with specified reading and writing options.
 
 @param writingOptions The specified JSON writing options.
 */
+ (instancetype)serializerWithWritingOptions:(NSJSONWritingOptions)writingOptions;

@end
