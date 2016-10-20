//
//  BPVLoginFacebookContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoginFacebookContext.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "NSManagedObject+BPVExtensions.h"

#import "BPVLoginViewController.h"
#import "BPVUser.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVPermitionPublicProfile, public_profile);

@implementation BPVLoginFacebookContext

#pragma mark -
#pragma mark Public Implementations

- (void)execute {
    [[FBSDKLoginManager new] logInWithReadPermissions:@[kBPVPermitionPublicProfile]
                                   fromViewController:self.controller
                                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                                  BPVUser *user = self.model;
                                                  if (error || !result) {
                                                      user.state = BPVModelFailLoading;
                                                  }
                                                  
                                                  user.userID = result.token.userID;
                                                  [user saveManagedObject];
                                
                                                  user.state = BPVModelDidLoadID;
                                              }];
}

@end
