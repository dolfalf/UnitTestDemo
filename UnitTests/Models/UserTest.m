//
//  UserTest.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "User.h"

@interface UserTest : GHTestCase {}
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
