//
//  G7UIConfig.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-14.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import "G7Precompile.h"
#import "G7Foundation.h"

#pragma mark -

typedef enum
{
	G7UIInterfaceMode_iOS6 = 0,
	G7UIInterfaceMode_iOS7
} G7UIInterfaceMode;

#pragma mark -

typedef enum
{
	G7UISignalingMode_Manual = 0,
	G7UISignalingMode_Auto
} G7UISignalingMode;

#pragma mark -

typedef enum
{
	G7UIPerformanceMode_Normal = 0,
	G7UIPerformanceMode_High
} G7UIPerformanceMode;


@interface G7UIConfig : NSObject

AS_SINGLETON( G7UIConfig )

@property (nonatomic, assign) G7UIInterfaceMode	interfaceMode;
@property (nonatomic, assign) BOOL					iOS6Mode;
@property (nonatomic, assign) BOOL					iOS7Mode;

@property (nonatomic, assign) CGSize				baseOffset;
@property (nonatomic, assign) UIEdgeInsets			baseInsets;

@property (nonatomic, assign) G7UISignalingMode	signalingMode;
@property (nonatomic, assign) BOOL					ASR;
@property (nonatomic, assign) BOOL					MSR;

@property (nonatomic, assign) G7UIPerformanceMode	performanceMode;
@property (nonatomic, assign) BOOL					normalPerformance;
@property (nonatomic, assign) BOOL					highPerformance;

@property (nonatomic, assign) BOOL					cacheAsyncLoad;
@property (nonatomic, assign) BOOL					cacheAsyncSave;

@property (nonatomic, strong) UIColor				*backgroundColor;
@property (nonatomic, strong) UIColor				*navbarTintColor;
@property (nonatomic, strong) UIImage				*navbarImage;
@property (nonatomic, strong) UIImage				*navItemBackImage;
@property (nonatomic, strong) UIImage				*navItemCancelImage;
@property (nonatomic, strong) UIImage				*navItemSearchImage;
@property (nonatomic, strong) UIImage				*navItemRefreshImage;
@property (nonatomic, strong) UIImage				*navItemiPadShareImage;
@property (nonatomic, strong) UIImage				*navItemiPhonedShareImage;

@property (nonatomic, assign) CGRect				navLeftItemFrame;
@property (nonatomic, assign) CGRect				navRightItemFrame;

@property (nonatomic, strong) UIFont				*navTitleLableFont;

@end

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
