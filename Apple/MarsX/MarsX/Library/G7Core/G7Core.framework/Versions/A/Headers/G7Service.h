//
//  G7Service.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-14.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Package.h"
#import "G7Foundation.h"

#pragma mark -

AS_PACKAGE_INSTANCE( G7Package, G7Package_Service, services );

#pragma mark -

@class G7Service;

typedef	void	(^G7ServiceBlock)( void );
typedef	void	(^G7ServiceBlockN)( id first, ... );

#pragma mark -

#undef	AS_SERVICE
#define	AS_SERVICE( __class, __name ) \
		AS_PACKAGE( G7Package_Service, __class, __name )

#undef	DEF_SERVICE
#define	DEF_SERVICE( __class, __name ) \
		DEF_PACKAGE( G7Package_Service, __class, __name )

#undef	AS_SUB_SERVICE
#define	AS_SUB_SERVICE( __parent, __class, __name ) \
		AS_PACKAGE( __parent, __class, __name )

#undef	DEF_SUB_SERVICE
#define	DEF_SUB_SERVICE( __parent, __class, __name ) \
		DEF_PACKAGE( __parent, __class, __name )

#pragma mark -

#undef	SERVICE_AUTO_LOADING
#define SERVICE_AUTO_LOADING( __flag ) \
		+ (BOOL)serviceAutoLoading { return __flag; }

#undef	SERVICE_AUTO_POWERON
#define SERVICE_AUTO_POWERON( __flag ) \
		+ (BOOL)serviceAutoPowerOn { return __flag; }


#pragma mark -

@protocol G7ServiceExecutor<NSObject>

- (void)powerOn;
- (void)powerOff;

- (void)serviceWillActive;
- (void)serviceDidActived;
- (void)serviceWillDeactive;
- (void)serviceDidDeactived;

@end



#pragma mark -

@interface G7Service : NSObject<G7ServiceExecutor>

@property (nonatomic, retain) NSString *			name;
@property (nonatomic, retain) NSBundle *			bundle;
@property (nonatomic, retain) NSDictionary *		launchParameters;

@property (nonatomic, readonly) BOOL				running;
@property (nonatomic, readonly) BOOL				activating;

@property (nonatomic, readonly) G7ServiceBlock		ON;
@property (nonatomic, readonly) G7ServiceBlock		OFF;

+ (instancetype)sharedInstance;

+ (BOOL)serviceAutoLoading;
+ (BOOL)serviceAutoPowerOn;

+ (BOOL)servicePreLoad;
+ (void)serviceDidLoad;

- (NSArray *)loadedServices;

@end

