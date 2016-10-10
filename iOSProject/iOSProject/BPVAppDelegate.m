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
#import "BPVLoginViewController.h"

#import "BPVCoreDataManager.h"
#import "BPVUsers.h"

#import "UIViewController+BPVExtensions.h"
#import "UIWindow+BPVExtensions.h"

#import "BPVMacro.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

BPVStringConstantWithValue(kBPVMomName, iOSProject);

@interface BPVAppDelegate ()
@property (nonatomic, strong) BPVCoreDataManager *codeDataManager;

@end

@implementation BPVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    self.codeDataManager = [BPVCoreDataManager sharedManagerWithMomName:kBPVMomName];
    
    BPVLoginViewController *controller = [BPVLoginViewController viewController];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    window.rootViewController = navigationController;
    
    [window makeKeyAndVisible];

    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    
    return handled;
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
    [FBSDKAppEvents activateApp];
    
    BPVPrintCurrentSelector;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    BPVPrintCurrentSelector;
}

@end
