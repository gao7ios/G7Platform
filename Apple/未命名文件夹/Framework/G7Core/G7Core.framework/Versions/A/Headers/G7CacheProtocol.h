//
//  G7CacheProtocol.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-17.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Foundation.h"

#pragma mark -

@protocol G7CacheProtocol<NSObject>

- (BOOL)hasObjectForKey:(id)key;

- (id)objectForKey:(id)key;
- (void)setObject:(id)object forKey:(id)key;

- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;

- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)obj forKeyedSubscript:(id)key;

- (BOOL)synchronize;

@end

