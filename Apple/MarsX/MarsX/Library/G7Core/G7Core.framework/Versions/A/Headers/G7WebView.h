//
//  G7WebView.h
//  G7Core
//
//  Created by WangMingfu on 14/12/17.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "G7Singleton.h"

/**
 * G7WebViewDelegate 实现web加载的生命周期，同时实现UIScrollViewDelegate
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@protocol G7WebViewDelegate <NSObject>

@optional

/// web开始执行下拉刷新
- (void)g7webViewDidStartRefresh:(UIWebView *)webView;

/// web加载结束回调
- (void)g7webViewDidFinishLoad:(UIWebView *)webView;
/// web开始加载回调
- (void)g7webViewDidStartLoad:(UIWebView *)webView;
/// web加载失败回调
- (void)g7webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
/// web重定向请求回调
- (BOOL)g7webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
/// 监听web隐藏域加载结束
- (void)g7webView:(UIWebView *)webView didFinishLoadHiddenFileds:(NSDictionary *)hiddenFields;


/// UIScrollViewDelegate
- (void)g7scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)g7scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)g7scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)g7scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@class G7SlimeRefresh;

/**
 * G7WebView 继承自UIWebView，实现对原生webView功能的扩展，并捕获其delegate重新定向。
 *
 * @author WangMingfu
 * @date 2015-01-29
 */
@interface G7WebView : UIWebView 

/// G7WebView委托接收者
@property (nonatomic, weak) id <G7WebViewDelegate> proxydelegate;


///-----------------------------------------
/// @name view
///-----------------------------------------

/// 是否移除webview原生自带的黑色边缘阴影
@property (nonatomic, assign) BOOL removeBlackEdgeShadow;

/// 加载过程是否显示加载进度
@property (nonatomic, assign) BOOL showActivityIndicator;

/// 如果showActivityIndicator＝YES，则可以通过该属性设置加载进度的样式
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorStyle;

/// 是否设置下拉刷新视图
@property (nonatomic, assign) BOOL enableRefreshHeaderView;

/// 下拉刷新视图
@property (nonatomic, readonly) G7SlimeRefresh *refreshHeaderView;


///-----------------------------------------
/// @name request
///-----------------------------------------

/// 获取初始的请求地址
@property (nonatomic, readonly, copy) NSString*	originalURLString;
/// 获取初始的请求实体
@property (nonatomic, readonly, strong) NSMutableURLRequest *originalURLRequest;

/// 设置web请求缓存策略，具体参考 NSURLRequestCachePolicy
@property (nonatomic, assign) NSURLRequestCachePolicy requestCachePolicy;

/// 设置web请求超时时长
@property (nonatomic, assign)	NSUInteger requestTimeOut;

/// 获取加载使用时长
@property (nonatomic, readonly) NSUInteger	requestInterval;

/// 获取当前点击web页面的位置
@property (nonatomic, readonly) CGPoint		currentTouched;

/*
 * 使用计时器获取web隐藏域
 * 如果隐藏域获取完成，将会回调delegate @selector(webView:didLoadHiddenFileds:);
 * 你可以调用 [self addHiddenFieldWithKey:@"key"] 方法，添加隐藏域的监听
 * 监听结束后，可使用 [hiddenFields objectWithKey:@"key"] 获取隐藏域结果
 */
@property (nonatomic, readonly) NSDictionary *hiddenFields;

/*
 *  是否开启隐藏域获取监听，监听结果需要实现delegate  @selector(webView:didLoadHiddenFileds:) 获取.
 *  default is NO
 */
@property (nonatomic, assign) BOOL validHiddenFieldMonitor;

/**
 * <P>添加隐藏域解析
 *    必须在web开始加载前添加完成，否则无效</p>
 *
 * @author WangMingfu
 * @date 2015-01-31
 *
 * @param key web隐藏域对应的key值
 *
 * @code [self addHiddenFieldWithKey:@"g7_hidden"]
 */
- (void)addHiddenFieldWithKey:(NSString *)key;

/**
 * <P>获取解析完成的隐藏域</p>
 *
 * @author WangMingfu
 * @date 2015-01-31
 *
 * @param key web隐藏域对应的key值
 *
 * @return key值对应的隐藏域
 *
 * @code [self getHiddenFieldWithKey:@"g7_hidden"]
 */
- (NSString *)hiddenFieldWithKey:(NSString *)key;


/**
 * 加载urlString的web地址，并开始执行
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 * @param urlString web请求地址
 *
 * @return 是否开始加载
 *
 * @code [self openURL:@"http://www.gao7.com/phonetool.aspx"]
 */
- (BOOL)openURL:(NSString *)urlString;

/**
 * 加载urlString的web地址，并开始执行
 *
 * @author WangMingfu
 * @date 2015-01-29
 *
 * @param urlString web请求地址
 * @param fields	设置URLRequest的headerfields
 *
 * @return 是否开始加载
 *
 * @code [self openURL:@"http://www.gao7.com/phonetool.aspx" withHeaderFields:@{@"User-Agent1":[G7Common userAgent1]}];
 */
- (BOOL)openURL:(NSString *)urlString withHeaderFields:(NSDictionary *)fields;



@end
