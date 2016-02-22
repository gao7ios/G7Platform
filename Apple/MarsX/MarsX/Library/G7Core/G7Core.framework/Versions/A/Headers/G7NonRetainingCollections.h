//
//  G7NonRetainingCollections.h
//  EDWallpaper
//
//  Created by WangMingfu on 15/10/26.
//  Copyright © 2015年 E-Design. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif
	
	/**
	 * For collections that don't retain their objects.
	 *
	 * @ingroup NimbusCore
	 * @defgroup Non-Retaining-Collections Non-Retaining Collections
	 * @{
	 *
	 * Non-retaining collections have historically been used when we needed more than one delegate
	 * in an object. However, NSNotificationCenter is a much better solution for n > 1 delegates.
	 * Using a non-retaining collection is dangerous, so if you must use one, use it with extreme care.
	 * The danger primarily lies in the fact that by all appearances the collection should still
	 * operate like a regular collection, so this might lead to a lot of developer error if the
	 * developer assumes that the collection does, in fact, retain the object.
	 */
	
	/**
	 * Creates a mutable array which does not retain references to the objects it contains.
	 *
	 * Typically used with arrays of delegates.
	 */
	NSMutableArray* G7CreateNonRetainingMutableArray(void);
	
	/**
	 * Creates a mutable dictionary which does not retain references to the values it contains.
	 *
	 * Typically used with dictionaries of delegates.
	 */
	NSMutableDictionary* G7CreateNonRetainingMutableDictionary(void);
	
	/**
	 * Creates a mutable set which does not retain references to the values it contains.
	 *
	 * Typically used with sets of delegates.
	 */
	NSMutableSet* G7CreateNonRetainingMutableSet(void);
	
#if defined __cplusplus
};
#endif

/**@}*/// End of Non-Retaining Collections ////////////////////////////////////////////////////////
