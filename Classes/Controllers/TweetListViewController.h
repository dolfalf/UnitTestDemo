//
//  TweetListViewController.h
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

@class User;
@class TwitterService;

@interface TweetListViewController : UITableViewController {
	User *_user;
	NSArray *_tweets;
	TwitterService *twitterService;
}

@property (nonatomic, retain) User *user;
@property (nonatomic, copy) NSArray *tweets;
@property (nonatomic, retain) TwitterService *twitterService;

+ (id)controllerWithUser:(User *)user;
- (id)initWithTwitterUser:(User *)user;

@end
