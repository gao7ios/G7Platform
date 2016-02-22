//
//  G7Color.h
//  G7Core
//
//  Created by WangMingfu on 15/1/28.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

//RGBA颜色
#define G7_COLOR_WITH_RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//十六进制颜色
#define G7_COLOR_WITH_HEXVALUE(hexValue, a) [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f	\
													        green:((hexValue >> 8) & 0x000000FF)/255.0f		\
															 blue:((hexValue) & 0x000000FF)/255.0f			\
															alpha:a]

