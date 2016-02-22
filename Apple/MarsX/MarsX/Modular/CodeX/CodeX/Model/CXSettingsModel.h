//
//  CXSettingsModel.h
//  CodeX
//
//  Created by yuyang on 14-12-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXSettingsModel : NSObject

+ (CXSettingsModel *)shareInstance;

- (void)updateData;

@property (nonatomic, strong) NSMutableDictionary *settingsProfile;
@property (nonatomic, strong) NSArray *settingsProfileKeys;

- (NSMutableArray *)itemsWithItemType:(CXSettingsItemType)itemType;
- (void)updateItemWith:(NSArray *)item itemType:(CXSettingsItemType)itemType;

- (NSMutableDictionary *)headMetaDictionary;
- (BOOL)checkWithKeyName:(NSString *)keyName itemType:(CXSettingsItemType)itemType;
- (NSString *)openTypeKeyWith:(NSString *)url;

@end
