//
//  User.m
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#import "User.h"

#define USERNAME_KEY @"username"
#define FULLNAME_KEY @"fullname"

@interface User ()
// redefine as read/write
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *fullname;
@end


@implementation User

@synthesize username;
@synthesize fullname;

+ (id)userWithUsername:(NSString *)username fullname:(NSString *)fullname {
	return [[self alloc] initWithUsername:username fullname:fullname];
}

- (id)initWithUsername:(NSString *)aUsername fullname:(NSString *)aFullname {
	if (self = [super init]) {
		self.username = aUsername;
		self.fullname = aFullname;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.username = [decoder decodeObjectForKey:USERNAME_KEY];
        self.fullname = [decoder decodeObjectForKey:FULLNAME_KEY];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.username forKey:USERNAME_KEY];
    [encoder encodeObject:self.fullname forKey:FULLNAME_KEY];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"username = '%@', fullname = '%@'", self.username, self.fullname];
}


@end
