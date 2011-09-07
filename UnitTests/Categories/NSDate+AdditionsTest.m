//
//  NSDate+AdditionsTest.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "NSDate+Additions.h"

@interface NSDateAdditionsTest : GHTestCase {}
@end

@implementation NSDateAdditionsTest

#pragma mark -
#pragma mark Test Methods

- (void)testRelativeDateString {
	
	NSDate *lessThanMinute = [NSDate dateWithTimeIntervalSinceNow:-(MINUTE - 1)];
	GHAssertEqualStrings([lessThanMinute relativeDateString], @"59 seconds ago", nil);
	
	NSDate *lessThanTwoMinutes = [NSDate dateWithTimeIntervalSinceNow:-(MINUTE + 1)];
	GHAssertEqualStrings([lessThanTwoMinutes relativeDateString], @"about a minute ago", nil);
	
	NSDate *lessThanHour = [NSDate dateWithTimeIntervalSinceNow:-(MINUTE * 23)];
	GHAssertEqualStrings([lessThanHour relativeDateString], @"23 minutes ago", nil);	
}

- (void)testDateFromTwitterDateString {
	
	NSString *dateString = @"Fri Oct 08 20:56:25 +0000 2010";
	
	NSDate *date = [NSDate dateFromTwitterDateString:dateString];
	GHAssertNotNil(date, nil);
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	// Test components of parsed date
	NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit | NSYearCalendarUnit | 
														 NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
	
	GHAssertEquals([components weekday], 6, @"Invalid weekday, should have been Friday (6)");
	GHAssertEquals([components year], 2010, @"Invalid year");
	GHAssertEquals([components month], 10, @"Invalid month");
	GHAssertEquals([components day], 8, @"Invalid day");
	
}

@end
