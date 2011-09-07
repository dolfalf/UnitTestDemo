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

@synthesize users;

#pragma mark -

- (id)initWithUserList:(NSArray *)userList {
	if (self = [super initWithNibName:@"UserListView" bundle:nil]) {
		self.users = userList;
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	return [self initWithUserList:[NSArray array]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Cocoa Developers";

	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
}


#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"userCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	User *user = [self.users objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:[TweetListViewController controllerWithUser:user] animated:YES];
}

#pragma mark -

- (void)dealloc {
	self.users = nil;
    [super dealloc];
}

@end

