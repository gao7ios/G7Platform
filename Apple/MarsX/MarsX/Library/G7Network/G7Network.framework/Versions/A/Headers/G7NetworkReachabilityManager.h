//
//  G7NetworkReachabilityManager.h
//  G7Network
//
//  Created by WangMingfu on 14-3-20.
//  Copyright (c) 2014年 tandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

typedef NS_ENUM(NSInteger, G7NetworkReachabilityStatus) {
    G7NetworkReachabilityStatusUnknown          = -1,
    G7NetworkReachabilityStatusNotReachable     = 0,
    G7NetworkReachabilityStatusReachableViaWWAN = 1,
    G7NetworkReachabilityStatusReachableViaWiFi = 2,
};

/**
 `G7NetworkReachabilityManager` monitors the reachability of domains, and addresses for both WWAN and WiFi network interfaces.
 
 See Apple's Reachability Sample Code (https://developer.apple.com/library/ios/samplecode/reachability/)
 
 @warning Instances of `G7NetworkReachabilityManager` must be started with `-startMonitoring` before reachability status can be determined.
 */
@interface G7NetworkReachabilityManager : NSObject

/**
 The current network reachability status.
 */
@property (readonly, nonatomic, assign) G7NetworkReachabilityStatus networkReachabilityStatus;

/**
 Whether or not the network is currently reachable.
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

/**
 Whether or not the network is currently reachable via WWAN.
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

/**
 Whether or not the network is currently reachable via WiFi.
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;

///---------------------
/// @name Initialization
///---------------------

/**
 Returns the shared network reachability manager.
 */
+ (instancetype)sharedManager;

/**
 Creates and returns a network reachability manager for the specified domain.
 
 @param domain The domain used to evaluate network reachability.
 
 @return An initialized network reachability manager, actively monitoring the specified domain.
 */
+ (instancetype)managerForDomain:(NSString *)domain;

/**
 Creates and returns a network reachability manager for the socket address.
 
 @param address The socket address used to evaluate network reachability.
 
 @return An initialized network reachability manager, actively monitoring the specified socket address.
 */
+ (instancetype)managerForAddress:(const struct sockaddr_in *)address;

/**
 Initializes an instance of a network reachability manager from the specified reachability object.
 
 @param reachability The reachability object to monitor.
 
 @return An initialized network reachability manager, actively monitoring the specified reachability.
 */
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability;

///--------------------------------------------------
/// @name Starting & Stopping Reachability Monitoring
///--------------------------------------------------

/**
 Starts monitoring for changes in network reachability status.
 */
- (void)startMonitoring;

/**
 Stops monitoring for changes in network reachability status.
 */
- (void)stopMonitoring;

///-------------------------------------------------
/// @name Getting Localized Reachability Description
///-------------------------------------------------

/**
 Returns a localized string representation of the current network reachability status.
 */
- (NSString *)localizedNetworkReachabilityStatusString;

///---------------------------------------------------
/// @name Setting Network Reachability Change Callback
///---------------------------------------------------

/**
 Sets a callback to be executed when the network availability of the `baseURL` host changes.
 
 @param block A block object to be executed when the network availability of the `baseURL` host changes.. This block has no return value and takes a single argument which represents the various reachability states from the device to the `baseURL`.
 */
- (void)setReachabilityStatusChangeBlock:(void (^)(G7NetworkReachabilityStatus status))block;

@end

///----------------
/// @name Constants
///----------------

/**
 ## Network Reachability
 
 The following constants are provided by `G7NetworkReachabilityManager` as possible network reachability statuses.
 
 enum {
 G7NetworkReachabilityStatusUnknown,
 G7NetworkReachabilityStatusNotReachable,
 G7NetworkReachabilityStatusReachableViaWWAN,
 G7NetworkReachabilityStatusReachableViaWiFi,
 }
 
 ### Keys for Notification UserInfo Dictionary
 
 Strings that are used as keys in a `userInfo` dictionary in a network reachability status change notification.
 
 `G7NetworkReachabilityNotificationStatusItem`
 A key in the userInfo dictionary in a `G7NetworkReachabilityDidChangeNotification` notification.
 The corresponding value is an `NSNumber` object representing the `G7NetworkReachabilityStatus` value for the current reachability status.
 */

///--------------------
/// @name Notifications
///--------------------

/**
 Posted when network reachability changes.
 This notification assigns no notification object. The `userInfo` dictionary contains an `NSNumber` object under the `G7NetworkReachabilityNotificationStatusItem` key, representing the `G7NetworkReachabilityStatus` value for the current network reachability.
 
 @warning In order for network reachability to be monitored, include the `SystemConfiguration` framework in the active target's "Link Binary With Library" build phase, and add `#import <SystemConfiguration/SystemConfiguration.h>` to the header prefix of the project (`Prefix.pch`).
 */
extern NSString * const G7NetworkReachabilityDidChangeNotification;
extern NSString * const G7NetworkReachabilityNotificationStatusItem;

///--------------------
/// @name Functions
///--------------------

/**
 Returns a localized string representation of an `G7NetworkReachabilityStatus` value.
 */
extern NSString * G7StringFromNetworkReachabilityStatus(G7NetworkReachabilityStatus status);
