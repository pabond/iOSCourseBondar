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
#import "BPVArrayModelsCollection.h"

#import "BPVUser.h"

#import "UIViewController+BPVExtensions.h"
#import "UIWindow+BPVExtensions.h"

@interface BPVAppDelegate ()

- (void)saveData;

@end

@implementation BPVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    window.rootViewController = [BPVTableViewController viewController];
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)saveData {
    BPVTableViewController *viewController = self.window.rootViewController;
    [viewController.users save];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveData];
}

@end
