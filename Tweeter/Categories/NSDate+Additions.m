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
