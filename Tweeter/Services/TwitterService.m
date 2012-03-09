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
#import "Tweet.h"
#import <ASIHTTPRequest/ASIHTTPRequest.h>

#define BLOCK_KEY @"block"
#define TIMELINE_URL_FORMAT @"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@"

@implementation TwitterService

+ (id)service {
	return [[self alloc] init];
}

- (void)loadLatestTweetsForUser:(User *)user withBlock:(TweetBlock)block {

	NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:TIMELINE_URL_FORMAT, user.username]];
	__unsafe_unretained ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:twitterURL];
	[request setCompletionBlock:^{
		NSMutableArray *tweets = [NSMutableArray array];
		NSError *error;
		id data = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:&error];
		if (![data isKindOfClass:[NSArray class]]) {
			// Twitter returned an error.  Too many requests.
			block(nil);
		} else {
			for (id dict in data) {
				Tweet *tweet = [[Tweet alloc] init];
				[tweet setValuesForKeysWithDictionary:dict];
				[tweets addObject:tweet];
			}
			block(tweets);
		}
	}];
	[request setFailedBlock:^{
		NSLog(@"Response: %@", [request responseString]);
	}];
	[request startAsynchronous];
}

@end
