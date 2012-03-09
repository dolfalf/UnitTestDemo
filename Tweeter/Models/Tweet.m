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

#import "Tweet.h"
#import "NSDate+Additions.h"

@implementation Tweet

@synthesize text = _text;
@synthesize date = _date;

+ (id)tweetWithText:(NSString *)text date:(NSDate *)date {
	return [[self alloc] initWithText:text date:date];
}

- (id)initWithText:(NSString *)text date:(NSDate *)date {
	if (self = [super init]) {
		self.text = text;
		self.date = date;
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
