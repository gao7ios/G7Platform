//
//  CXKeyValueType.m
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXKeyValueType.h"

@implementation CXKeyValueType

- (id)initWithParams:(NSArray *)params
{
    if (self = [super init])
    {
        if (params.count == 3)
        {
            self.keyName = params[0];
            self.value = params[1];
            self.itemType = [params[2] intValue];
        }
        else if (params.count == 5)
        {
            self.keyName = params[0];
            self.value = params[1];
            self.itemType = [params[2] intValue];
            self.keyNameDesc = params[3];
            self.valueDesc = params[4];
        }
    }
    
    return self;
}

@end
