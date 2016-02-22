//
//  G7Network.h
//  G7Network
//
//  Created by wang mingfu on 14-3-5.
//  Copyright (c) 2014年 tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

#import "G7NetworkOperation.h"
#import "G7NetworkReachabilityManager.h"
#import "G7URLRequestSerialization.h"
#import "G7URLResponseSerialization.h"

@interface G7NetworkManager : NSObject <NSCoding, NSCopying>

/**
 Requests created with `requestWithMethod:URLString:parameters:` & `multipartFormRequestWithMethod:URLString:parameters:constructingBodyWithBlock:` are constructed with a set of default headers using a parameter serialization specified by this property. By default, this is set to an instance of `G7NetworkSerializer`, which serializes query string parameters for `GET`, `HEAD`, and `DELETE` requests, or otherwise URL-form-encodes HTTP message bodies.
 
 @warning `requestSerializer` must not be `nil`.
 */
@property (nonatomic, strong) G7NetworkSerializer <G7URLRequestSerialization> * requestSerializer;


/**
 Responses sent from the server in data tasks created with `dataTaskWithRequest:success:failure:` and run using the `GET` / `POST` / et al. convenience methods are automatically validated and serialized by the response serializer. By default, this property is set to a JSON serializer, which serializes data from responses with a `application/json` MIME type, and falls back to the raw data object. The serializer validates the status code to be in the `2XX` range, denoting success. If the response serializer generates an error in `-responseObjectForResponse:data:error:`, the `failure` callback of the session task or request operation will be executed; otherwise, the `success` callback will be executed.
 
 @warning `responseSerializer` must not be `nil`.
 */
@property (nonatomic, strong) G7HTTPResponseSerializer <G7URLResponseSerialization> * responseSerializer;


/**
 The operation queue on which request operations are scheduled and run.
 */
@property (nonatomic, strong) NSOperationQueue *operationQueue;


///------------------------------------
/// @name Managing Network Reachability
///------------------------------------

/**
 The network reachability manager. `AFHTTPRequestOperationManager` uses the `sharedManager` by default.
 */
@property (readwrite, nonatomic, strong) G7NetworkReachabilityManager *reachabilityManager;

///---------------------------------------------
/// @name Creating and Initializing HTTP Clients
///---------------------------------------------

/**
 Creates and returns an `AFHTTPRequestOperationManager` object.
 */
+ (instancetype)manager;

///---------------------------------------
/// @name Managing HTTP Request Operations
///---------------------------------------

- (G7NetworkOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(G7NetworkOperation *operation, id responseObject))success
                                                    failure:(void (^)(G7NetworkOperation *operation, NSError *error))failure;

///---------------------------
/// @name Making HTTP Requests
///---------------------------

- (G7NetworkOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(G7NetworkOperation *operation, id responseObject))success
                        failure:(void (^)(G7NetworkOperation *operation, NSError *error))failure;

- (G7NetworkOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(G7NetworkOperation *operation, id responseObject))success
                         failure:(void (^)(G7NetworkOperation *operation, NSError *error))failure;

- (G7NetworkOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <G7MultipartFormData> formData))block
                         success:(void (^)(G7NetworkOperation *operation, id responseObject))success
                         failure:(void (^)(G7NetworkOperation *operation, NSError *error))failure;

@end
