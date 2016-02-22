//
//  G7ResponseSerializer.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-16.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

@interface G7ResponseSerializer : G7HTTPResponseSerializer

/**
 Options for reading the response JSON data and creating the Foundation objects. For possible values, see the `NSJSONSerialization` documentation section "NSJSONReadingOptions". `0` by default.
 */
@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

/**
 Creates and returns a JSON serializer with specified reading and writing options.
 
 @param readingOptions The specified JSON reading options.
 */
+ (instancetype)serializerWithReadingOptions:(NSJSONReadingOptions)readingOptions;

@end
