//
//  G7CellCatalog.h
//  EDWallpaper
//
//  Created by WangMingfu on 15/10/26.
//  Copyright © 2015年 E-Design. All rights reserved.
//

#import "G7CellFactory.h"

typedef CGFloat (^G7CellDrawRectBlock)(CGRect rect, id object, UITableViewCell* cell);

/**
 * An object that will draw the contents of the cell using a provided block.
 *
 */
@interface G7DrawRectBlockCellObject : G7CellObject
// Designated initializer.
- (id)initWithBlock:(G7CellDrawRectBlock)block object:(id)object;
+ (id)objectWithBlock:(G7CellDrawRectBlock)block object:(id)object;
@property (nonatomic, copy) G7CellDrawRectBlock block;
@property (nonatomic, strong) id object;
@end

/**
 * An object for displaying a single-line title in a table view cell.
 *
 * This object maps by default to a G7TextCell and displays the title with a
 * UITableViewCellStyleDefault cell. You can customize the cell class using the
 * G7CellObject methods.
 *
 */
@interface G7TitleCellObject : G7CellObject
// Designated initializer.
- (id)initWithTitle:(NSString *)title image:(UIImage *)image;
- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title image:(UIImage *)image cellClass:(Class)cellClass userInfo:(id)userInfo;
+ (id)objectWithTitle:(NSString *)title image:(UIImage *)image;
+ (id)objectWithTitle:(NSString *)title;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) UIImage* image;
@end

/**
 * An object for displaying two lines of text in a table view cell.
 *
 * This object maps by default to a G7TextCell and displays the title with a
 * UITableViewCellStyleSubtitle cell. You can customize the cell class using the
 * G7CellObject methods.
 *
 */
@interface G7SubtitleCellObject : G7TitleCellObject
// Designated initializer.
- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image;
- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image cellClass:(Class)cellClass userInfo:(id)userInfo;
+ (id)objectWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image;
+ (id)objectWithTitle:(NSString *)title subtitle:(NSString *)subtitle;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@end

/**
 * A general-purpose cell for displaying text.
 *
 * When given a G7TitleCellObject, will set the textLabel's text with the title.
 * When given a G7SubtitleCellObject, will also set the detailTextLabel's text with the subtitle.
 *
 */
@interface G7TextCell : UITableViewCell <G7Cell>
@end

/**
 * A cell that renders its contents using a block.
 *
 */
@interface G7DrawRectBlockCell : UITableViewCell <G7Cell>
@property (nonatomic, strong) UIView* blockView;
@end

