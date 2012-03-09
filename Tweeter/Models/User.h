//
//  User.h
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

@interface User : NSObject <NSCoding> {
@private
	NSString *username;
	NSString *fullname;
}

@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *fullname;

+ (id)userWithUsername:(NSString *)username fullname:(NSString *)fullname;
- (id)initWithUsername:(NSString *)username fullname:(NSString *)fullname;

@end
