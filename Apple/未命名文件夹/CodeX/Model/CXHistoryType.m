//
//  CXHistoryType.m
//  NewCodeX
//
//  Created by mac on 14-3-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXHistoryType.h"

@implementation CXHistoryType

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    CXHistoryType *copy = [[[self class] allocWithZone:zone] init];
    copy.url = [self.url copyWithZone:zone];
    copy.title = [self.title copyWithZone:zone];
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.url
                  forKey:@"url"];
    [aCoder encodeObject:self.title
                  forKey:@"title"];
}

@end
