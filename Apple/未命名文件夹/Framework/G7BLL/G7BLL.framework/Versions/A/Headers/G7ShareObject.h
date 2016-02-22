//
//  G7ShareObject.h
//  G7BLL
//
//  Created by WangMingfu on 15/1/31.
//  Copyright (c) 2015年 gao7. All rights reserved.
//

#import <G7Core/G7.h>

@interface G7ShareObject : G7DataType

/// 标题
@property (copy, readwrite, nonatomic) NSString *title;
@property (copy, readwrite, nonatomic) NSString *content;
@property (copy, readwrite, nonatomic) NSString *imageUrl;
@property (copy, readwrite, nonatomic) NSString *videoUrl;
@property (copy, readwrite, nonatomic) NSString *webpageUrl;
@property (assign, readwrite, nonatomic) NSUInteger mediaType;

/// platform 实体(type , addition)
@property (strong, readwrite, nonatomic) NSArray *platforms;


@end

@interface G7SharePlatformObject : G7DataType

@property (assign, readwrite, nonatomic) NSUInteger type;

@property (copy, readwrite, nonatomic) NSString *addition;

@end