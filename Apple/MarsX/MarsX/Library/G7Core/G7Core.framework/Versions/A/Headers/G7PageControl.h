//
//  G7PageControl.h
//  G7Core
//
//  Created by WangMingfu on 15/1/9.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <UIKit/UIKit.h>


/// 分页视图空间样式枚举
typedef NS_ENUM(NSUInteger, G7PageControlStyle) {
	//默认样式
	G7PageControlStyleDefault = 0,
	//圆圈
	G7PageControlStyleStrokedCircle = 1,
	//按压样式
	G7PageControlStylePressed1 = 2,
	G7PageControlStylePressed2 = 3,
	//带页码的样式
	G7PageControlStyleWithPageNumber = 4,
	//自定义图片
	G7PageControlStyleThumb = 5,
	//矩形
	G7PageControlStyleStrokedSquare = 6,
};

/**
 * G7PageControl 实现分页视图的显示
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7PageControl : UIControl

/**
 * <p>该属性用于设置分页控件未选状态背景色,
 *    默认设置为 [UIColor colorWithRed:128/255.0 green:130/255.0 blue:133/255.0 alpha:1]</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (strong, readwrite, nonatomic) UIColor *coreNormalColor;

/**
 * <p>该属性用于设置分页控件选择状态背景色,
 *    默认设置为 [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (strong, readwrite, nonatomic) UIColor *coreSelectedColor;

/**
 * <p>通过该属性，可设置stroked style分页控件未选状态的填充色</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (strong, readwrite, nonatomic) UIColor *strokeNormalColor;

/**
 * <p>通过该属性，可设置stroked style分页控件选择状态的填充色</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (strong, readwrite, nonatomic) UIColor *strokeSelectedColor;

/**
 * <p>当pageControlStyle＝G7PageControlStyleThumb时，
 *    通过该属性设置分页控件未选状态的自定义图片样式</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (strong, readwrite, nonatomic) UIImage *thumbImage;

/**
 * <p>当pageControlStyle＝G7PageControlStyleThumb时，
 *    通过该属性设置分页控件选择状态的自定义图片样式</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (strong, readwrite, nonatomic) UIImage *selectedThumbImage;

/**
 * <p>当pageControlStyle＝G7PageControlStyleThumb时，
 *    通过该属性设置分页控件选择状态的自定义图片样式</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (strong, readwrite, nonatomic) NSMutableDictionary *thumbImageForIndex;
@property (strong, readwrite, nonatomic) NSMutableDictionary *selectedThumbImageForIndex;

/**
 * <p>设置当前选中页码</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (assign, readwrite, nonatomic) NSUInteger currentPage;

/**
 * <p>设置总页数</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (assign, readwrite, nonatomic) NSUInteger numberOfPages;

/**
 * <p>设置只有一页时，是否隐藏分页控件</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (assign, readwrite, nonatomic) BOOL hidesForSinglePage;

/**
 * <p>分页样式设置</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (assign, readwrite, nonatomic) G7PageControlStyle pageControlStyle;

/**
 * <p>当style为strke时，通过该属性可以设置stroke的边框width</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (assign, readwrite, nonatomic) NSUInteger strokeWidth;

/**
 * <p>当pageControlStyle＝G7PageControlStyleStrokedCircle时，
 *    通过该属性可以设置圆圈的直径大小</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (assign, readwrite, nonatomic) NSUInteger diameter;

/**
 * <p>当style为strke时，通过该属性可以设置stroke的间隙</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (assign, readwrite, nonatomic) NSUInteger gapWidth;


/**
 * <p>当pageControlStyle＝G7PageControlStyleThumb时，
 *    用于为每个页码自定义图片资源</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 * @param aThumbImage 自定义图片
 * @Param index 对应的页码索引
 *
 */
- (void)setThumbImage:(UIImage *)aThumbImage forIndex:(NSInteger)index;
- (void)setSelectedThumbImage:(UIImage *)aSelectedThumbImage forIndex:(NSInteger)index;

/**
 * <p>获取对应索引的页码图片资源</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 * @Param index 对应的页码索引
 *
 * @return 自定义图片
 */
- (UIImage *)thumbImageForIndex:(NSInteger)index;
- (UIImage *)selectedThumbImageForIndex:(NSInteger)index;

@end
