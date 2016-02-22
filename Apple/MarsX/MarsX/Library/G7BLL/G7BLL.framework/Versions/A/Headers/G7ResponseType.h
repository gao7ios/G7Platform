//
//  G7ResponseType.h
//  G7BLL
//
//  Created by WangMingfu on 15/1/29.
//  Copyright (c) 2015年 gao7. All rights reserved.
//

#import <G7Core/G7.h>

@interface G7ResponseType : G7Object

@property (nonatomic, copy) NSString *resultMessage;

@property (nonatomic, copy) NSString *resultCode;

@property (nonatomic, strong) NSDictionary *data;



@end
