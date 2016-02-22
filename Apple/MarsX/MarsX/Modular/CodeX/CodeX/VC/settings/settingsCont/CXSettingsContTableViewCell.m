//
//  CXSettingsContTableViewCell.m
//  CodeX
//
//  Created by yuyang on 14-12-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsContTableViewCell.h"

@interface CXSettingsContTableViewCell()

@property (nonatomic, strong) UILabel *keyNameLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation CXSettingsContTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
    
    if (!self.editing)
    {
        self.keyNameLabel.frame = CGRectMake(CXMarginLeftRight, 0, 0.5*CGRectGetWidth(self.frame)-CXMarginLeftRight, CGRectGetHeight(self.frame));
        self.valueLabel.frame = CGRectMake(CGRectGetMaxX(self.keyNameLabel.frame), 0, 0.5*CGRectGetWidth(self.frame)-CXMarginLeftRight, CGRectGetHeight(self.frame));
    }
    else
    {
        self.valueLabel.frame = CGRectMake(CGRectGetMaxX(self.keyNameLabel.frame)-2*CXMarginLeftRight, 0, 0.5*CGRectGetWidth(self.frame)-CXMarginLeftRight, CGRectGetHeight(self.frame));
    }
}

- (void)initialCell
{
    self.keyNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.keyNameLabel.textAlignment = NSTextAlignmentLeft;
    self.keyNameLabel.textColor = CXDarkColor;
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    self.valueLabel.textColor = CXHighlightColor;
    [self.contentView addSubview:self.keyNameLabel];
    [self.contentView addSubview:self.valueLabel];
}

- (void)setKeyValueType:(CXKeyValueType *)keyValueType
{
    _keyValueType = keyValueType;
    if (keyValueType)
    {
        self.keyNameLabel.text = keyValueType.keyName;
        self.valueLabel.text = keyValueType.value;
    }
}

- (void)drawRect:(CGRect)rect
{
    [self drawLineFrom:CGPointMake(0, CGRectGetHeight(self.bounds))
                    to:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
}

- (void)drawLineFrom:(CGPoint)fromPoint to:(CGPoint)toPoint
{
    UIColor *color = CXTableViewSeperatorColor;
    [color setStroke];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext, 1.0f);
    CGContextMoveToPoint(currentContext, fromPoint.x, fromPoint.y);
    CGContextAddLineToPoint(currentContext, toPoint.x, toPoint.y);
    CGContextStrokePath(currentContext);
}

@end
