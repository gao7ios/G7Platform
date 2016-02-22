//
//  CXSettingsDetailTableViewCell.h
//  CodeX
//
//  Created by yuyang on 14-12-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXTableViewCell.h"
#import "CXKeyValueType.h"

@interface CXSettingsDetailTableViewCell : CXTableViewCell

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, assign) BOOL enable;

@end
