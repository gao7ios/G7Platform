//
//  G7Actions+Subclassing.h
//  EDWallpaper
//
//  Created by WangMingfu on 15/10/26.
//  Copyright © 2015年 E-Design. All rights reserved.
//

#import "G7Actions.h"

@interface G7ObjectActions : NSObject

@property (nonatomic, copy) G7ActionBlock tapAction;
@property (nonatomic, copy) G7ActionBlock detailAction;
@property (nonatomic, copy) G7ActionBlock navigateAction;

@property (nonatomic) SEL tapSelector;
@property (nonatomic) SEL detailSelector;
@property (nonatomic) SEL navigateSelector;

@end

@interface G7Actions ()

@property (nonatomic, weak) id target;

- (G7ObjectActions *)actionForObjectOrClassOfObject:(id<NSObject>)object;

@end

