//
//  NSObject+G7Ticker.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-11.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#pragma mark -

@interface NSObject(G7Ticker)
- (void)observeTick;
- (void)unobserveTick;
- (void)handleTick:(NSTimeInterval)elapsed;
@end

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
