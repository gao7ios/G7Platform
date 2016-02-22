//
//  G7ImageCache.h
//  G7Network
//
//  Created by WangMingfu on 14-4-2.
//  Copyright (c) 2014年 tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

enum G7ImageCacheType
{
    /**
     * The image wasn't available the G7WebImage caches, but was downloaded from the web.
     */
    G7ImageCacheTypeNone = 0,
    /**
     * The image was obtained from the disk cache.
     */
    G7ImageCacheTypeDisk,
    /**
     * The image was obtained from the disk cache.
     */
    G7ImageCacheTypeMemory
};
typedef enum G7ImageCacheType G7ImageCacheType;


/**
 * SDImageCache maintains a memory cache and an optional disk cache. Disk cache write operations are performed
 * asynchronous so it doesn’t add unnecessary latency to the UI.
 */
@interface G7ImageCache : NSObject

/**
 * The maximum length of time to keep an image in the cache, in seconds
 */
@property (assign, nonatomic) NSInteger maxCacheAge;

/**
 * Returns global shared cache instance
 *
 * @return SDImageCache global instance
 */
+ (G7ImageCache *)sharedImageCache;

/**
 * Init a new cache store with a specific namespace
 *
 * @param ns The namespace to use for this cache store
 */
- (id)initWithNamespace:(NSString *)ns;

/**
 * Store an image into memory and disk cache at the given key.
 *
 * @param image The image to store
 * @param key The unique image cache key, usually it's image absolute URL
 */
- (void)storeImage:(UIImage *)image forKey:(NSString *)key;

/**
 * Store an image into memory and optionally disk cache at the given key.
 *
 * @param image The image to store
 * @param key The unique image cache key, usually it's image absolute URL
 * @param toDisk Store the image to disk cache if YES
 */
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk;

/**
 * Store an image into memory and optionally disk cache at the given key.
 *
 * @param image The image to store
 * @param data The image data as returned by the server, this representation will be used for disk storage
 *             instead of converting the given image object into a storable/compressed image format in order
 *             to save quality and CPU
 * @param key The unique image cache key, usually it's image absolute URL
 * @param toDisk Store the image to disk cache if YES
 */
- (void)storeImage:(UIImage *)image imageData:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk;

/**
 * Query the disk cache asynchronousely.
 *
 * @param key The unique key used to store the wanted image
 */
- (NSOperation *)queryDiskCacheForKey:(NSString *)key done:(void (^)(UIImage *image, G7ImageCacheType cacheType))doneBlock;

/**
 * Remove the image from memory and disk cache synchronousely
 *
 * @param key The unique image cache key
 */
- (void)removeImageForKey:(NSString *)key;

/**
 * Remove the image from memory and optionaly disk cache synchronousely
 *
 * @param key The unique image cache key
 * @param fromDisk Also remove cache entry from disk if YES
 */
- (void)removeImageForKey:(NSString *)key fromDisk:(BOOL)fromDisk;

/**
 * Clear all memory cached images
 */
- (void)clearMemory;

/**
 * Clear all disk cached images
 */
- (void)clearDisk;

/**
 * Remove all expired cached image from disk
 */
- (void)cleanDisk;

/**
 * Get the size used by the disk cache
 */
- (int)getSize;

/**
 * Get the number of images in the disk cache
 */
- (int)getDiskCount;

/**
 * 获取当前文件缓存路径
 *
 * @author WangMingfu
 * @date 2015-09-06 12:09:24
 *
 * @param key the key
 *
 * @return 默认的缓存路径
 */
- (NSString *)cachePathForKey:(NSString *)key;

@end

