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

#import "TweetListViewController.h"
#import "NSDate+Additions.h"
#import "TwitterService.h"
#import "Tweet.h"
#import "User.h"

#define TEXT_FONT_SIZE 14.0f
#define DATE_FONT_SIZE 12.0f
#define MIN_ROW_HEIGHT 22.0f
#define MAX_CELL_WIDTH 320.f
#define CELL_CONTENT_WIDTH 300.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface TweetListViewController ()
@property (nonatomic, copy) NSArray *tweets;
@property (nonatomic, strong) TwitterService *twitterService;
@end

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

