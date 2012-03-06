//
//  TwitterServiceTest.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "TwitterService.h"
#import <ASIHTTPRequest/ASIHTTPRequest.h>

@interface TwitterServiceTest : GHTestCase {
	TwitterService *service;
}
@end

@implementation TwitterServiceTest

- (void)setUp {
	service = [[TwitterService alloc] init];
}

- (void)tearDown {
	[service release];
}

#pragma mark -
#pragma mark Test Methods

- (void)testLatestTweetsRequestSucceeded {

	id mockRequest = [OCMockObject mockForClass:[ASIHTTPRequest class]];
	
	TweetBlock tweetBlock = ^(NSArray *tweets){
		GHAssertNotNil(tweets, nil);
		GHAssertTrue([tweets count] == 5, nil);
	};
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"twitter_response" ofType:@"json"];
	NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	[[[mockRequest expect] andReturn:jsonString] responseString];	
	[[[mockRequest expect] andReturn:[NSDictionary dictionaryWithObject:[tweetBlock copy] forKey:@"block"]] userInfo];
	
	[service performSelector:@selector(latestTweetsRequestSucceeded:) withObject:mockRequest];
	
	[mockRequest verify];
}

@end
