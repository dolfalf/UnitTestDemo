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

#import "Tweet.h"

@interface TweetTest : GHTestCase
@end

@implementation TweetTest

#pragma mark -
#pragma mark Test Methods

- (void)testKeyValueCoding {
	NSString *textString = @"This is a text tweet";
	NSString *dateString = @"Fri Oct 08 20:56:25 +0000 2010";
	
	Tweet *tweet = [[Tweet alloc] init];
	[tweet setValue:textString forKey:@"text"];
	[tweet setValue:dateString forKey:@"created_at"];
	
	GHAssertEqualStrings(tweet.text, textString, nil);
	assertThat(tweet.text, is(textString));
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	
	GHAssertEqualStrings([formatter stringFromDate:tweet.date], @"10/8/10", nil);
}

@end
