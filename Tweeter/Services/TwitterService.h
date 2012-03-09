//
//  TwitterService.h
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef void (^TweetBlock) (NSArray *);

@interface TwitterService : NSObject {

}

+ (id)service;
- (void)loadLatestTweetsForUser:(User *)user withBlock:(TweetBlock)block;

@end
