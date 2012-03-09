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

#import "TwitterService.h"
#import "Tweet.h"
#import <ASIHTTPRequest/ASIHTTPRequest.h>

#define BLOCK_KEY @"block"
#define TIMELINE_URL_FORMAT @"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@"

@implementation TwitterService

+ (id)service {
	return [[self alloc] init];
}

// TODO - Lose the ASI dependency
- (void)loadLatestTweetsForUser:(User *)user withBlock:(TweetBlock)block {

	NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:TIMELINE_URL_FORMAT, user.username]];
	__unsafe_unretained ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:twitterURL];
	[request setCompletionBlock:^{
		NSMutableArray *tweets = [NSMutableArray array];
		NSError *error;
		id data = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:&error];
		if (![data isKindOfClass:[NSArray class]]) {
			// Twitter returned an error.  Too many requests.
			block(nil);
		} else {
			for (id dict in data) {
				Tweet *tweet = [[Tweet alloc] init];
				[tweet setValuesForKeysWithDictionary:dict];
				[tweets addObject:tweet];
			}
			block(tweets);
		}
	}];
	[request setFailedBlock:^{
		NSLog(@"Response: %@", [request responseString]);
	}];
	[request startAsynchronous];
}

@end
