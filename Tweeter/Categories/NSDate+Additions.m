//
//  NSDate+Additions.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "NSDate+Additions.h"

#define TWITTER_DATE_FORMAT @"EEE LLL dd HH:mm:ss Z yyyy"

@implementation NSDate (NSDateAdditions)

- (NSString *)relativeDateString {

	NSTimeInterval elapsed = abs([self timeIntervalSinceNow]);

	if (elapsed < MINUTE) {
		NSInteger seconds = (NSInteger) elapsed;
		return [NSString stringWithFormat:@"%lu seconds ago", seconds];
	} else if (elapsed < 2 * MINUTE) {
		return @"about a minute ago";
	} else if (elapsed < HOUR) {
		NSInteger mins = (NSInteger) (elapsed / MINUTE);
		return [NSString stringWithFormat:@"%lu minutes ago", mins];
	} else if (elapsed < HOUR * 1.5) {
		return @"about an hour ago";
	} else if (elapsed < DAY) {
		NSInteger hours = (NSInteger) ((elapsed + HOUR / 2) / HOUR);
		return [NSString stringWithFormat:@"%lu hours ago", hours];
	} else {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterShortStyle];
		return [formatter stringFromDate:self];
	}
}

+ (NSDate *)dateFromTwitterDateString:(NSString *)dateString {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeStyle:NSDateFormatterFullStyle];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:TWITTER_DATE_FORMAT];
	
	NSDate *twitterDate = [formatter dateFromString:dateString];
	return twitterDate;
}

@end
