//
//  G7Operation.h
//  G7Core
//
//  Created by WangMingfu on 15/9/12.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "G7.h"

typedef enum {
	G7OperationPausedState      = -1,
	G7OperationReadyState       = 1,
	G7OperationExecutingState   = 2,
	G7OperationFinishedState    = 3,
} _G7OperationState;

typedef signed short G7OperationState;


#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
	typedef UIBackgroundTaskIdentifier G7BackgroundTaskIdentifier;
#else
	typedef id G7BackgroundTaskIdentifier;
#endif

__unused static dispatch_group_t ed_operation_completion_group();
__unused static dispatch_queue_t ed_operation_completion_queue();

__unused static NSString * EDKeyPathFromOperationState(G7OperationState state);
__unused static BOOL EDStateTransitionIsValid(G7OperationState fromState, G7OperationState toState, BOOL isCancelled);


@protocol G7Operation <NSObject>

- (void)cancel;

@end

@interface G7Operation : NSOperation <NSCoding, NSCopying, G7Operation>

/// 设置队列线程的run loop modes，默认包含 `NSRunLoopCommonModes`
@prop_copy	(NSSet *, runLoopModes)

/// 任务执行过程中的错误信息
@prop_readonly	(NSError *, error)

/// 任务回调使用的并发队列，默认使用main queue.
@prop_assign	(dispatch_queue_t, completionQueue)

/// 任务回调使用的合并group，默认使用 ed_operation_completion_group().
@prop_assign	(dispatch_group_t, completionGroup)

///
@prop_strong	(NSDictionary *, userInfo)

@prop_readonly	(NSRecursiveLock *, lock)


/// Configuring Backgrounding Task Behavior
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
- (void)setShouldExecuteAsBackgroundTaskWithExpirationHandler:(void (^)(void))handler;
#endif

/// 子类线程的问题，待测试
+ (void)g7_operationThreadEntryPoint:(NSString *)threadName;
+ (NSThread *)g7_operationThread;

/// 子类可重写
- (void)operationDidStart;
- (void)finish;
- (void)cancelOperation;

@end



///----------------
/// @name Constants
///----------------

extern NSString * const G7OperationErrorDomain;
extern NSString * const G7OperationFailingCommonErrorKey;

///--------------------
/// @name Notifications
///--------------------

/// 任务开始时通知
extern NSString * const G7OperationDidStartNotification;

/// 任务完成时通知
extern NSString * const G7OperationDidFinishNotification;

