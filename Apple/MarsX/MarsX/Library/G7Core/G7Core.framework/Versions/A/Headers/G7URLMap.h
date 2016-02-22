//
//  G7URLMap.h
//  G7Core
//
//  Created by WangMingfu on 15/1/23.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import "G7Precompile.h"
#import "G7Singleton.h"

@class G7WebView;

typedef NS_OPTIONS(NSInteger, G7URLMapType) {
	
	G7URLMapNoneType					= 0,
};

/**
 * <p>G7URLMapDelegate </p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@protocol G7URLMapDelegate <NSObject>

//@property (strong, readwrite, nonatomic) NSString *apiPath;

- (BOOL)handle:(NSString *)url sender:(id)sender;

@optional

@property (strong, readwrite, nonatomic) NSDictionary *parameters;
@property (strong, readwrite, nonatomic) id entity;

@end

/**
 * <p>G7URLMap 实现对web请求跳转URL的捕获操作</p>
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7URLMap : NSObject

AS_SINGLETON( G7URLMap )

@property (weak, readwrite, nonatomic) id sender;

/**
 * 捕获url
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 * @param url 需要捕获的url地址
 * 
 * @return 是否可以捕获
 */
- (BOOL)handle:(NSString *)url;
- (BOOL)handle:(NSString *)url sender:(id)sender;

/**
 * 注册匹配规则，并定义实现方式
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 * @param patterns 匹配规则
 * @param aClass 匹配成功后，接收捕获的class
 *
 * @return void
 */
- (void)match:(NSArray *)patterns  to:(Class)aClass;

/**
 * 注册匹配规则，并定义实现方式（暂未支持移除匹配，目前仅支持单例）
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 * @param patterns 匹配规则
 * @param target 匹配成功后，接收捕获的target
 *
 * @return void
 */
- (void)match:(NSArray *)patterns  toTarget:(id<G7URLMapDelegate>)target;

/**
 * 注册匹配规则，并定义实现方式
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 * @param patterns 匹配规则
 * @param proxyType 实现方式
 *
 * @return void
 */
- (void)match:(NSArray *)patterns  toProxyType:(G7URLMapType)proxyType;

//- (void)display:(id)obj withNavigationController:(UINavigationController*)navController;
//- (void)navigateTo:(NSString*)route withNavigationController:(UINavigationController*)navController;
//- (void)modallyPresent:(NSString*)route from:(UIViewController*)viewController;
//- (UIViewController<G7Routable> *)match:(NSString*)route;

@end
