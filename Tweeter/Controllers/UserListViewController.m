//
//  UserListViewController.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "UserListViewController.h"
#import "TweetListViewController.h"
#import "User.h"

#define ROW_HEIGHT 52

@implementation UserListViewController

@synthesize users = _users;

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Cocoa Developers";

	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
}


#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
	User *user = [self.users objectAtIndex:indexPath.row];
	cell.imageView.image = [UIImage imageNamed:user.username];
	cell.textLabel.text = user.fullname;

    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return ROW_HEIGHT;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	id tweetListViewController = [segue destinationViewController];
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	User *user = [self.users objectAtIndex:indexPath.row];
	[tweetListViewController setUser:user];
}



@end

