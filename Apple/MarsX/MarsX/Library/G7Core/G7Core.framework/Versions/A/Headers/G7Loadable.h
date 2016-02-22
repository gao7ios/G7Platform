//
//  G7Loadable.h
//  G7Core
//
//  Created by WangMingfu on 15/10/27.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, G7LoadableStyle) {
	G7LoadableStyleNone,				// none.
	G7LoadableStyleAutoLoading,			// when table is scroll to bottom, auto loading next page
	G7LoadableStyleUserPeform,			// do not loading next page, until user
	G7LoadableStyleCustom
};


@protocol G7Loadable <NSObject>

@required

- (void)startLoading;
- (void)stopLoading;

@property (nonatomic, assign, getter=isFinished) BOOL finished;
@property (nonatomic, assign, getter=isLoading) BOOL loading;

@end
