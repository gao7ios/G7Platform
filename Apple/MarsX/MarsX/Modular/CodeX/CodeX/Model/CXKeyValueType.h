//
//  CXKeyValueType.h
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsController.h"

@interface CXKeyValueType : NSObject

@property (nonatomic, strong) NSString *keyName;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) CXSettingsItemType itemType;
@property (nonatomic, strong) NSString *keyNameDesc;
@property (nonatomic, strong) NSString *valueDesc;

- (id)initWithParams:(NSArray *)params;

@end
