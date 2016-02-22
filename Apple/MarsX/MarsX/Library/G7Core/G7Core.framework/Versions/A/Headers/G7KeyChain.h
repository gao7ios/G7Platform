//
//  G7KeyChain.h
//  G7Core
//
//  Created by WangMingfu on 15/1/26.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

// keychain
extern NSString *const G7_KEYCHAIN_KEY;
// g7udid
extern NSString *const G7_KEYCHAIN_KEY_UDID;

@interface G7KeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteKey:(NSString *)service;

@end
