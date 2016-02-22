//
//  G7LoadableTableViewActions.h
//  G7Core
//
//  Created by WangMingfu on 15/10/28.
//  Copyright © 2015年 Tandy. All rights reserved.
//
#import "G7TableViewActions.h"
#import "G7TableFooter.h"
#import "G7Refresh.h"

@interface G7LoadableTableViewActions : G7TableViewActions <G7TableFooterDelegate, G7RefreshDelegate>

#pragma mark Forwarding
- (BOOL)shouldForwardSelector:(SEL)selector;

@end
