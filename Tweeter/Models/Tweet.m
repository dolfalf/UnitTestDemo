//
//  Tweet.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.s
//

#import "Tweet.h"
#import "NSDate+Additions.h"

@implementation Tweet

@synthesize text, date;

+ (id)tweetWithText:(NSString *)text date:(NSDate *)date {
	return [[self alloc] initWithText:text date:date];
}

- (id)initWithText:(NSString *)aText date:(NSDate *)aDate {
	if (self = [super init]) {
		self.text = aText;
		self.date = aDate;
	}
	return self;
}


- (void)setValue:(id)value forKey:(NSString *)key {
	if ([key isEqualToString:@"created_at"]) {
		self.date = [NSDate dateFromTwitterDateString:value];
	}
	if ([key isEqualToString:@"text"]) {
		self.text = value;
	}
}


@end
