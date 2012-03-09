//
//  UserListViewControllerTest.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.s
//

#import "User.h"
#import "UserListViewController.h"
#import "TweetListViewController.h"
#import <objc/runtime.h>

@interface UserListViewControllerTest : GHTestCase {
	NSMutableArray *users;
	UserListViewController *controller;
}
@end

@implementation UserListViewControllerTest

#pragma mark -
#pragma mark Text Fixture Methods

- (void)setUp {
	users = [[NSMutableArray alloc] init];
	[users addObject:[User userWithUsername:@"aaronhillegass" fullname:@"Aaron Hillegass"]];
	[users addObject:[User userWithUsername:@"danielpunkass" fullname:@"Daniel Jalkut"]];
	
	controller = [[UserListViewController alloc] init];
	controller.users = users;
}

- (void)tearDown {
	users = nil;
	controller = nil;
}


#pragma mark -
#pragma mark Test Methods

- (void)testViewDidLoad {
	GHAssertNotNil(controller.view, nil);
	GHAssertEqualStrings(controller.title, @"Cocoa Developers", nil);
	GHAssertEqualStrings(controller.navigationItem.backBarButtonItem.title, @"Back", nil);
}

- (void)testTableViewNumberOfRowsInSection {
	NSInteger expected = [users count];
	NSInteger result = [controller tableView:nil numberOfRowsInSection:0];
	GHAssertEquals(result, expected, nil);
}

- (void)testTableViewCellForRowAtIndexPath_withQueuedCell {
	id mockTableView = [OCMockObject mockForClass:[UITableView class]];
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	
	[[[mockTableView expect] andReturn:cell] dequeueReusableCellWithIdentifier:@"UserCell"];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0]; 
	
	[controller tableView:mockTableView cellForRowAtIndexPath:indexPath];
	
	GHAssertNotNil(cell.imageView.image, nil);
	GHAssertEqualStrings(cell.textLabel.text, @"Aaron Hillegass", nil);
}

- (void)testTableViewHeightForRowAtIndexPath {
	CGFloat expectedHeight = 52;
	GHAssertEquals([controller tableView:nil heightForRowAtIndexPath:nil], expectedHeight, nil);
}

- (UINavigationController *)mockNavigationController {
	static id mockController = nil;
	if (!mockController) {
		mockController = [OCMockObject mockForClass:[UINavigationController class]];
	}
	return mockController;
}

- (void)testPrepareForSegueSender {
	id tweetListViewController = [[TweetListViewController alloc] init];
	id mockSegue = [OCMockObject mockForClass:[UIStoryboardSegue class]];
	[[[mockSegue expect] andReturn:tweetListViewController] destinationViewController];

	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
	id mockTableView = [OCMockObject niceMockForClass:[UITableView class]];
	[[[mockTableView expect] andReturn:indexPath] indexPathForSelectedRow];
	
	controller.tableView = mockTableView;
	
	[controller prepareForSegue:mockSegue sender:nil];
	
	User *expectedUser = [users objectAtIndex:0];
	GHAssertEqualObjects(expectedUser, [tweetListViewController user], nil);
}


@end
