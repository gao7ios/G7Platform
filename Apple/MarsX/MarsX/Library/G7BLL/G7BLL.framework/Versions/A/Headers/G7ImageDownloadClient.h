//
//  G7ImageDownloadClient.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-16.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//


@interface G7ImageDownloadClient : G7ImageManager

+ (instancetype)sharedClient;

/**
 * 自定义key
 *
 * @author WangMingfu
 * @date 2015-09-06 14:09:59
 *
 * @param url 图片下载地址URL
 *
 * @return the key
 */
+ (NSString *)keyForURL:(NSURL *)url;

@end
