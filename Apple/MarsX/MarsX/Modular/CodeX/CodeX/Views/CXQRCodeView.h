//
//  CXQRCodeView.h
//  NewCodeX
//
//  Created by mac on 14-3-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

@protocol CXQRCodeDelegate <NSObject>

@optional

- (void)cancelScan;
- (void)selectScanResult:(NSString *)url;

@end

@interface CXQRCodeView : UIView

@property (weak, nonatomic) id<CXQRCodeDelegate> delegate;

- (id)initWithDelegate:(id)delegate
                 frame:(CGRect)frame;
- (void)cleanQRResult;
- (void)receiveQRResult:(NSString *)returningURL;

@end
