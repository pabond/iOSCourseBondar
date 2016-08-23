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
#import "BPVArrayModel.h"

#import "BPVUser.h"
#import "BPVUsers.h"

#import "UIViewController+BPVExtensions.h"
#import "UIWindow+BPVExtensions.h"

@interface BPVAppDelegate ()
@property (nonatomic, strong) BPVUsers *users;

@end

@implementation BPVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    BPVTableViewController *controller = [BPVTableViewController viewController];
    
    BPVUsers *users = [[BPVUsers alloc] init];
    [users addObserver:controller];
    [controller addModel:users];
    self.users = users;
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
    [self.users save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
    [self.users save];
}

@end
