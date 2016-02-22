//
//  G7LoadableTableView.h
//  G7Core
//
//  Created by WangMingfu on 15/10/27.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import "G7TableFooter.h"

@interface G7LoadableTableView : G7TableView

@property (nonatomic, weak, nullable) id<G7TableViewDelegate, G7RefreshDelegate, G7TableFooterDelegate> delegate;

@property (nonatomic, assign) G7TableFooterStyle footerStyle;
@property (nonatomic, weak, readonly) id<G7TableFooter> footer;

@property (nonatomic, assign) G7RefreshStyle refreshStyle;
@property (nonatomic, weak, readonly) id<G7Refresh> refresher;



@end
