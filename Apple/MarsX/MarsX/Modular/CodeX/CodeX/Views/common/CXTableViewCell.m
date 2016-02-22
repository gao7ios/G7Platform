//
//  CXTableViewCell.m
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXTableViewCell.h"

@implementation CXTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
        self.textLabel.font = [UIFont fontWithName:@"helvetica-bold" size:16.0];
        self.textLabel.textColor = [UIColor colorWithRed:60.0/255.0 green:65.0/255.0 blue:76.0/255.0 alpha:1.0];
        self.detailTextLabel.textColor = [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0];
    }
    
    return self;
}

@end
