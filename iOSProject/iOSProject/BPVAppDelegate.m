//
//  BPVAppDelegate.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAppDelegate.h"

#import "BPVSquareViewController.h"
#import "BPVUsersViewController.h"
#import "BPVArrayModel.h"

#import "BPVUsers.h"

#import "UIViewController+BPVExtensions.h"
#import "UIWindow+BPVExtensions.h"

#import "BPVMacro.h"

@implementation BPVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    BPVTableViewController *controller = [BPVUsersViewController viewController];
    controller.model = [BPVUsers new];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    window.rootViewController = navigationController;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    BPVPrintCurrentSelector;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    BPVPrintCurrentSelector;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    BPVPrintCurrentSelector;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    BPVPrintCurrentSelector;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    BPVPrintCurrentSelector;
}

@end
