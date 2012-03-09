//
//  AppDelegate.m
//  Tweeter
//
//  Created by Bob McCune on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TweeterAppDelegate.h"
#import "UserListViewController.h"
#import "User.h"

@implementation TweeterAppDelegate

@synthesize window = _window;

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

	id navigationController = self.window.rootViewController;
	id userListViewController = [navigationController topViewController];
	[(UserListViewController *)userListViewController setUsers:[self loadUserList]];
	
    return YES;
}
							
@end
