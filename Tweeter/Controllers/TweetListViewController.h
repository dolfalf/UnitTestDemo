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

@interface TweetListViewController : UITableViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSArray *tweets;
@property (nonatomic, strong) TwitterService *twitterService;

@end
