//
//  KeyMacro.h
//  CodeX
//
//  Created by yuyang on 14-12-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#ifndef CodeX_KeyMacro_h
#define CodeX_KeyMacro_h

#define CXSettingsItemKeyHeadMeta @"CXSettingsItemKeyHeadMeta"
#define CXSettingsItemKeyURLFilter @"CXSettingsItemKeyURLFilter"
#define CXSettingsItemKeyHomeShortcuts @"CXSettingsItemKeyHomeShortcuts"
#define CXSettingsItemKeyTodayShortcuts @"CXSettingsItemKeyTodayShortcuts"

typedef enum : NSUInteger
{
    CXSettingsItemTypeHeadMeta = 0,
    CXSettingsItemTypeURLFilter,
    CXSettingsItemTypeHomeShortcuts,
    CXSettingsItemTypeTodayShortcuts,
}
CXSettingsItemType;

#define CXWebOpenNavPushKey @"navPush"
#define CXWebOpenModalPresentKey @"modalPresent"

#endif
