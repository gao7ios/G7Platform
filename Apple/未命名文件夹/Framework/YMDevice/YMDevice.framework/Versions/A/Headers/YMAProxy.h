//
//  YMAProxy.h
//  YMDevice
//
//  Created by WangMingfu on 14/12/2.
//  Copyright (c) 2014年 YUMO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMAProxy : NSObject

@property (nonatomic, readonly, copy) NSString *teamID;
@property (nonatomic, readonly, copy) NSString *itemID;
@property (nonatomic, readonly, copy) NSString *itemName;
@property (nonatomic, readonly, copy) NSString *localizedName;
@property (nonatomic, readonly, copy) NSString *minimumSystemVersion;
@property (nonatomic, readonly, copy) NSString *applicationIdentifier;
@property (nonatomic, readonly, copy) NSString *resourcesDirectoryURL;
@property (nonatomic, readonly, copy) NSString *applicationType;
@property (nonatomic, readonly, copy) NSString *shortVersionString;
@property (nonatomic, readonly, copy) NSString *bundleVersion;
@property (nonatomic, readonly, copy) NSString *applicationDSID;
@property (nonatomic, readonly, strong) NSNumber *dynamicDiskUsage;
@property (nonatomic, readonly, strong) NSNumber *staticDiskUsage;
@property (nonatomic, readonly, assign) BOOL isBetaApp;

- (instancetype)initWithApplicationInfo:(NSDictionary *)info;
- (NSDictionary *)dictionaryRepresentation;
@end
