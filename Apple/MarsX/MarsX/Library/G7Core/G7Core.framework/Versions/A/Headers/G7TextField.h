//
//  G7TextField.h
//  G7Core
//
//  Created by WangMingfu on 15/1/9.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * G7TextField 实现对UITextField的继承并扩展其功能
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7TextField : UITextField


@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

@property (nonatomic, assign) UIEdgeInsets placeholderEdgeInsets;

@property (nonatomic, assign) UIEdgeInsets editingEdgeInsets;

/**
 * <p>如果设置该属性，则会重新调整UITextField的titleRect</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property(assign, readwrite, nonatomic) CGRect textRect;

/**
 * <p>如果设置该属性，则会重新调整UITextField的placeholderRect</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property(assign, readwrite, nonatomic) CGRect placeholderRect;

/**
 * <p>如果设置该属性，则会重新调整UITextField的editingRect</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 */
@property(assign, readwrite, nonatomic) CGRect editingRect;

@end
