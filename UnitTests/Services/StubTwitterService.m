//
//  StubTwitterService.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "StubTwitterService.h"


@implementation StubTwitterService 

- (id)initWithTweets:(NSArray *)theTweets {
	if (self = [super init]) {
		tweets = [theTweets retain];
	}
	return self;
}

- (void)loadLatestTweetsForUser:(User *)user withBlock:(TweetBlock)block {
	block(tweets);
}

- (void)dealloc {
	[tweets release];
	[super dealloc];
}


@end
