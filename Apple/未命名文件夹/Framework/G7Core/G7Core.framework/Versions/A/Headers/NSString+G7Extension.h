//
//  NSString+G7Extension.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-16.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

#pragma mark -

typedef NSString *			(^NSStringAppendBlock)( id format, ... );
typedef NSString *			(^NSStringReplaceBlock)( NSString * string, NSString * string2 );

typedef NSMutableString *	(^NSMutableStringAppendBlock)( id format, ... );
typedef NSMutableString *	(^NSMutableStringReplaceBlock)( NSString * string, NSString * string2 );

// Given a byte array, returns an NSString containing those bytes encoded in Base64 encoding.
extern NSString *G7EncodeBase64(NSData *data);

// Given a Base64-encoded string, decodes the string and returns an
// NSData containing the decoded bytes.
extern NSData *G7DecodeBase64(NSString *base64);

// Given a string, return an NSString not nil.
extern NSString *G7SafetyString(NSString *string);

#pragma mark -

@interface NSString(G7Extension)


@property (nonatomic, readonly) NSStringAppendBlock		APPEND;
@property (nonatomic, readonly) NSStringAppendBlock		LINE;
@property (nonatomic, readonly) NSStringReplaceBlock	REPLACE;

@property (nonatomic, readonly) NSData *				data;
@property (nonatomic, readonly) NSDate *				date;

@property (nonatomic, readonly) NSString *				MD5;
@property (nonatomic, readonly) NSData *				MD5Data;

@property (nonatomic, readonly) NSString *				SHA1;

@property (nonatomic, readonly) NSString *				BASE64;
@property (nonatomic, readonly) NSString *				BASE64DECODE;

// 字数统计，半角为0.5个字符
@property (nonatomic, readonly) NSUInteger				wordCount;


///-----------------------------------------
/// @name URL
///-----------------------------------------

- (NSArray *)allURLs;

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingDict:(NSDictionary *)params encoding:(BOOL)encoding;
- (NSString *)urlByAppendingArray:(NSArray *)params;
- (NSString *)urlByAppendingArray:(NSArray *)params encoding:(BOOL)encoding;
- (NSString *)urlByAppendingKeyValues:(id)first, ...;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict encoding:(BOOL)encoding;;
+ (NSString *)queryStringFromArray:(NSArray *)array;
+ (NSString *)queryStringFromArray:(NSArray *)array encoding:(BOOL)encoding;;
+ (NSString *)queryStringFromKeyValues:(id)first, ...;

+ (NSString *)getURLParamValue:(NSString *)url param:(NSString *)param;


///-----------------------------------------
/// @name encrypt/decrypt
///-----------------------------------------

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

- (NSString *)encryptDESWith:(NSString *)key;
- (NSString *)decryptDESWith:(NSString *)key;

- (NSString *)encryptXXTEAWith:(NSString *)key;
- (NSString *)decryptXXTEAWith:(NSString *)key;


- (NSString *)base64String;
- (NSString *)decodeBase64String;

- (NSString *)trim;
- (NSString *)unwrap;
- (NSString *)repeat:(NSUInteger)count;
- (NSString *)normalize;


+ (NSString *)md5:(NSString *)input;
+ (NSString*)encodeBase64:(NSString*)string;
+ (NSString*)decodeBase64:(NSString*)string;



///-----------------------------------------
/// @name check
///-----------------------------------------

+ (BOOL)isEmpty:(NSString *)string;
+ (BOOL)isNotEmpty:(NSString *)string;

- (BOOL)match:(NSString *)expression;
- (BOOL)matchAnyOf:(NSArray *)array;

//- (BOOL)empty;
//- (BOOL)notEmpty;

- (BOOL)eq:(NSString *)other;
- (BOOL)equal:(NSString *)other;

- (BOOL)is:(NSString *)other;
- (BOOL)isNot:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

- (BOOL)isContain:(NSString *)subString;
- (BOOL)isContain:(NSString *)subString caseInsens:(BOOL)caseInsens;

- (BOOL)isNormal;		// thanks to @uxyheaven
- (BOOL)isTelephone;
- (BOOL)isUserName;
- (BOOL)isChineseUserName;
- (BOOL)isPassword;
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isIPAddress;


///-----------------------------------------
/// @name other
///-----------------------------------------

- (NSString*)encodeAsURIComponent;
- (NSString*)escapeHTML;
- (NSString*)unescapeHTML;

- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset;
- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset endOffset:(NSUInteger *)endOffset;

- (NSUInteger)countFromIndex:(NSUInteger)from inCharset:(NSCharacterSet *)charset;

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height;
#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

+ (NSString *)fromResource:(NSString *)resName;
+ (NSString*)generateUUIDString;

@end


#pragma mark -

@interface NSMutableString(G7Extension)

@property (nonatomic, readonly) NSMutableStringAppendBlock	APPEND;
@property (nonatomic, readonly) NSMutableStringAppendBlock	LINE;
@property (nonatomic, readonly) NSMutableStringReplaceBlock	REPLACE;

@end
