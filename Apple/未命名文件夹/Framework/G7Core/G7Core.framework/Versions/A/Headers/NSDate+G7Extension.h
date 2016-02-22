//
//  NSDate+G7Extension.h
//  PhoneTool
//
//  Created by WangMingfu on 14-5-5.
//
//

#import "G7Precompile.h"

#pragma mark -

#define SECOND	(1)
#define MINUTE	(60 * SECOND)
#define HOUR	(60 * MINUTE)
#define DAY		(24 * HOUR)
#define MONTH	(30 * DAY)
#define YEAR	(12 * MONTH)

#pragma mark -

@interface NSDate (G7Extension)

//@property (nonatomic, readonly) NSInteger	year;
//@property (nonatomic, readonly) NSInteger	month;
//@property (nonatomic, readonly) NSInteger	day;
//@property (nonatomic, readonly) NSInteger	hour;
//@property (nonatomic, readonly) NSInteger	minute;
//@property (nonatomic, readonly) NSInteger	second;
//@property (nonatomic, readonly) NSInteger	weekday;

- (NSString *)stringWithDateFormat:(NSString *)format;
//- (NSString *)timeAgo;
//- (NSString *)timeLeft;

//+ (long long)timeStamp;

+ (NSDate *)dateWithString:(NSString *)string;
//+ (NSDate *)now;

@end
