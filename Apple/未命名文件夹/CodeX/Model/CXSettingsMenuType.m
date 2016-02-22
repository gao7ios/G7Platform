//
//  CXSettingsMenuType.m
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsMenuType.h"

@implementation CXSettingsMenuType

- (id)initWithParams:(NSArray *)params
{
    if (self = [super init])
    {
        if (params.count == 2)
        {
            self.title = params[1];
            self.desc = params[2];
        }
    }
    
    return self;
}

@end
