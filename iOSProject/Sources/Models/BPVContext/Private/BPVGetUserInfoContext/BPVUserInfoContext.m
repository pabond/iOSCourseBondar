//
//  BPVUserInfoContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserInfoContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "BPVUserViewController.h"
#import "BPVUser.h"

#import "UIViewController+BPVExtensions.h"

@implementation BPVUserInfoContext

- (void)execute {
    FBSDKGraphRequest *request = nil;
    request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                parameters:@{@"me": @"id, first_name, last_name, picture"}
                                                HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error || !result) {
            NSLog(@"Faild data load with error: %@", error);
            return;
        }
        
        BPVUser *user = [BPVUser new];
        NSDictionary *userInfo = [result objectForKey:@"data"];
        
        user.name = [userInfo objectForKey:@"first_name"];
        user.surname = [userInfo objectForKey:@"last_name"];
        user.url = [userInfo objectForKey:@"picture"];
        
        BPVUserViewController *userController = [BPVUserViewController viewController];
        userController.user = user;
        
        
        [self.controller.navigationController pushViewController:userController animated:YES];
    }];
}

@end
