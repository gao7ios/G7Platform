//
//  G7CombinedOperation.h
//  G7Core
//
//  Created by WangMingfu on 15/9/22.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "G7Operation.h"

@interface G7CombinedOperation : NSObject <G7Operation>

@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (copy, nonatomic) void (^cancelBlock)();
@property (strong, nonatomic) NSOperation *cacheOperation;

@property (nonatomic, copy) NSString *requestURL;

@end
