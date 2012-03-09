//
//  NSDate+Additions.h
//  TwitterTester
//
//  Created by Bob McCune (http://bobmccune.com/) on 10/9/10
//  Sample project created for October 2010 CocoaHeads Presentation on Unit Testing
//
//  Code is released under the DFUMS license.
//

#define MINUTE 60
#define HOUR   (60 * MINUTE)
#define DAY    (24 * HOUR)

@interface NSDate (Additions)

- (NSString *)relativeDateString;
+ (NSDate *)dateFromTwitterDateString:(NSString *)dateString;

@end
