//
//  G7Button.h
//  G7Core
//
//  Created by WangMingfu on 14/12/17.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * G7Button 实现对UIButton的继承并扩展其功能
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7Button : UIButton

/**
 * <p>如果设置该属性，则会重新调整UIButton的titleRect</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (nonatomic, assign) CGRect titleRect;

/**
 * <p>如果设置该属性，则会重新调整UIButton的backgroundRect</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (nonatomic, assign) CGRect backgroundRect;

/**
 * <p>如果设置该属性，则会重新调整UIButton的imageRect</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (nonatomic, assign) CGRect imageRect;

/**
 * <p>设置了属性rightAngle，则可以通过该属性调整rightAngleImageView的frame</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (nonatomic, assign) CGRect rightAngleRect;

/**
 * <p>设置该属性，将会为button在视图右上角创建一个UIImageView视图，并赋值图片rightAngle</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property (nonatomic, strong) UIImage *rightAngle;

/**
 * <p>通过该属性，可以通过调整imageRect，使button的image居中</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property(nonatomic, assign, setter = setIsImageCenter:) BOOL isImageCenter;

@end
