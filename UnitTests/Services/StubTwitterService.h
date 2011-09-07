//
//  StubTwitterService.h
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "TwitterService.h"

@interface StubTwitterService : TwitterService {
	NSArray *tweets;
}

- (id)initWithTweets:(NSArray *)theTweets;

@end
