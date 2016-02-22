//
//  G7Precompile.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-10.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#ifndef __IPHONE_4_0
#warning "G7Framework only available in iOS SDK 4.0 and later."
#endif

// ----------------------------------
// Global include headers
// ----------------------------------

#include <TargetConditionals.h>
#include <Availability.h>
#include <sys/utsname.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <mach/mach.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <execinfo.h>

#ifdef __OBJC__

	#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

		#import <UIKit/UIKit.h>
		#import <Foundation/Foundation.h>
		#import <CoreGraphics/CoreGraphics.h>
		#import <StoreKit/StoreKit.h>
		#import <SystemConfiguration/CaptiveNetwork.h>
		#import <AdSupport/AdSupport.h>

	#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

		#import <Foundation/Foundation.h>
		#import <Cocoa/Cocoa.h>

	#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

	#import <objc/runtime.h>
	#import <objc/message.h>
	#import <CommonCrypto/CommonDigest.h>

#endif	// #ifdef __OBJC__

// ----------------------------------
// Option values
// ----------------------------------

#undef	__ON__
#define __ON__		(1)

#undef	__OFF__
#define __OFF__		(0)

#undef	__AUTO__

#if defined(_DEBUG) || defined(DEBUG)
#define __AUTO__	(1)
#else
#define __AUTO__	(0)
#endif

// ----------------------------------
// Global compile option
// ----------------------------------

#define __G7_DEVELOPMENT__				(__AUTO__)
#define __G7_LOG__						(__AUTO__)
#define __G7_UNITTEST__					(__OFF__)

#pragma mark - DEBUG

//#if defined(__G7_LOG__) && __G7_LOG__
//#undef	NSLog
//#define	NSLog	G7Log
//#endif	// #if (__ON__ == __G7_LOG__)



#undef	UNUSED
#define	UNUSED( __x ) \
		{ \
			id __unused_var__ __attribute__((unused)) = (__x); \
		}

#undef	ALIAS
#define	ALIAS( __a, __b ) \
		__typeof__(__a) __b = __a;


#pragma mark - ARC

#if !defined(__clang__) || __clang_major__ < 3

#ifndef __bridge
#define __bridge
#endif

#ifndef __bridge_retain
#define __bridge_retain
#endif

#ifndef __bridge_retained
#define __bridge_retained
#endif

#ifndef __autoreleasing
#define __autoreleasing
#endif

#ifndef __strong
#define __strong
#endif

#ifndef __unsafe_unretained
#define __unsafe_unretained
#endif

#ifndef __weak
#define __weak
#endif

#endif


#if __has_feature(objc_arc)

#define G7_PROP_RETAIN					strong
#define G7_PROP_ASSIGN					assign

#define G7_RETAIN( x )					(x)
#define G7_RELEASE( x )					(x)
#define G7_AUTORELEASE( x )				(x)

#define G7_BLOCK_COPY( x )				(x)
#define G7_BLOCK_RELEASE( x )			(x)
#define G7_SUPER_DEALLOC()

#define G7_AUTORELEASE_POOL_START()		@autoreleasepool {
#define G7_AUTORELEASE_POOL_END()			}

#define RETAIN							self
#define AUTORELEASE						self
#define RELEASE							self
#define DEALLOC							self

#else

#define G7_PROP_RETAIN					retain
#define G7_PROP_ASSIGN					assign

#define G7_RETAIN( x )					[(x) retain]
#define G7_RELEASE( x )					[(x) release]
#define G7_AUTORELEASE( x )				[(x) autorelease]

#define G7_BLOCK_COPY( x )				Block_copy( x )
#define G7_BLOCK_RELEASE( x )			Block_release( x )
#define G7_SUPER_DEALLOC()				[super dealloc]

#define G7_AUTORELEASE_POOL_START()		NSAutoreleasePool * __pool = [[NSAutoreleasePool alloc] init];
#define G7_AUTORELEASE_POOL_END()		[__pool release];


#define RETAIN							retain
#define AUTORELEASE						autorelease
#define RELEASE							release
#define DEALLOC							dealloc

#endif


