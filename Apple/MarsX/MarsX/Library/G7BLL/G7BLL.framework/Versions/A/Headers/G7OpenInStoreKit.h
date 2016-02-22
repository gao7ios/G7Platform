//
//  G7OpenInStoreKit.h
//  G7BLL
//
//  Created by WangMingfu on 14/8/6.
//  Copyright (c) 2014年 yumo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G7OpenInStoreKit : NSObject

AS_SINGLETON( G7OpenInStoreKit )

- (void)openInStoreKitWithWebRequest:(NSString *)requestURL;

@end
