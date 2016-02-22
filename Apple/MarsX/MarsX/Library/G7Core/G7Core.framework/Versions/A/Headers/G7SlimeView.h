//
//  G7SlimeView.h
//  G7Core
//
//  Created by WangMingfu on 15/2/3.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7Precompile.h"

#define kG7StartTo    0.7f
#define kG7EndTo      0.15f

#define kG7RefreshImageWidth  17.0f
#define kG7AnimationInterval  (1.0f/50.0f)

NS_INLINE CGFloat G7DistansBetween(CGPoint p1 , CGPoint p2) {
	return sqrtf((p1.x - p2.x)*(p1.x - p2.x) + (p1.y - p2.y)*(p1.y - p2.y));
}

typedef enum {
	G7SlimeStateNormal,
	G7SlimeStateShortening,
	G7SlimeStateMiss
} G7SlimeState;

typedef enum {
	G7SlimeBlurShadow,
	G7SlimeFillShadow
} G7SlimeShadowType;

@class G7SlimeView;

@interface G7SlimeView : UIView

@property (nonatomic, assign)   CGPoint startPoint, toPoint;
@property (nonatomic, assign)   CGFloat viscous;    //default 55
@property (nonatomic, assign)   CGFloat radius;     //default 13
@property (nonatomic, strong)  UIColor *bodyColor;
@property (nonatomic, strong)  UIColor *skinColor;

@property (nonatomic, assign)   G7SlimeShadowType   shadowType;
@property (nonatomic, assign)   CGFloat lineWith;
@property (nonatomic, assign)   CGFloat shadowBlur;
@property (nonatomic, strong)  UIColor *shadowColor;

@property (nonatomic, assign)   BOOL    missWhenApart;
@property (nonatomic, assign)   G7SlimeState    state;

- (void)setPullApartTarget:(id)target action:(SEL)action;

@end
