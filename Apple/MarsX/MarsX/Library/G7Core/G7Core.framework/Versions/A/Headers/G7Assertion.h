//
//  G7Assertion.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-11.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

#pragma mark -

#if __G7_DEVELOPMENT__

#undef	ASSERT
#define ASSERT( __expr )	G7Assert( (__expr) ? YES : NO, #__expr, __PRETTY_FUNCTION__, __FILE__, __LINE__ )

#else	// #if __G7_DEVELOPMENT__

#undef	ASSERT
#define ASSERT( __expr )

#endif	// #if __G7_DEVELOPMENT__

#if __cplusplus
extern "C" {
#endif
	
	void G7AssertToggle( void );
	void G7AssertEnable( void );
	void G7AssertDisable( void );
	void G7Assert( BOOL flag, const char * expr, const char * function, const char * file, int line );
	
#if __cplusplus
};
#endif
