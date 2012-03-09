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

#import "User.h"

@interface UserTest : GHTestCase
@end

@implementation UserTest

#pragma mark -
#pragma mark Test Methods
- (void)testDesignatedInitializer {
	User *user = [[User alloc] initWithUsername:@"stevevai" fullname:@"Steve Vai"];
	GHAssertEqualStrings(user.username, @"stevevai", nil);
	GHAssertEqualStrings(user.fullname, @"Steve Vai", nil);
}

// Ensure description method overridden and in expected format
- (void)testDescription {
	User *user = [[User alloc] initWithUsername:@"satch" fullname:@"Joe Satriani"];
	NSString *description = [user description];

	GHAssertNotNil(description, nil);
	GHAssertTrue([description rangeOfString:@"satch"].location != NSNotFound, nil);
	GHAssertTrue([description rangeOfString:@"Joe Satriani"].location != NSNotFound, nil);
}

- (void)testArchiving {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"user.txt"];
	
	User *userToArchive = [User userWithUsername:@"slowhand" fullname:@"Eric Clapton"];
	[NSKeyedArchiver archiveRootObject:userToArchive toFile:path];
	
	NSData *userData = [NSData dataWithContentsOfFile:path];
	User *unarchivedUser = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
	
	GHAssertEqualStrings(unarchivedUser.username, @"slowhand", nil);
	GHAssertEqualStrings(unarchivedUser.fullname, @"Eric Clapton", nil);
}

@end
