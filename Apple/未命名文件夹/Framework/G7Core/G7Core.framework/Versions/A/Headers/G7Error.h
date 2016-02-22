//
//  G7Error.h
//  G7Core
//
//  Created by WangMingfu on 15/1/28.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7.h"

/// G7Framework错误域，所有来自该错误域的错误信息都是由G7Framework返回
G7_EXTERN NSString *const G7FrameworkDomain;

/// G7UserSystem错误域，所有来自该错误域的错误信息都是由G7UserSystem返回 [G7UDK]
G7_EXTERN NSString *const G7UserSystemDomain;

/// NSError的userInfo内部错误
G7_EXTERN NSString *const G7ErrorInnerErrorKey;

/*!
 The key in the userInfo NSDictionary of NSError for the parsed JSON response
 from the server. In case of a batch, includes the JSON for a single FBRequest.
 */
G7_EXTERN NSString *const G7ErrorParsedJSONResponseKey;

/*!
 The key in the userInfo NSDictionary of NSError indicating
 the HTTP status code of the response (if any).
 */
G7_EXTERN NSString *const G7ErrorHTTPStatusCodeKey;


/*!
 @typedef NS_ENUM (NSUInteger, G7ErrorCode)
 @abstract Error codes returned by the G7Framework in NSError.
 
 @discussion
 These are valid only in the scope of G7FrameworkDomain.
 */
typedef NS_ENUM(NSInteger, G7ErrorCode) {
	
	/// Like nil for G7ErrorCode values
	G7ErrorInvalid = 0,
	/// The operation failed because it was cancelled.
	G7ErrorOperationCancelled,
	/// Indicates that the error implies that the server had an unexpected failure or may be temporarily down
	G7ErrorServerError,
	/// Non-success HTTP status code was returned from the operation.
	G7ErrorHTTPError,
	/// An error occurred related to an iOS API call
	G7ErrorSystemAPI,
	/// The application had its openURL: method called from a source that was not a
	/// gao7 app and with a URL that was intended
	G7ErrorUntrustedURL,
	/// A login attempt failed
	G7ErrorLoginFailedOrCancelled,

	G7ErrorProtocolMismatch,
};

/*!
 @typedef NS_ENUM (NSUInteger, G7ShareErrorCode)
 @abstract Error codes returned by the G7UserSystem in NSError.
 
 @discussion
 These are valid only in the scope of G7UserSystemDomain.
 */
typedef NS_ENUM(NSUInteger, G7ShareErrorCode) {
	
	/*! Share was called in the native app with incomplete or incorrect arguments */
	G7ShareErrorInvalidParam = 100,
	
	/*! A server error occurred while calling Share in the native  app. */
	G7ShareErrorServer = 102,
	
	/*! An unknown error occurred while calling Share in the native  app. */
	G7ShareErrorUnknown = 103,
	
	/*! Disallowed from calling Share in the native  app. */
	G7ShareErrorDenied = 104,
};

G7_EXTERN NSString *const G7ErrorSessionKey;

G7_EXTERN NSString *const G7ErrorLoginFailedReason;
G7_EXTERN NSString *const G7ErrorLoginFailedOriginalErrorCode;
G7_EXTERN NSString *const G7ErrorLoginFailedReasonUserCancelledValue;
G7_EXTERN NSString *const G7ErrorLoginFailedReasonOtherError;
G7_EXTERN NSString *const G7ErrorLoginFailedReasonSystemError;

G7_EXTERN NSString *const G7InvalidOperationException;


/**
 *	@brief	错误级别
 */
typedef NS_ENUM(NSUInteger, G7ErrorLevel)
{
	G7ErrorLevelNone		= 0,		///无错误
	G7ErrorLevelNormal		= 1,		///一般错误
	G7ErrorLevelSerious		= 2			///严重错误
};

/**
 *	@brief	错误级别
 */
typedef NS_ENUM(NSUInteger, G7ErrorType)
{
	G7ErrorTypeAPI			= 1,		/**< API错误 */
	G7ErrorTypeHTTP			= 2,		/**< HTTP错误 */
	G7ErrorTypeNetwork		= 3			/**< 网络错误 */
};


/*
[NSError errorWithDomain:G7FrameworkDomain
					code:G7ErrorOperationDisallowedForRestrictedTreament
				userInfo:nil]
*/

/**
 * G7Error 定义错误信息
 *
 * [<p>功能：实现错误信息的传递和获取</p>]
 *
 * @author WangMingfu
 * @date 2015-01-28
 */
@interface G7Error : NSObject

/**
 * <p>获取错误代码;
 *    如果为调用API出错则应该参考API错误码对照表，
 *    如果为HTTP错误，此属性则指示HTTP错误码，
 *    如果为Network错误，此属性则指示Network错误码，
 *    如果为System错误，此属性则指示System错误码，
 * </p>
 *
 * @author WangMingfu
 * @date 2015-01-28 13:55
 *
 * @return 返回对应错误代码
 */
- (NSInteger)errorCode;

/**
 * <p>获取错误描述，对应相应的错误码的描述</p>
 *
 * @author WangMingfu
 * @date 2015-01-28
 *
 * @return 错误描述
 */
- (NSString *)errorDescription;

/**
 * <p>获取错误级别</p>
 *
 * @author WangMingfu
 * @date 2015-01-28
 *
 * @return 错误级别
 */
- (G7ErrorLevel)errorLevel;

/**
 * <p>获取错误类型</p>
 *
 * @author WangMingfu
 * @date 2015-01-28
 *
 * @return 错误类型
 */
- (G7ErrorType)errorType;

@end