#ifndef G7_INSTANCETYPE
	#if __has_feature(objc_instancetype)
		#define G7_INSTANCETYPE instancetype
	#else
		#define G7_INSTANCETYPE id
	#endif
#endif

#ifndef G7_STRONG
	#if __has_feature(objc_arc)
		#define G7_STRONG strong
	#else
		#define G7_STRONG retain
	#endif
#endif

#ifndef G7_WEAK
	#if __has_feature(objc_arc_weak)
		#define G7_WEAK weak
	#elif __has_feature(objc_arc)
		#define G7_WEAK unsafe_unretained
	#else
		#define G7_WEAK assign
	#endif
#endif

#define G7_DEPRECATED(...) __attribute__((deprecated(__VA_ARGS__)))
#define G7_UNAVAILABLE(...) __attribute__((unavailable(__VA_ARGS__)))

#undef	G7_EXTERN
#if defined(__cplusplus)
#define G7_EXTERN		extern "C" __attribute__((visibility ("default")))
#else	// #if defined(__cplusplus)
#define G7_EXTERN		extern __attribute__((visibility ("default")))
#endif	// #if defined(__cplusplus)

#define G7_STATIC_INLINE static inline

#pragma mark - iOS6

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000

#define UILineBreakMode					NSLineBreakMode
#define UILineBreakModeWordWrap			NSLineBreakByWordWrapping
#define UILineBreakModeCharacterWrap	NSLineBreakByCharWrapping
#define UILineBreakModeClip				NSLineBreakByClipping
#define UILineBreakModeHeadTruncation	NSLineBreakByTruncatingHead
#define UILineBreakModeTailTruncation	NSLineBreakByTruncatingTail
#define UILineBreakModeMiddleTruncation	NSLineBreakByTruncatingMiddle

#define UITextAlignmentLeft				NSTextAlignmentLeft
#define UITextAlignmentCenter			NSTextAlignmentCenter
#define UITextAlignmentRight			NSTextAlignmentRight
#define	UITextAlignment					NSTextAlignment

#endif	// #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000


#ifndef	weakify
#if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;
#else	// #if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	weakify

#ifndef	normalize
#if __has_feature(objc_arc)
#define normalize( x )	try{} @finally{} __typeof__(x) x = __weak_##x##__;
#else	// #if __has_feature(objc_arc)
#define normalize( x )	try{} @finally{} __typeof__(x) x = __block_##x##__;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	@normalize



#if __has_feature(objc_arc)

#define	prop_readonly( type, name )		property (nonatomic, readonly) type name;
#define	prop_dynamic( type, name )		property (nonatomic, strong) type name;
#define	prop_assign( type, name )		property (nonatomic, assign) type name;
#define	prop_strong( type, name )		property (nonatomic, strong) type name;
#define	prop_weak( type, name )			property (nonatomic, weak) type name;
#define	prop_copy( type, name )			property (nonatomic, copy) type name;
#define	prop_unsafe( type, name )		property (nonatomic, unsafe_unretained) type name;

#else

#define	prop_readonly( type, name )		property (nonatomic, readonly) type name;
#define	prop_dynamic( type, name )		property (nonatomic, retain) type name;
#define	prop_assign( type, name )		property (nonatomic, assign) type name;
#define	prop_strong( type, name )		property (nonatomic, retain) type name;
#define	prop_weak( type, name )			property (nonatomic, assign) type name;
#define	prop_copy( type, name )			property (nonatomic, copy) type name;
#define	prop_unsafe( type, name )		property (nonatomic, assign) type name;

#endif

#define prop_retype( type, name )		property type name;

#pragma mark -

#define g7_dispatch_main_sync_safe(block)\
		if ([NSThread isMainThread]) {\
			block();\
		} else {\
			dispatch_sync(dispatch_get_main_queue(), block);\
		}

#define g7_dispatch_main_async_safe(block)\
		if ([NSThread isMainThread]) {\
			block();\
		} else {\
			dispatch_async(dispatch_get_main_queue(), block);\
		}


// ----------------------------------
// Preload headers
// ----------------------------------






