//
//  G7PagingScrollViewPage.h
//  G7Core
//
//  Created by WangMingfu on 15/11/3.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import "G7ViewRecycler.h"

#import "G7PagingScrollView.h"

/**
 * A skeleton implementation of a page view.
 *
 * This view simply implements the required properties of NIPagingScrollViewPage.
 *
 * @ingroup NimbusPagingScrollView
 */
@interface G7PagingScrollViewPage : G7RecyclableView  <G7PagingScrollViewPage>
@property (nonatomic) NSInteger pageIndex;
@end

/**
 * The page index.
 *
 * @fn NIPagingScrollViewPage::pageIndex
 */
