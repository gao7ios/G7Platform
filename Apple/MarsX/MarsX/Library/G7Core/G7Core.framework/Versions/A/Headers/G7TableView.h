//
//  G7TableView.h
//  G7Core
//
//  Created by WangMingfu on 15/1/26.
//  Copyright (c) 2015年 Tandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class G7TableView;

@protocol G7TableViewDelegate <UITableViewDelegate>

@optional


@end

@protocol G7TableViewDataSource <UITableViewDataSource>
@end

@interface G7TableView : UITableView 

@property (nonatomic, weak, nullable) id<G7TableViewDelegate> delegate;
@property (nonatomic, weak, nullable) id<G7TableViewDataSource> dataSource;

@end
