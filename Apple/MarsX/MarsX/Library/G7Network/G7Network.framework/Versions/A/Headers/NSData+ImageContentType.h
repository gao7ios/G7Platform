//
//  NSData+ImageContentType.h
//  G7Network
//
//  Created by WangMingfu on 15/8/18.
//  Copyright (c) 2015年 tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ImageContentType)

/**
 *  Compute the content type for an image data
 *
 *  @param data the input data
 *
 *  @return the content type as string (i.e. image/jpeg, image/gif)
 */
+ (NSString *)g7_contentTypeForImageData:(NSData *)data;

@end
