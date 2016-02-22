//
//  CXSettingsMenuType.h
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

@interface CXSettingsMenuType : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;

- (id)initWithParams:(NSArray *)params;

@end
