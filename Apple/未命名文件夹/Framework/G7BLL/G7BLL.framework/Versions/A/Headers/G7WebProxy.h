//
//  G7WebProxy.h
//  G7BLL
//
//  Created by WangMingfu on 15/1/29.
//  Copyright (c) 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, G7WebProxyType) {
	
	G7WebProxyNoneType					= 0,
	G7WebProxyOpenAppStoreType			= 1,
	G7WebProxyUserLoginType				= 2,
	G7WebProxyUserShareType				= 3,
	G7WebProxyShowWebPageType			= 4,
	G7WebProxyShowWebPageWithModelType	= 5,
	G7WebProxyShowAppDetailType			= 6,
};


@protocol G7WebProxyDelegate <NSObject>

@required

- (void)webProxyMatchWithType:(G7WebProxyType)mapType;

@optional

@end


@interface G7WebProxy : G7Service <G7URLMapDelegate>

AS_SINGLETON( G7WebProxy )

@property (weak, readwrite, nonatomic) id<G7WebProxyDelegate> delegate;

@end
