//
//  BPVAppDelegate.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAppDelegate.h"

#import "BPVSquareViewController.h"
#import "BPVTableViewController.h"
#import "BPVUsers.h"

#import "BPVUser.h"

#import "UIViewController+BPVExtensions.h"
#import "UIWindow+BPVExtensions.h"

@interface BPVAppDelegate ()
@property (nonatomic, readonly) BPVUsers *users;

@end

@implementation BPVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    window.rootViewController = [BPVTableViewController viewController];
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.users save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.users load];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.users save];
}

@end
