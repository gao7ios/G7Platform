//
//  CXTools.m
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXTools.h"

@implementation CXTools

+ (UIColor *)colorFromString:(NSString *)colorString
{
    UIColor *color;
    
    if (colorString.length == 6)
    {
        unsigned int red, green, blue;
        NSRange range;
        range.length =2;
        
        range.location =0;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&red];
        range.location =2;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&green];
        range.location =4;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&blue];
        
        color = [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:(255.0f/255.0f)];
    }
    else if (colorString.length == 8)
    {
        unsigned int red, green, blue, alpha;
        NSRange range;
        range.length =2;
        
        range.location =0;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&red];
        range.location =2;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&green];
        range.location =4;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&blue];
        range.location =6;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&alpha];
        
        color = [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f)alpha:(alpha/255.0f)];
        
    }
    
    return color;
}

+ (UIColor *)colorFromString:(NSString *)colorString withAlpha:(float)alpha
{
    UIColor *color;
    
    if (colorString.length == 6)
    {
        unsigned int red, green, blue;
        NSRange range;
        range.length =2;
        
        range.location =0;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&red];
        range.location =2;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&green];
        range.location =4;
        [[NSScanner scannerWithString:[colorString substringWithRange:range]]scanHexInt:&blue];
        
        color = [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alpha];
    }
    
    return color;
}

@end
