//
//  G7Rooter.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-25.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import "G7.h"

@protocol G7Routable <NSObject>
@property(nonatomic,G7_STRONG) NSString *apiPath;

@optional
@property(nonatomic, G7_STRONG) NSDictionary *parameters;
@property(nonatomic, G7_STRONG) id entity;
@end

@interface G7Rooter : NSObject{
	
	NSMutableArray *routePatterns;
}
//+ (G7Rooter*)sharedRouter;
//
//- (void)match:(NSString*)pattern to:(Class)aClass;
//
//- (void)display:(id)obj withNavigationController:(UINavigationController*)navController;
//- (void)navigateTo:(NSString*)route withNavigationController:(UINavigationController*)navController;
//- (void)modallyPresent:(NSString*)route from:(UIViewController*)viewController;
//- (UIViewController<G7Routable> *)match:(NSString*)route;

@end
