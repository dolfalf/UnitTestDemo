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
