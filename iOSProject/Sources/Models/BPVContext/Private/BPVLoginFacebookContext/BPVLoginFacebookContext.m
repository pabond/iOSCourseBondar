//
//  BPVLoginFacebookContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoginFacebookContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "BPVLoginViewController.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVPermitionPublicProfile, public_profile);

@implementation BPVLoginFacebookContext

- (void)execute {
    [[FBSDKLoginManager new] logInWithReadPermissions:@[kBPVPermitionPublicProfile]
                             fromViewController:self.controller
                                        handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                            self.result = result;
                                            [self.controller showUserProfile];
                                        }];
}

@end
