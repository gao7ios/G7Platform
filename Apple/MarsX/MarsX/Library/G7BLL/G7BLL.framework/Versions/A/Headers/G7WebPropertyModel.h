//
//  G7WebPropertyModel.h
//  PhoneTool
//
//  Created by luzhx on 15/11/16.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kG7WebPropertyPlistUpdateComplete  @"g7WebPrppertyPlistUpdateComplete"

@interface G7WebPropertyModel : G7Service

@property (nonatomic, copy) void (^completedBlock)(NSData *data);

@end
