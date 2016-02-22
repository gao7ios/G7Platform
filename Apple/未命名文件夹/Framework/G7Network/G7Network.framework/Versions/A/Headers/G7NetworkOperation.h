//
//  G7NetworkOperation.h
//  G7Network
//
//  Created by wang mingfu on 14-3-6.
//  Copyright (c) 2014年 tandy. All rights reserved.
//

#import "G7URLConnectionOperation.h"
#import "G7URLResponseSerialization.h"

@interface G7NetworkOperation : G7URLConnectionOperation


///------------------------------------------------
/// @name Getting HTTP URL Connection Information
///------------------------------------------------

/**
 The last HTTP response received by the operation's connection.
 */
@property (readonly, nonatomic, strong) NSHTTPURLResponse *response;

/**
 Responses sent from the server in data tasks created with `dataTaskWithRequest:success:failure:` and run using the `GET` / `POST` / et al. convenience methods are automatically validated and serialized by the response serializer. By default, this property is set to an AFHTTPResponse serializer, which uses the raw data as its response object. The serializer validates the status code to be in the `2XX` range, denoting success. If the response serializer generates an error in `-responseObjectForResponse:data:error:`, the `failure` callback of the session task or request operation will be executed; otherwise, the `success` callback will be executed.
 
 @warning `responseSerializer` must not be `nil`. Setting a response serializer will clear out any cached value
 */
@property (nonatomic, strong) G7HTTPResponseSerializer <G7URLResponseSerialization> * responseSerializer;

/**
 An object constructed by the `responseSerializer` from the response and response data. Returns `nil` unless the operation `isFinished`, has a `response`, and has `responseData` with non-zero content length. If an error occurs during serialization, `nil` will be returned, and the `error` property will be populated with the serialization error.
 */
@property (readonly, nonatomic, strong) id responseObject;

///-----------------------------------------------------------
/// @name Setting Completion Block Success / Failure Callbacks
///-----------------------------------------------------------

/**
 Sets the `completionBlock` property with a block that executes either the specified success or failure block, depending on the state of the request on completion. If `error` returns a value, which can be caused by an unacceptable status code or content type, then `failure` is executed. Otherwise, `success` is executed.
 
 This method should be overridden in subclasses in order to specify the response object passed into the success block.
 
 @param success The block to be executed on the completion of a successful request. This block has no return value and takes two arguments: the receiver operation and the object constructed from the response data of the request.
 @param failure The block to be executed on the completion of an unsuccessful request. This block has no return value and takes two arguments: the receiver operation and the error that occurred during the request.
 */
- (void)setCompletionBlockWithSuccess:(void (^)(G7NetworkOperation *operation, id responseObject))success
                              failure:(void (^)(G7NetworkOperation *operation, NSError *error))failure;

@end

