//
//  G7Ticker.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-11.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Singleton.h"

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#pragma mark -

#undef	ON_TICK
#define ON_TICK( __time ) \
		- (void)handleTick:(NSTimeInterval)__time

#pragma mark -

@interface G7Ticker : NSObject

@property (nonatomic, readonly)	CADisplayLink *		timer;
@property (nonatomic, readonly)	NSTimeInterval		timestamp;
@property (nonatomic, assign) NSTimeInterval		interval;

AS_SINGLETON( G7Ticker )

- (void)addReceiver:(NSObject *)obj;
- (void)removeReceiver:(NSObject *)obj;

@end

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
