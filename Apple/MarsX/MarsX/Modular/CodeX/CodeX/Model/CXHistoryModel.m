//
//  HistoryURLs.m
//  NewCodeX
//
//  Created by mac on 14-3-7.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXHistoryModel.h"
#import "CXHistoryView.h"
#import "CXWebViewController.h"
#import "CXHistoryType.h"
#import "CXURLHandler.h"

@interface CXHistoryModel()

@property (strong, nonatomic) NSMutableArray *historyTypeArray;

@end

@implementation CXHistoryModel

+ (CXHistoryModel *) shareInstance
{
    static CXHistoryModel *share = nil;
    static dispatch_once_t urlOnceToken;
    dispatch_once(&urlOnceToken, ^
    {
        share = [[super allocWithZone:NULL] init];
    });
    
    return share;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
    return [self shareInstance];
}

- (id)copy
{
    id cellCopy = [super copy];
    
    return cellCopy;
}

- (id)init
{
    if (self = [super init])
    {
        self.historyTypeArray = [self restoreHistoryTypeArray];
    }
    
    return self;
}

//数据操作提取

- (void)removeHistoryType:(NSUInteger)index
{
    if (index < [self count])
    {
        [self.historyTypeArray removeObjectAtIndex:index];
    }
}

- (void)appendHistoryType:(CXHistoryType *)historyType
{
    if (historyType != nil)
    {
        if (![historyType.url isEqualToString:[self getHistoryTypeURL:0]])
        {
            if ([self count] >= 300)
            {
                [self.historyTypeArray removeLastObject];
            }
            
            [self.historyTypeArray insertObject:historyType atIndex:0];
        }
        else
        {
            if (![historyType.title isEqualToString:[self getHistoryTypeTitle:0]])
            {
                if ([self count] >= 300)
                {
                    [self.historyTypeArray removeLastObject];
                }
                [self removeHistoryType:0];
                [self.historyTypeArray insertObject:historyType atIndex:0];
            }
        }
    }
}

- (NSString *)getHistoryTypeURL:(NSUInteger)index
{
    NSString *url = @"";
    if (index < [self count])
    {
        CXHistoryType *historyType = [self.historyTypeArray objectAtIndex:index];
        url = historyType.url;
    }

    return url;
}
- (NSString *)getHistoryTypeTitle:(NSUInteger)index
{
    NSString *title = @"";
    if (index < [self count])
    {
        CXHistoryType *historyType = [self.historyTypeArray objectAtIndex:index];
        title = historyType.title;
    }
    
    return title;
}

- (void)cleanHistoryTypeArray
{
    self.historyTypeArray = [self defaultHistoryTypeArray];
}

//储存方法
- (NSMutableArray *)defaultHistoryTypeArray
{
    NSMutableArray *historyTypeArray = [NSMutableArray array];
    NSMutableArray *defaultHistoryArray = [[CXSettingsModel shareInstance] itemsWithItemType:CXSettingsItemTypeHomeShortcuts];
    for (NSArray *arr in defaultHistoryArray)
    {
        CXHistoryType *historyType = [[CXHistoryType alloc] init];
        [historyType setValue:arr[1] forKey:@"url"];
        [historyType setValue:arr[0] forKey:@"title"];
        [historyTypeArray addObject:historyType];
    }
    
    return historyTypeArray;
}

- (NSUInteger)count
{
    return [self.historyTypeArray count];
}

- (NSString *)pathForTypeFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (![fileManager fileExistsAtPath:document])
    {
        [fileManager createDirectoryAtPath:document withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return [document stringByAppendingPathComponent:CXFileName];
}

- (void)storeHistoryTypeArray
{
    if ([self.historyTypeArray count] > 0)
    {
        if ([self count] >= 300)
        {
            [self.historyTypeArray removeLastObject];
        }
        NSString *path = [self pathForTypeFile];
        [NSKeyedArchiver archiveRootObject:self.historyTypeArray toFile:path];
    }
}

- (NSMutableArray *)restoreHistoryTypeArray
{
    NSString *path = [self pathForTypeFile];
    NSMutableArray *historyTypeArray= [NSMutableArray array];
    historyTypeArray = [NSKeyedUnarchiver
                        unarchiveObjectWithFile:path];
    if ([historyTypeArray count] == 0)
    {
        historyTypeArray = [self defaultHistoryTypeArray];
    }
    
    return  historyTypeArray;
}

@end
