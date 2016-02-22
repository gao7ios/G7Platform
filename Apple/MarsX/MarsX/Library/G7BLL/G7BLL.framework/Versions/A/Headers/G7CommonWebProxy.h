//
//  G7CommonWebProxy.h
//  G7BLL
//
//  Created by WangMingfu on 15/1/29.
//  Copyright (c) 2015年 gao7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface G7CommonWebProxy : G7Service <G7URLMapDelegate>

/// 注册公共的web捕获解析
- (void)registCommonPatterns;

@end
