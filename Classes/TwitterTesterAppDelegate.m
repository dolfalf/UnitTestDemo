//
//  TwitterTesterAppDelegate.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "TwitterTesterAppDelegate.h"
#import "UserListViewController.h"
#import "User.h"

@implementation TwitterTesterAppDelegate

@synthesize window;
@synthesize navigationController;

- (NSArray *)loadUserList {
	NSMutableArray *userArray = [NSMutableArray array];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Users" ofType:@"plist"];
	NSArray *userDict = [NSArray arrayWithContentsOfFile:path];
	for (id dict in userDict) {
		User *user = [[User alloc] init];
		[user setValuesForKeysWithDictionary:dict];
		[userArray addObject:user];
		[user release];
	}
	return userArray;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
	id usersViewController = [[[UserListViewController alloc] initWithUserList:[self loadUserList]] autorelease];
	self.navigationController.viewControllers = [NSArray arrayWithObject:usersViewController];
    [window addSubview:self.navigationController.view];
    [window makeKeyAndVisible];
	
    return YES;
}

- (void)dealloc {
	[window release];
	[super dealloc];
}


@end

