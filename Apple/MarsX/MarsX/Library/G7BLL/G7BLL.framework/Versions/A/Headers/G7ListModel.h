//
//  G7ListModel.h
//  G7BLL
//
//  Created by WangMingfu on 15/11/19.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol G7ListModel;

/**
 * 列表数据请求回调Block定义
 */
typedef void(^G7ListModelRequestCompletedBlock)(id<G7ListModel> model, NSArray *responseData, NSError *error);

/**
 * 列表数据模型协议
 *
 * @author WangMingfu
 * @date 2015.11.19
 */
@protocol G7ListModel <NSObject>

@required

///列表数据缓存
@property (nonatomic, readonly) NSMutableArray *listData;

///当前请求数据缓存
@property (nonatomic, readonly) NSMutableArray *responseListData;

///列表额外数据，用于存放除列表数据以外的所有数据
///例如：列表头部的广告轮播，专辑等数据，字典Key由实现类自行创建
@property (nonatomic, readonly) NSMutableDictionary *extraDatas;

///最后一次请求错误信息
@property (nonatomic, readonly) NSError *error;

///数据请求回调Block
@property (nonatomic, copy) G7ListModelRequestCompletedBlock completedBlock;

///是否正在请求数据
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

/**
 * <p>取消当前请求</p>
 *
 * @author WangMingfu
 * @date 2015.11.19
 *
 */
- (void)cancelLoading;

/**
 * <p>重新加载数据</p>
 *
 * @author WangMingfu
 * @date 2015.11.19
 *
 */
- (void)reloadData;

///是否重新加载，用于区分处理数据回调的方式
@property (nonatomic, readonly, getter=isReload) BOOL reload;


/**
 * <p>加载下一页数据</p>
 *
 * @author WangMingfu
 * @date 2015.11.19
 *
 */
- (void)loadNextPage;

///列表数据总数
@property (nonatomic, readonly) NSUInteger count;

///当前返回的列表数据，是否是已最后一页数据
@property (nonatomic, readonly) BOOL isLastPage;

///数据请求页码索引
@property (nonatomic, readonly) NSUInteger pageIndex;


@end
