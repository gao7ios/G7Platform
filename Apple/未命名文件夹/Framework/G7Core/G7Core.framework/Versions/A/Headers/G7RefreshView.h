//
//  G7RefreshView.h
//  G7Core
//
//  Created by WangMingfu on 15/2/3.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "G7SlimeView.h"

@class G7RefreshView;

typedef void (^G7RefreshBlock)(G7RefreshView* sender);

@protocol G7RefreshDelegate;

@interface G7RefreshView : UIView{
	UIImageView     *_refleshView;
	G7SlimeView     *_slime;
}

//set the state loading or not.
@property (nonatomic, assign)   BOOL    loading;
- (void)setLoadingWithexpansion;

@property (strong, readonly, nonatomic) G7SlimeView *slime;

@property (strong, readonly, nonatomic) UIImageView *refleshView;

@property (copy, readonly, nonatomic) G7RefreshBlock block;

@property (nonatomic, assign)   id<G7RefreshDelegate>   delegate;

@property (strong, readonly, nonatomic) UIActivityIndicatorView *activityIndicationView;

//default is false, if true when slime go back it will have a alpha effect
//to go to miss.
@property (nonatomic, assign)   BOOL    slimeMissWhenGoingBack;

//
@property (nonatomic, assign)   CGFloat upInset;

//
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDraging;

//as the name, called when loading over.
- (void)endRefresh;

// init default is 32
- (id)initWithHeight:(CGFloat)height;

- (void)stopAnimating;

@end

@protocol G7RefreshDelegate <NSObject>

@optional
//start refresh.
- (void)slimeRefreshStartRefresh:(G7RefreshView*)refreshView;

@end