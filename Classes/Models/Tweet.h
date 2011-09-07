//
//  Tweet.h
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

@interface Tweet : NSObject {
	NSString *text;
	NSDate *date;
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) NSDate *date;

+ (id)tweetWithText:(NSString *)test date:(NSDate *)date;
- (id)initWithText:(NSString *)text date:(NSDate *)date;

@end
