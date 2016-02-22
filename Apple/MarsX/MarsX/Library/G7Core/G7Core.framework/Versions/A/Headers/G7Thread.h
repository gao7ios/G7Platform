//
//  G7Thread.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-11.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Singleton.h"


#pragma mark -

@class G7Thread;
@compatibility_alias G7TaskQueue G7Thread;

typedef G7Thread * (^G7ThreadBlock)( dispatch_block_t block );

#pragma mark -

#define FOREGROUND_BEGIN		[G7Thread enqueueForeground:^{
#define FOREGROUND_BEGIN_(x)	[G7Thread enqueueForegroundWithDelay:(dispatch_time_t)x block:^{
#define FOREGROUND_COMMIT		}];

#define BACKGROUND_BEGIN		[G7Thread enqueueBackground:^{
#define BACKGROUND_BEGIN_(x)	[G7Thread enqueueBackgroundWithDelay:(dispatch_time_t)x block:^{
#define BACKGROUND_COMMIT		}];

#pragma mark -


@interface G7Thread : NSObject

@property (nonatomic, readonly) G7ThreadBlock	MAIN;
@property (nonatomic, readonly) G7ThreadBlock	FORK;

AS_SINGLETON( G7Thread )

+ (dispatch_queue_t)foreQueue;
+ (dispatch_queue_t)backQueue;

+ (void)enqueueForeground:(dispatch_block_t)block;
+ (void)enqueueBackground:(dispatch_block_t)block;
+ (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;
+ (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;


@end
