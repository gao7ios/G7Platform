//
//  G7QuickMacro.h
//  Gao7PadTool
//
//  Created by WangMingfu on 14/7/21.
//  Copyright (c) 2014年 Tandy. All rights reserved.
//

#undef	IS_CH
#define IS_CH( __ch )	([[G7CommonSetting sharedInstance].ch  integerValue]	==	__ch)

#undef	IS_PID
#define IS_PID(__pid)	([[G7CommonSetting sharedInstance].pid integerValue]	==	__pid)

#undef	IS_PT
#define IS_PT(__pt)		([[G7CommonSetting sharedInstance].pt  integerValue]	==	__pt)

#undef	IS_VER
#define IS_VER(__ver)			([[G7CommonSetting sharedInstance].ver integerValue]	==	__ver)

#undef	IS_LATER_VER
#define IS_LATER_VER(__ver)		([[G7CommonSetting sharedInstance].ver integerValue]	>	__ver)

#undef	IS_EARLIER_VER
#define IS_EARLIER_VER(__ver)	([[G7CommonSetting sharedInstance].ver integerValue]	<	__ver)







