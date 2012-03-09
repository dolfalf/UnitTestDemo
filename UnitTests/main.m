//
//  main.m
//  UnitTests
//
//  Created by Bob McCune on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// Default exception handler
void exceptionHandler(NSException *exception) { 
	NSLog(@"%@\n%@", [exception reason], GHUStackTraceFromException(exception));
}

int main(int argc, char *argv[]) {
	NSSetUncaughtExceptionHandler(&exceptionHandler);
	@autoreleasepool {
	    return UIApplicationMain(argc, argv, nil, NSStringFromClass([GHUnitIOSAppDelegate class]));
	}
}
