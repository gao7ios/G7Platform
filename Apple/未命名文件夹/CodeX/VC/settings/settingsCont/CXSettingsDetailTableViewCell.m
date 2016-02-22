//
//  CXSettingsDetailTableViewCell.m
//  CodeX
//
//  Created by yuyang on 14-12-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsDetailTableViewCell.h"

@interface CXSettingsDetailTableViewCell()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation CXSettingsDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initialCell];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(CXMarginLeftRight, 0, CGRectGetWidth(self.frame)-2*CXMarginLeftRight, CGRectGetHeight(self.frame));
    self.backgroundView.frame = CGRectMake(-1, 0, CGRectGetWidth(self.frame)+2, CGRectGetHeight(self.frame));
}

- (void)initialCell
{
    self.backgroundColor = [UIColor whiteColor];
    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(-2, 0, CGRectGetWidth(self.frame)+4, CGRectGetHeight(self.frame))];
    self.backgroundView.layer.borderColor = CXTableViewSeperatorColor.CGColor;
    self.backgroundView.layer.borderWidth = 1.0f;
    [self.contentView addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.textField];
}

- (NSString *)text
{
    return self.textField.text;
}

- (void)setText:(NSString *)text
{
    self.textField.text = text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    self.textField.enabled = enable;
}

@end
