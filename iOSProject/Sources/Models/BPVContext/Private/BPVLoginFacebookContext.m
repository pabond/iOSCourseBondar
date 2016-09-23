//
//  BPVLoginFacebookContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoginFacebookContext.h"

#import "BPVUserViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVPermitionPublicProfile, public_profile);

@implementation BPVLoginFacebookContext

- (void)execute {
    [self.loginManager logInWithReadPermissions:@[kBPVPermitionPublicProfile]
                             fromViewController:self.controller
                                        handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                            if (error) {
                                                NSLog(@"Process error");
                                            } else if (result.isCancelled) {
                                                NSLog(@"Cancelled");
                                            } else {
                                                NSLog(@"Logged in");
                                                
                                            }
                                        }];
}

- (void)cancel {
    [self.loginManager logOut];
}

@end
