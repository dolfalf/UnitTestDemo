//
//  UserListViewController.h
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

@interface UserListViewController : UITableViewController {
@private
	NSArray *users;
}

@property (nonatomic, retain) NSArray *users;

- (id)initWithUserList:(NSArray *)usersList;

@end
