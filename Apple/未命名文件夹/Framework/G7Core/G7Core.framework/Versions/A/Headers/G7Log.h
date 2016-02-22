//
//  G7Log.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-11.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Singleton.h"

#pragma mark -

typedef enum
{
	G7LogLevelNone		= 0,
	G7LogLevelInfo		= 100,
	G7LogLevelPerf		= 200,
	G7LogLevelWarn		= 300,
	G7LogLevelError		= 400
} G7LogLevel;

#pragma mark -

#if __G7_LOG__

	#undef	CC
	#define CC( ... )		[[G7Logger sharedInstance] level:G7LogLevelNone format:__VA_ARGS__];

	#undef	INFO
	#define INFO( ... )		[[G7Logger sharedInstance] level:G7LogLevelInfo format:__VA_ARGS__];

	#undef	PERF
	#define PERF( ... )		[[G7Logger sharedInstance] level:G7LogLevelPerf format:__VA_ARGS__];

	#undef	WARN
	#define WARN( ... )		[[G7Logger sharedInstance] level:G7LogLevelWarn format:__VA_ARGS__];

	#undef	ERROR
	#define ERROR( ... )	[[G7Logger sharedInstance] level:G7LogLevelError format:__VA_ARGS__];

	#undef	PRINT
	#define PRINT( ... )	[[G7Logger sharedInstance] level:G7LogLevelNone format:__VA_ARGS__];

	#undef	VAR_DUMP
	#define VAR_DUMP( __obj )	PRINT( [__obj description] );

	#undef	OBJ_DUMP
	#define OBJ_DUMP( __obj )	PRINT( [__obj objectToDictionary] );

#else	// #if __G7_LOG__

	#undef	CC
	#define CC( ... )

	#undef	INFO
	#define INFO( ... )

	#undef	PERF
	#define PERF( ... )

	#undef	WARN
	#define WARN( ... )

	#undef	ERROR
	#define ERROR( ... )

	#undef	PRINT
	#define PRINT( ... )

	#undef	VAR_DUMP
	#define VAR_DUMP( __obj )

	#undef	OBJ_DUMP
	#define OBJ_DUMP( __obj )

#endif	// #if __G7_LOG__

#undef	TODO
#define TODO( desc, ... )

#pragma mark -

#pragma mark -

@interface G7Backlog : NSObject

@property (nonatomic, retain) NSString *		module;
@property (nonatomic, assign) G7LogLevel		level;
@property (nonatomic, readonly) NSString *		levelString;
@property (nonatomic, retain) NSString *		file;
@property (nonatomic, assign) NSUInteger		line;
@property (nonatomic, retain) NSString *		func;
@property (nonatomic, retain) NSDate *			time;
@property (nonatomic, retain) NSString *		text;
@end


#pragma mark -

@interface G7Logger : NSObject

AS_SINGLETON( G7Logger );

@property (nonatomic, assign) BOOL				showLevel;
@property (nonatomic, assign) BOOL				showModule;
@property (nonatomic, assign) BOOL				enabled;
@property (nonatomic, retain) NSMutableArray *	backlogs;
@property (nonatomic, assign) NSUInteger		indentTabs;

- (void)toggle;
- (void)enable;
- (void)disable;

- (void)indent;
- (void)indent:(NSUInteger)tabs;
- (void)unindent;
- (void)unindent:(NSUInteger)tabs;

- (void)level:(G7LogLevel)level format:(NSString *)format, ...;
- (void)level:(G7LogLevel)level format:(NSString *)format args:(va_list)args;

//#if __G7_DEVELOPMENT__
//#else	// #if __G7_DEVELOPMENT__
//#endif	// #if __G7_DEVELOPMENT__

@end

#pragma mark -

#if __cplusplus
extern "C" {
#endif
	
	void G7Log( NSString * format, ... );
	
#if __cplusplus
};
#endif
