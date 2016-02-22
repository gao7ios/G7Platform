//
//  G7URLPattern.h
//  G7Core
//
//  Created by WangMingfu on 15/1/30.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G7URLPattern : NSObject

@property (nonatomic, copy)     NSString* URL;
@property (nonatomic, readonly) NSString* scheme;
@property (nonatomic, readonly) NSInteger specificity;
@property (nonatomic, readonly) Class     classForInvocation;
@property (nonatomic)           SEL       selector;


@end
