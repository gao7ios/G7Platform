//
//  G7Crypto.h
//  G7Core
//
//  Created by WangMingfu on 15/1/12.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, G7CryptoType) {

	G7CryptoBase64Type		=  0,
	G7CryptoXXTEAType		=  1,
	G7CryptoDESType			=  2
};

@interface G7Crypto : NSObject

///-----------------------------------------
/// @name 普通加密
///-----------------------------------------

+ (NSString *)MD5:(NSString *)string;

+ (NSString *)base64Encode:(NSString*)string;

+ (NSString *)base64Decode:(NSString *)string;

+ (NSString *)encryptDESString:(NSString *)string withKey:(NSString *)key;

+ (NSString *)decryptDESString:(NSString *)string withKey:(NSString *)key;


///-----------------------------------------
/// @name Gao7 特殊加密
///-----------------------------------------

+ (NSString *)encryptString:(NSString *)string withType:(G7CryptoType)type;

+ (NSString *)decryptString:(NSString *)string withType:(G7CryptoType)type;

+ (NSString *)decryptString:(NSString *)string;

@end
