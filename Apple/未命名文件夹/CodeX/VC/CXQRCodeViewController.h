//
//  CXQRCodeViewController.h
//  NewCodeX
//
//  Created by mac on 14-3-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXPhoneViewController.h"

@interface CXQRCodeViewController : CXPhoneViewController

@property (strong, nonatomic) void (^returningURLProcess)(NSString *);

@end
