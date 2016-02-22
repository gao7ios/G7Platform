//
//  CXSettingsModel.m
//  CodeX
//
//  Created by yuyang on 14-12-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CXSettingsModel.h"

@interface CXSettingsModel()

@end

@implementation CXSettingsModel

+ (CXSettingsModel *)shareInstance
{
    static CXSettingsModel *share = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^
                  {
                      share = [[CXSettingsModel alloc] init];
                  });
    
    return share;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.settingsProfile = [NSMutableDictionary dictionary];
        self.settingsProfileKeys = [NSMutableArray arrayWithObjects:CXSettingsItemKeyHeadMeta,CXSettingsItemKeyURLFilter,CXSettingsItemKeyHomeShortcuts,CXSettingsItemKeyTodayShortcuts, nil];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        for (NSString *settingsProfileKey in self.settingsProfileKeys)
        {
            NSArray *arr = [userDefaults arrayForKey:settingsProfileKey];
            [self.settingsProfile setValue:arr forKey:settingsProfileKey];
        }
    }
    
    return self;
}

- (void)updateData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    for (NSString *settingsProfileKey in self.settingsProfileKeys)
    {
        [userDefaults setObject:[self.settingsProfile valueForKey:settingsProfileKey] forKey:settingsProfileKey];
    }
    
    [userDefaults synchronize];
}

- (NSMutableArray *)itemsWithItemType:(CXSettingsItemType)itemType
{
    NSMutableArray *array;
    
    NSString *keyName = [self.settingsProfileKeys objectAtIndex:itemType];
    NSArray *profiles = [self.settingsProfile objectForKey:keyName];
    array = [NSMutableArray arrayWithArray:profiles];
    
    return array;
}

- (void)updateItemWith:(NSArray *)item itemType:(CXSettingsItemType)itemType
{
    NSString *keyName = [self.settingsProfileKeys objectAtIndex:itemType];
    [self.settingsProfile setValue:item forKey:keyName];
}

- (NSMutableDictionary *)headMetaDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (NSArray *arr in [self.settingsProfile valueForKey:CXSettingsItemKeyHeadMeta])
    {
        [dic setValue:arr[1] forKey:arr[0]];
    }
    
    return dic;
}

- (BOOL)checkWithKeyName:(NSString *)keyName itemType:(CXSettingsItemType)itemType
{
    NSString *settingsKey = [self.settingsProfileKeys objectAtIndex:itemType];
    NSArray *settingItems = [self.settingsProfile valueForKey:settingsKey];
    for (NSArray *item in settingItems)
    {
        if ([item[0] isEqualToString:keyName])
        {
           return YES;
        }
    }
    
    return NO;
}

- (NSString *)openTypeKeyWith:(NSString *)url
{
    NSString *openTypeKey = @"";
    NSArray *settingItems = [self.settingsProfile valueForKey:CXSettingsItemKeyURLFilter];
    for (NSArray *item in settingItems)
    {
        if ([url rangeOfString:item[0]].length > 0)
        {
            openTypeKey = item[1];
            break;
        }
    }
    
    return openTypeKey;
}

@end
