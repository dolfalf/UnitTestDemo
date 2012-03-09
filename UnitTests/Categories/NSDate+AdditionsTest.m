//
//  MIT License
//
//  Copyright (c) 2012 TapHarmonic, LLC http://tapharmonic.com/
//  Created by Bob McCune http://bobmccune.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSDate+Additions.h"

@interface NSDateAdditionsTest : GHTestCase
@end

@implementation NSDateAdditionsTest

#pragma mark -
#pragma mark Test Methods

- (void)testRelativeDateString {
	
	NSDate *lessThanMinute = [NSDate dateWithTimeIntervalSinceNow:-(MINUTE - 1)];
	
	assertThat([lessThanMinute relativeDateString], is(@"59 seconds ago"));
	GHAssertEqualStrings([lessThanMinute relativeDateString], @"59 seconds ago", nil);
	
	NSDate *lessThanTwoMinutes = [NSDate dateWithTimeIntervalSinceNow:-(MINUTE + 1)];
	
	assertThat([lessThanTwoMinutes relativeDateString], is(@"about a minute ago"));
	GHAssertEqualStrings([lessThanTwoMinutes relativeDateString], @"about a minute ago", nil);
	
	NSDate *lessThanHour = [NSDate dateWithTimeIntervalSinceNow:-(MINUTE * 23)];
	GHAssertEqualStrings([lessThanHour relativeDateString], @"23 minutes ago", nil);	
}

- (void)testDateFromTwitterDateString {
	
	NSString *dateString = @"Fri Oct 08 20:56:25 +0000 2010";
	
	NSDate *date = [NSDate dateFromTwitterDateString:dateString];

	assertThat(date, notNilValue());
	
	GHAssertNotNil(date, nil);
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	// Test components of parsed date
	NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit | NSYearCalendarUnit | 
														 NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
	
	assertThatInteger([components weekday], equalToInteger(6));
	
	GHAssertEquals([components weekday], 6, @"Invalid weekday, should have been Friday (6)");
	GHAssertEquals([components year], 2010, @"Invalid year");
	GHAssertEquals([components month], 10, @"Invalid month");
	GHAssertEquals([components day], 8, @"Invalid day");
	
}

@end
