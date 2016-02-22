//
//  G7SlimeRefresh.h
//  G7Core
//
//  Created by WangMingfu on 15/2/3.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "G7Refresh.h"

#import "G7SlimeView.h"

@class G7SlimeRefresh;
typedef void (^G7RefreshBlock)(G7SlimeRefresh* sender);


@interface G7SlimeRefresh : G7RefreshView {
	
	UIImageView     *_refleshView;
	G7SlimeView     *_slime;
}

@property (strong, readonly, nonatomic) G7SlimeView *slime;

@property (strong, readonly, nonatomic) UIImageView *refleshView;

@property (copy, readonly, nonatomic) G7RefreshBlock block;

@property (strong, readonly, nonatomic) UIActivityIndicatorView *activityIndicationView;

//default is false, if true when slime go back it will have a alpha effect
//to go to miss.
@property (nonatomic, assign)   BOOL    slimeMissWhenGoingBack;
//
@property (nonatomic, assign)   CGFloat upInset;


@end
