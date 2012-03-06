//
//  TwitterService.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "TwitterService.h"
#import <ASIHTTPRequest/ASIHTTPRequest.h>
#import <SBJson/SBJson.h>
#import "Tweet.h"

#define BLOCK_KEY @"block"
#define TIMELINE_URL_FORMAT @"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@"

@implementation TwitterService

+ (id)service {
	return [[[self alloc] init] autorelease];
}

- (void)loadLatestTweetsForUser:(User *)user withBlock:(TweetBlock)block {
	NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:TIMELINE_URL_FORMAT, user.username]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:twitterURL];
	request.delegate = self;
	request.didFinishSelector = @selector(latestTweetsRequestSucceeded:);
	request.didFailSelector = @selector(latestTweetsRequestFailed:);
	request.userInfo = [NSMutableDictionary dictionaryWithObject:Block_copy(block) forKey:BLOCK_KEY];
	[request startAsynchronous];
}

- (void)latestTweetsRequestSucceeded:(ASIHTTPRequest *)request {
	NSMutableArray *tweets = [NSMutableArray array];
	for (id dict in [[request responseString] JSONValue]) {
		Tweet *tweet = [[Tweet alloc] init];
		[tweet setValuesForKeysWithDictionary:dict];
		[tweets addObject:tweet];
		[tweet release];
	}
	TweetBlock block = (TweetBlock) [request.userInfo objectForKey:BLOCK_KEY];
	block(tweets);
	Block_release(block);
}

- (void)latestTweetsRequestFailed:(ASIHTTPRequest *)request {
	NSLog(@"Response: %@", [request responseString]);
}


@end
