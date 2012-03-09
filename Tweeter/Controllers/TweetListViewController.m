//
//  TweetListViewController.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "TweetListViewController.h"
#import "TwitterService.h"
#import "User.h"
#import "Tweet.h"
#import "NSDate+Additions.h"

#define TEXT_FONT_SIZE 14.0f
#define DATE_FONT_SIZE 12.0f
#define CELL_CONTENT_WIDTH 300.0f
#define CELL_CONTENT_MARGIN 10.0f
#define MIN_ROW_HEIGHT 22.0f
#define MAX_CELL_WIDTH 320.f

@implementation TweetListViewController

@synthesize user = _user;
@synthesize tweets = _tweets;
@synthesize twitterService = _twitterService;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.twitterService = [TwitterService service];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.twitterService loadLatestTweetsForUser:self.user withBlock:^(NSArray *tweets) {
		self.tweets = tweets;
		[self.tableView reloadData];
	}];	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
	
	Tweet *tweet = [self.tweets objectAtIndex:indexPath.row];
	cell.textLabel.text = tweet.text;
	cell.detailTextLabel.text = [tweet.date relativeDateString];
	
	return cell;
}

// Dynamically size row height based on content
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *text = [[self.tweets objectAtIndex:indexPath.row] text];
	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX_CELL_WIDTH);
	UIFont *systemFont = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
	CGSize size = [text sizeWithFont:systemFont constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	CGFloat height = MAX(size.height, MIN_ROW_HEIGHT);
	return height + (CELL_CONTENT_MARGIN * 2);
}



@end

