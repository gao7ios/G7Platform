//
//  G7TableViewActions.h
//  EDWallpaper
//
//  Created by WangMingfu on 15/10/26.
//  Copyright © 2015年 E-Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "G7Actions.h"
#import "G7TableView.h"

/**
 * The G7TableViewActions class provides an interface for attaching actions to objects from a
 * G7ActionsDataSource.
 *
 * <h2>Basic Use</h2>
 *
 * NIActionsDataSource and NITableViewActions cooperate to solve two related tasks: data
 * representation and user actions, respectively. A NIActionsDataSource provides objects and
 * NITableViewActions maintains a mapping of actions to these objects. The object's attached actions
 * are executed when the user interacts with the cell representing an object.
 *
 * <h3>Delegate Forwarding</h3>
 *
 * NITableViewActions will apply the correct accessoryType and selectionStyle values to the cell
 * when the cell is displayed using a mechanism known as <i>delegate chaining</i>. This effect is
 * achieved by invoking @link NITableViewActions::forwardingTo: forwardingTo:@endlink on the
 * NITableViewActions instance and providing the appropriate object to forward to (generally
 * @c self).
 *
 @code
 tableView.delegate = [self.actions forwardingTo:self];
 @endcode
 *
 * The dataSource property of the table view must conform to NIActionsDataSource.
 *
 * @ingroup ModelTools
 */
@interface G7TableViewActions : G7Actions <G7TableViewDelegate>

#pragma mark Forwarding
- (BOOL)shouldForwardSelector:(SEL)selector;
- (id<G7TableViewDelegate>)forwardingTo:(id<G7TableViewDelegate>)forwardDelegate;
- (void)removeForwarding:(id<G7TableViewDelegate>)forwardDelegate;

#pragma mark Object state

- (UITableViewCellAccessoryType)accessoryTypeForObject:(id)object;
- (UITableViewCellSelectionStyle)selectionStyleForObject:(id)object;

#pragma mark Configurable Properties

@property (nonatomic, assign) UITableViewCellSelectionStyle tableViewCellSelectionStyle;

@end
