//
//  G7CommonSetting.h
//  G7Framework
//
//  Created by WangMingfu on 14-4-16.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#import <G7Core/G7.h>

/**
 * Gao7Comment类库公共配置信息。该配置保存所有静态配置信息，以plist文件的方式
 * 存放在资源目录下，在创建新项目时，根据需要调整配置文件。
 */
@interface G7CommonSetting : NSObject


/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

/**
 * 应用程序基础信息
 */
@property(nonatomic, copy) NSString *ch;
@property(nonatomic, copy) NSString *pid;
@property(nonatomic, copy) NSString *ver;
@property(nonatomic, copy) NSString *pt;

/// 接口版本，由服务端提供
@property (nonatomic, copy) NSString *pv;

@property (nonatomic, strong) NSDictionary *settingDict;

AS_SINGLETON( G7CommonSetting );

@end
