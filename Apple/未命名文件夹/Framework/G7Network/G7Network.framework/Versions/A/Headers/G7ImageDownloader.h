//
//  G7ImageDownloader.h
//  G7Network
//
//  Created by WangMingfu on 14-4-2.
//  Copyright (c) 2014年 tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "G7NetworkOperation.h"
#import "G7URLRequestSerialization.h"
#import "G7URLResponseSerialization.h"

typedef enum
{
    G7WebImageDownloaderLowPriority = 1 << 0,
    G7WebImageDownloaderProgressiveDownload = 1 << 1
} G7WebImageDownloaderOptions;

typedef void(^G7WebImageDownloaderProgressBlock)(NSUInteger receivedSize, long long expectedSize);
typedef void(^G7WebImageDownloaderCompletedBlock)(UIImage *image, NSData *data, NSError *error, BOOL finished);

/**
 * Asynchronous downloader dedicated and optimized for image loading.
 */
@interface G7ImageDownloader : NSObject


@property (assign, nonatomic) NSInteger maxConcurrentDownloads;


@property (nonatomic, strong) G7NetworkSerializer <G7URLRequestSerialization> * requestSerializer;


@property (nonatomic, strong) G7HTTPResponseSerializer <G7URLResponseSerialization> * responseSerializer;

+ (G7ImageDownloader *)sharedDownloader;

/**
 * Creates a G7WebImageDownloader async downloader instance with a given URL
 *
 * The delegate will be informed when the image is finish downloaded or an error has happen.
 *
 * @see G7WebImageDownloaderDelegate
 *
 * @param url The URL to the image to download
 * @param options The options to be used for this download
 * @param progress A block called repeatedly while the image is downloading
 * @param completed A block called once the download is completed.
 *                  If the download succeeded, the image parameter is set, in case of error,
 *                  error parameter is set with the error. The last parameter is always YES
 *                  if G7WebImageDownloaderProgressiveDownload isn't use. With the
 *                  G7WebImageDownloaderProgressiveDownload option, this block is called
 *                  repeatedly with the partial image object and the finished argument set to NO
 *                  before to be called a last time with the full image and finished argument
 *                  set to YES. In case of error, the finished argument is always YES.
 *
 * @return A cancellable G7WebImageOperation
 */
- (G7NetworkOperation *)downloadImageWithURL:(NSURL *)url
									 options:(G7WebImageDownloaderOptions)options
									progress:(G7WebImageDownloaderProgressBlock)progressBlock
								   completed:(G7WebImageDownloaderCompletedBlock)completedBlock;

- (G7NetworkOperation *)downloadImageWithURL:(NSURL *)url
								headerFields:(NSDictionary *)fields
									 options:(G7WebImageDownloaderOptions)options
									progress:(G7WebImageDownloaderProgressBlock)progressBlock
								   completed:(G7WebImageDownloaderCompletedBlock)completedBlock;


@end
