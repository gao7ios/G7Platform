//
//  NSObject+G7Extension.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-14.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

#pragma mark -

#undef	DISPOSABLE
#define	DISPOSABLE( __class, __name ) \
		__class * __name = [__class disposable]

#pragma mark -

typedef void ( *ImpFuncType )( id a, SEL b, void * c );

@interface NSObject(G7Extension)

/**
 * 强引用
 * set = g7_setStrongRef: (strong)
 * get = g7_strongRef
 * @creator wangmingfu
 */
@property (readwrite, nonatomic, strong, setter = g7_setStrongRef:) id g7_strongRef;

/**
 * 弱引用
 * set = g7_setSeakRef: (weak)
 * get = g7_weakRef
 * @creator wangmingfu
 */
@property (readwrite, nonatomic, weak, setter = g7_setWeakRef:) id g7_weakRef;


+ (instancetype)object;
+ (instancetype)disposable;

- (void)load;
- (void)unload;

- (void)performLoad;
- (void)performUnload;

- (void)performSelectorAlongChain:(SEL)sel;
- (void)performSelectorAlongChainReversed:(SEL)sel;

@end
