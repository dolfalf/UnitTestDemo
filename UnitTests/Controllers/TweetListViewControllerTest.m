//
//  TweetListViewController.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "TweetListViewController.h"
#import "TwitterService.h"
#import "User.h"
#import "Tweet.h"
#import <OCMock/OCMock.h>
#import "StubTwitterService.h"
#import "NSDate+Additions.h"

@interface TweetListViewControllerTest : GHTestCase {
	User *user;
	TweetListViewController *controller;
	Tweet *testTweet;
}
@end

@implementation TweetListViewControllerTest

- (void)setUp {
	user = [[User alloc] initWithUsername:@"vai" fullname:@"Steve Vai"];
	controller = [[TweetListViewController alloc] init];
	controller.user = user;
	GHAssertNotNil(controller.view, nil); // touch view to call viewDidLoad
	
	NSTimeInterval interval = (60 * 60 * 24 * 365 * 9); // 2009-12-30
	NSDate *expectedDate = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
	testTweet = [[Tweet alloc] initWithText:@"Test" date:expectedDate];
	controller.tweets = [NSArray arrayWithObjects:testTweet, nil];	
}

- (void)tearDown {
	user = nil;
	controller = nil;
	testTweet = nil;
}

- (BOOL)shouldRunOnMainThread {
	return YES;
}

#pragma mark -
#pragma mark Tests

#pragma mark -
#pragma mark EXAMPLE: Simple OCMock usage, but the test is a bit superficial

- (void)testViewWillAppear_withMockService {
	
	id mockService = [OCMockObject mockForClass:[TwitterService class]];
	controller.twitterService = mockService;
	
	[[mockService expect] loadLatestTweetsForUser:user  withBlock:[OCMArg any]];
	
	// invoke method under test	
	[controller viewWillAppear:YES];
	
	[mockService verify];
}

#pragma mark -
#pragma mark EXAMPLE: Using a "Stub" implementation of TwitterService

- (void)testViewWillAppear_withStubService {
	NSArray *tweets = [NSArray array];
	id stubService = [[StubTwitterService alloc] initWithTweets:tweets];
	controller.twitterService = stubService;
	
	// invoke method under test
	[controller viewWillAppear:YES];
	
	GHAssertNotNil(controller.view, nil); // touch view to call viewDidLoad
	GHAssertEquals(controller.tweets, tweets, nil);
}

#pragma mark -
#pragma mark EXAMPLE: Mocking the block argument

- (void)testViewWillAppear_withInvocationBlock {
	
	NSArray *expectedTweets = [NSArray array];
	
	// partially mock UITableView, only interested in reloadData call
	id mockTableView = [OCMockObject partialMockForObject:controller.tableView];
	id mockService = [OCMockObject mockForClass:[TwitterService class]];
	
	controller.twitterService = mockService;
	
	void (^invocationBlock) (NSInvocation *) = ^(NSInvocation *invocation) {
		__unsafe_unretained TweetBlock block;
		[invocation getArgument:&block atIndex:3];
		block(expectedTweets);
	};
	
	// set up expectations
	[[[mockService expect] andDo:invocationBlock] loadLatestTweetsForUser:user withBlock:[OCMArg any]];
	[[mockTableView expect] reloadData];
	
	// invoke method under test
	[controller viewWillAppear:YES];
	
	GHAssertTrue(controller.tweets == expectedTweets, nil);
	[mockTableView verify];
}

#pragma mark -
#pragma mark Test tableView:cellForRowAtIndexPath

- (UITableViewCell *)invokeCodeForCell:(UITableViewCell *)expectedCell {
	id mockTableView = [OCMockObject mockForClass:[UITableView class]];
	
	[[[mockTableView expect] andReturn:expectedCell] dequeueReusableCellWithIdentifier:@"TweetCell"];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0]; 
	
	return [controller tableView:mockTableView cellForRowAtIndexPath:indexPath];
}

- (void)invokeAssertsForResultCell:(UITableViewCell *)resultCell {
	GHAssertEqualStrings(resultCell.textLabel.text, testTweet.text, nil);
	GHAssertEqualStrings(resultCell.detailTextLabel.text, [testTweet.date relativeDateString], nil);	
}

- (void)testTableViewCellForRowAtIndexPath_withQueuedCell {
	
	UITableViewCell *expectedCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
	UITableViewCell *resultCell = [self invokeCodeForCell:expectedCell];
	
	GHAssertEquals(resultCell, expectedCell, nil);
	[self invokeAssertsForResultCell:resultCell];
}

#pragma mark -
#pragma mark Tests for tableView:heightForRowAtIndexPath: method

- (void)assertTableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath expected:(CGFloat)expected {
	CGFloat result = [controller tableView:nil heightForRowAtIndexPath:indexPath];
	GHAssertEquals(result, expected, nil);
}

- (void)testTableViewHeightForRowAtIndexPath {
	Tweet *t1 = [Tweet tweetWithText:@"A big long block of text that should wrap to at least a couple of lines." date:[NSDate date]];
	Tweet *t2 = [Tweet tweetWithText:@"Should be a single line tweet." date:[NSDate date]];
	controller.tweets = [NSArray arrayWithObjects:t1, t2, nil];
	
	[self assertTableViewHeightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] expected:56.0f];
	[self assertTableViewHeightForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] expected:42.0f];
}

@end

