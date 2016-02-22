//
//  G7ImageManager.h
//  G7Network
//
//  Created by WangMingfu on 14-4-2.
//  Copyright (c) 2014年 tandy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "G7NetworkOperation.h"
#import "G7ImageDownloader.h"
#import "G7ImageCache.h"

typedef enum
{
    /**
     * By default, when a URL fail to be downloaded, the URL is blacklisted so the library won't keep trying.
     * This flag disable this blacklisting.
     */
    G7WebImageRetryFailed = 1 << 0,
    /**
     * By default, image downloads are started during UI interactions, this flags disable this feature,
     * leading to delayed download on UIScrollView deceleration for instance.
     */
    G7WebImageLowPriority = 1 << 1,
    /**
     * This flag disables on-disk caching
     */
    G7WebImageCacheMemoryOnly = 1 << 2,
    /**
     * This flag enables progressive download, the image is displayed progressively during download as a browser would do.
     * By default, the image is only displayed once completely downloaded.
     */
    G7WebImageProgressiveDownload = 1 << 3
} G7WebImageOptions;

typedef void(^G7WebImageCompletedBlock)(UIImage *image, NSError *error, G7ImageCacheType cacheType);
typedef void(^G7WebImageCompletedWithFinishedBlock)(UIImage *image, NSError *error, G7ImageCacheType cacheType, BOOL finished);


/**
 * The G7WebImageManager is the class behind the UIImageView+WebCache category and likes.
 * It ties the asynchronous downloader (G7WebImageDownloader) with the image cache store (SDImageCache).
 * You can use this class directly to benefit from web image downloading with caching in another context than
 * a UIView.
 *
 * Here is a simple example of how to use G7WebImageManager:
 *
 *  G7WebImageManager *manager = [G7WebImageManager sharedManager];
 *  [manager downloadWithURL:imageURL
 *                  delegate:self
 *                   options:0
 *                  progress:nil
 *                 completed:^(UIImage *image, NSError *error, BOOL fromCache)
 *                 {
 *                     if (image)
 *                     {
 *                         // do something with image
 *                     }
 *                 }];
 */

@interface G7ImageManager : NSObject

@property (strong, nonatomic, readonly) G7ImageCache *imageCache;
@property (strong, nonatomic, readonly) G7ImageDownloader *imageDownloader;

/**
 * The cache filter is a block used each time G7WebImageManager need to convert an URL into a cache key. This can
 * be used to remove dynamic part of an image URL.
 *
 * The following example sets a filter in the application delegate that will remove any query-string from the
 * URL before to use it as a cache key:
 *
 * 	[[G7WebImageManager sharedManager] setCacheKeyFilter:^(NSURL *url)
 *	{
 *	    url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
 *	    return [url absoluteString];
 *	}];
 */
@property (strong) NSString *(^cacheKeyFilter)(NSURL *url);

/**
 * Returns global G7WebImageManager instance.
 *
 * @return G7WebImageManager shared instance
 */
+ (G7ImageManager *)sharedManager;

/**
 * Downloads the image at the given URL if not present in cache or return the cached version otherwise.
 *
 * @param url The URL to the image
 * @param delegate The delegate object used to send result back
 * @param options A mask to specify options to use for this request
 * @param progressBlock A block called while image is downloading
 * @param completedBlock A block called when operation has been completed.
 *
 *                       This block as no return value and takes the requested UIImage as first parameter.
 *                       In case of error the image parameter is nil and the second parameter may contain an NSError.
 *
 *                       The third parameter is a Boolean indicating if the image was retrived from the local cache
 *                       of from the network.
 *
 *                       The last parameter is set to NO when the G7WebImageProgressiveDownload option is used and
 *                       the image is downloading. This block is thus called repetidly with a partial image. When
 *                       image is fully downloaded, the block is called a last time with the full image and the last
 *                       parameter set to YES.
 *
 * @return Returns a cancellable NSOperation
 */
- (id<G7Operation>)downloadWithURL:(NSURL *)url
								options:(G7WebImageOptions)options
							   progress:(G7WebImageDownloaderProgressBlock)progressBlock
							  completed:(G7WebImageCompletedWithFinishedBlock)completedBlock;

- (id<G7Operation>)downloadWithURL:(NSURL *)url
							headerFields:(NSDictionary *)fields
						   options:(G7WebImageOptions)options
						  progress:(G7WebImageDownloaderProgressBlock)progressBlock
						 completed:(G7WebImageCompletedWithFinishedBlock)completedBlock;

- (id<G7Operation>)downloadWithURL:(NSURL *)url
							headerFields:(NSDictionary *)fields
							cacheType:(G7ImageCacheType)cacheType
						   options:(G7WebImageOptions)options
						  progress:(G7WebImageDownloaderProgressBlock)progressBlock
						 completed:(G7WebImageCompletedWithFinishedBlock)completedBlock;


/**
 * Cancel all current opreations
 */
- (void)cancelAll;

@end

@interface G7ImageManager (Deprecated)

#pragma mark - Deprecated

/**
 *  Cancel the operation with the given url.
 *
 *  @deprecated This method has been deprecated. Use `cancelAll`
 */
- (void)cancelWithRequestURL:(NSString *)url __deprecated_msg("Method deprecated. Use `cancelAll`");

@end
