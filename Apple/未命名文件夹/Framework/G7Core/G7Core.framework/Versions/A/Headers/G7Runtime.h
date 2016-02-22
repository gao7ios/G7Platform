//
//  G7Runtime.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-11.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Singleton.h"

#pragma mark -

#undef	PRINT_CALLSTACK
#define PRINT_CALLSTACK( __n )	[G7Runtime printCallstack:__n]

#undef	BREAK_POINT
#define BREAK_POINT()			[G7Runtime breakPoint];

#undef	BREAK_POINT_IF
#define BREAK_POINT_IF( __x )	if ( __x ) { [G7Runtime breakPoint]; }

#undef	BB
#define BB						[G7Runtime breakPoint];


#pragma mark -

@interface G7Runtime : NSObject


@property (nonatomic, readonly) NSArray *	allClasses;
@property (nonatomic, readonly) NSArray *	callstack;
@property (nonatomic, readonly) NSArray *	callframes;

AS_SINGLETON( G7Runtime )

+ (id)allocByClass:(Class)clazz;
+ (id)allocByClassName:(NSString *)clazzName;

+ (NSArray *)allClasses;
+ (NSArray *)allSubClassesOf:(Class)clazz;

+ (NSArray *)allInstanceMethodsOf:(Class)clazz;
+ (NSArray *)allInstanceMethodsOf:(Class)clazz withPrefix:(NSString *)prefix;

+ (NSArray *)callstack:(NSUInteger)depth;
+ (NSArray *)callframes:(NSUInteger)depth;

+ (void)printCallstack:(NSUInteger)depth;
+ (void)breakPoint;

/// 方法调用
+ (id)invokeWith:(id)target selector:(SEL)selector params:(id)first, ...;

@end
