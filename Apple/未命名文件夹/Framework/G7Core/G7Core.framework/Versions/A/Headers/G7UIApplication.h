//
//  G7UIApplication.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-11.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import "G7Precompile.h"
#import "G7Foundation.h"

#pragma mark -

@class G7UIApplication;
@compatibility_alias G7Skeleton G7UIApplication;

#pragma mark -

@interface G7UIApplication : UIResponder <UIApplicationDelegate>

AS_NOTIFICATION( LAUNCHED )		// did launched
AS_NOTIFICATION( TERMINATED )	// will terminate

AS_NOTIFICATION( STATE_CHANGED )	// state changed
AS_NOTIFICATION( MEMORY_WARNING )	// memory warning

AS_NOTIFICATION( WILL_ENTER_FOREGROUND )	// will enter foreground
AS_NOTIFICATION( DID_ENTER_BACKGROUND )		// did enter background

AS_NOTIFICATION( DID_BECOME_ACTIVE )		// did become active


AS_NOTIFICATION( LOCAL_NOTIFICATION )
AS_NOTIFICATION( REMOTE_NOTIFICATION )

AS_NOTIFICATION( APS_REGISTERED )
AS_NOTIFICATION( APS_ERROR )

AS_NOTIFICATION( UPDATE )


AS_INT( DEVICE_CURRENT )
AS_INT( DEVICE_PHONE_3_INCH )
AS_INT( DEVICE_PHONE_4_INCH )

@property (nonatomic, readonly) BOOL		ready;

@property (nonatomic, retain) UIWindow *	window;
@property (nonatomic, assign) NSUInteger	device;
@property (nonatomic, readonly) BOOL		inForeground;
@property (nonatomic, readonly) BOOL		inBackground;

+ (G7UIApplication *)sharedInstance;

@end

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
