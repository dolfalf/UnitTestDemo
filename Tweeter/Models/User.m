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

#define USERNAME_KEY @"username"
#define FULLNAME_KEY @"fullname"

@interface User ()
// redefine as read/write
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *fullname;
@end


@implementation User

@synthesize username = _username;
@synthesize fullname = _fullname;

+ (id)userWithUsername:(NSString *)username fullname:(NSString *)fullname {
	return [[self alloc] initWithUsername:username fullname:fullname];
}

- (id)initWithUsername:(NSString *)username fullname:(NSString *)fullname {
	if (self = [super init]) {
		self.username = username;
		self.fullname = fullname;
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
