//
//  G7ViewRecycler.h
//  G7Core
//
//  Created by WangMingfu on 15/11/2.
//  Copyright © 2015年 Tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * For recycling views in scroll views.
 *
 * @ingroup NimbusCore
 * @defgroup Core-View-Recycling View Recyling
 * @{
 *
 * View recycling is an important aspect of iOS memory management and performance when building
 * scroll views. UITableView uses view recycling via the table cell dequeue mechanism.
 * NIViewRecycler implements this recycling functionality, allowing you to implement recycling
 * mechanisms in your own views and controllers.
 *
 *
 * <h2>Example Use</h2>
 *
 * Imagine building a UITableView. We'll assume that a viewRecycler object exists in the view.
 *
 * Views are usually recycled once they are no longer on screen, so within a did scroll event
 * we might have code like the following:
 *
 @code
 for (UIView<NIRecyclableView>* view in visibleViews) {
 if (![self isVisible:view]) {
 [viewRecycler recycleView:view];
 [view removeFromSuperview];
 }
 }
 @endcode
 *
 * This will take the views that are no longer visible and add them to the recycler. At a later
 * point in that same didScroll code we will check if there are any new views that are visible.
 * This is when we try to dequeue a recycled view from the recycler.
 *
 @code
 UIView<NIRecyclableView>* view = [viewRecycler dequeueReusableViewWithIdentifier:reuseIdentifier];
 if (nil == view) {
 // Allocate a new view that conforms to the NIRecyclableView protocol.
 view = [[[...]] autorelease];
 }
 [self addSubview:view];
 @endcode
 *
 */

@protocol G7RecyclableView;

/**
 * An object for efficiently reusing views by recycling and dequeuing them from a pool of views.
 *
 * This sort of object is likely what UITableView and NIPagingScrollView use to recycle their views.
 */
@interface G7ViewRecycler : NSObject

- (UIView<G7RecyclableView> *)dequeueReusableViewWithIdentifier:(NSString *)reuseIdentifier;

- (void)recycleView:(UIView<G7RecyclableView> *)view;

- (void)removeAllViews;

@end


/**
 * The NIRecyclableView protocol defines a set of optional methods that a view may implement to
 * handle being added to a NIViewRecycler.
 */
@protocol G7RecyclableView <NSObject>

@optional

/**
 * The identifier used to categorize views into buckets for reuse.
 *
 * Views will be reused when a new view is requested with a matching identifier.
 *
 * If the reuseIdentifier is nil then the class name will be used.
 */
@property (nonatomic, copy) NSString* reuseIdentifier;

/**
 * Called immediately after the view has been dequeued from the recycled view pool.
 */
- (void)prepareForReuse;

@end


/**
 * A simple implementation of the NIRecyclableView protocol as a UIView.
 *
 * This class can be used as a base class for building recyclable views if specific reuse
 * identifiers are necessary, e.g. when the same class might have different implementations
 * depending on the reuse identifier.
 *
 * Assuming functionality is consistent for a given class it is simpler not to have a
 * reuseIdentifier, making the view recycler use the class name as the reuseIdentifier. In this case
 * subclassing this class is overkill.
 */
@interface G7RecyclableView : UIView <G7RecyclableView>

// Designated initializer.
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, copy) NSString* reuseIdentifier;

@end
