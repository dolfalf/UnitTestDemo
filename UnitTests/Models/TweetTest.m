//
//  TweetTest.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "Tweet.h";

@interface TweetTest : GHTestCase {}
@end

@implementation TweetTest

#pragma mark -
#pragma mark Test Methods

- (void)testKeyValueCoding {
	NSString *textString = @"This is a text tweet";
	NSString *dateString = @"Fri Oct 08 20:56:25 +0000 2010";
	
	Tweet *tweet = [[[Tweet alloc] init] autorelease];
	[tweet setValue:textString forKey:@"text"];
	[tweet setValue:dateString forKey:@"created_at"];
	
	GHAssertEqualStrings(tweet.text, textString, nil);
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	
	GHAssertEqualStrings([formatter stringFromDate:tweet.date], @"10/8/10", nil);
}

@end
