//
//  G7.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-10.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7CoreVersion.h"
#import "G7Precompile.h"
#import "G7Package.h"
#import "G7System.h"
#import "G7MVC.h"
#import "G7UIHelpers.h"
#import "G7Resource.h"


#pragma mark -

@class G7Package;
extern G7Package * g7;

#pragma mark -

AS_PACKAGE_INSTANCE( G7Package, G7Package_External, ext );

#undef	AS_EXTERNAL
#define	AS_EXTERNAL( __class, __name ) \
		AS_PACKAGE( G7Package_External, __class, __name )

#undef	DEF_EXTERNAL
#define	DEF_EXTERNAL( __class, __name ) \
		DEF_PACKAGE( G7Package_External, __class, __name )

#pragma mark -

AS_PACKAGE_INSTANCE( G7Package, G7Package_Library, lib );

#undef	AS_LIBRARY
#define	AS_LIBRARY( __class, __name ) \
		AS_PACKAGE( G7Package_Library, __class, __name )

#undef	DEF_LIBRARY
#define	DEF_LIBRARY( __class, __name ) \
		DEF_PACKAGE( G7Package_Library, __class, __name )
