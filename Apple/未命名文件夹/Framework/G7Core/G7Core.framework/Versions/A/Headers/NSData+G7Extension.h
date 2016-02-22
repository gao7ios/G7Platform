//
//  NSData+G7Extension.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-16.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

#pragma mark -

@interface NSData(G7Extension)

@property (nonatomic, readonly) NSData *	MD5;
@property (nonatomic, readonly) NSString *	MD5String;

+ (NSData *)fromResource:(NSString *)resName;

@end
