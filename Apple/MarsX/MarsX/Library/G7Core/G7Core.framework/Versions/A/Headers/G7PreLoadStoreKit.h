//
//  G7PreLoadStoreKit.h
//  G7Core
//
//  Created by WangMingfu on 15/11/2.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import "G7.h"

@interface G7PreLoadStoreKit : NSObject

AS_SINGLETON( G7PreLoadStoreKit )

- (void)addPreLoadWithItunesId:(NSString *)itunesId;

@end
