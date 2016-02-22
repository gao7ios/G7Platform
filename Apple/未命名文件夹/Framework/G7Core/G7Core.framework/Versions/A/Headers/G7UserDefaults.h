//
//  G7UserDefaults.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-17.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Package.h"
#import "G7Foundation.h"
#import "G7CacheProtocol.h"

#pragma mark -

AS_PACKAGE( G7Package, G7UserDefaults, userDefaults );

#pragma mark -

#define AS_USERDEFAULT( __name )	AS_STATIC_PROPERTY( __name )
#define DEF_USERDEFAULT( __name )	DEF_STATIC_PROPERTY3( __name, @"userdefault", [self description] )

#pragma mark -

@interface G7UserDefaults : NSObject<G7CacheProtocol>

AS_SINGLETON( G7UserDefaults )

@end