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
	
	controller = [[UserListViewController alloc] initWithUserList:users];
}

- (void)tearDown {
	[users release];
	[controller release];
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
	
	[[[mockTableView expect] andReturn:cell] dequeueReusableCellWithIdentifier:@"userCell"];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0]; 
	
	[controller tableView:mockTableView cellForRowAtIndexPath:indexPath];
	
	GHAssertNotNil(cell.imageView.image, nil);
	GHAssertEqualStrings(cell.textLabel.text, @"Aaron Hillegass", nil);
}

- (void)testTableViewCellForRowAtIndexPath_withNilCell {
	id mockTableView = [OCMockObject mockForClass:[UITableView class]];
	
	[[[mockTableView expect] andReturn:nil] dequeueReusableCellWithIdentifier:@"userCell"];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0]; 
	
	UITableViewCell *cell = [controller tableView:mockTableView cellForRowAtIndexPath:indexPath];
	
	GHAssertNotNil(cell.imageView.image, nil);
	GHAssertEqualStrings(cell.textLabel.text, @"Daniel Jalkut", nil);
}

- (void)testTableViewHeightForRowAtIndexPath {
	CGFloat expectedHeight = 52;
	GHAssertEquals([controller tableView:nil heightForRowAtIndexPath:nil], expectedHeight, nil);
}

- (UINavigationController *)mockNavigationController {
	static id mockController = nil;
	if (!mockController) {
		mockController = [[OCMockObject mockForClass:[UINavigationController class]] retain];
	}
	return mockController;
}

#pragma mark -
#pragma mark Example of using method swizzling as a means to mock the "unmockable".

- (void)testTableViewDidSelectRowAtIndexPath {
	id mockNavController = [self mockNavigationController];
	
	Method oldMethod = class_getInstanceMethod([controller class], @selector(navigationController));
	Method newMethod = class_getInstanceMethod([self class], @selector(mockNavigationController));
	method_exchangeImplementations(oldMethod, newMethod);
	
	[[mockNavController expect] pushViewController:[OCMArg isNotNil] animated:YES];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[controller tableView:nil didSelectRowAtIndexPath:indexPath];
	
	method_exchangeImplementations(newMethod, oldMethod);
	
	[mockNavController verify];
}


@end
