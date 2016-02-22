//
//  G7ContainerView.h
//  G7Core
//
//  Created by WangMingfu on 15/1/26.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

enum {
	G7CVSideNone	= 0x0,
	G7CVSideRight	= 0x01,
	G7CVSideLeft	= 0x02
}typedef G7CVSide;

@interface G7ContainerView : UIView

/// add rounded masks.
/// currently unused, because this needs offscreen-rendering, which is crazy slow
/// as a workaround, fake te rounded corners yourself
- (void)addMaskToCorners:(UIRectCorner)corners;
- (void)removeMask;

/// update shadow
- (void)updateContainer;
- (CGFloat)limitToMaxWidth:(CGFloat)maxWidth;

/// set shadow sides
@property(nonatomic, assign) G7CVSide shadow;

/// darken down the view if it's not fully visible
@property(nonatomic, assign) CGFloat darkRatio;

/// shadow width
@property(nonatomic, assign) CGFloat shadowWidth;

/// shadow alpha
@property(nonatomic, assign) CGFloat shadowAlpha;

/// corner radius
@property(nonatomic, assign) CGFloat cornerRadius;

@end
