//
//  BPVLoginViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoginViewController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "BPVLoginView.h"
#import "BPVLoginFacebookContext.h"

#import "BPVImage.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVLogoImageName, facebook_logo);
BPVStringConstantWithValue(kBPVLogoImageFormat, png);

BPVViewControllerBaseViewPropertyWithGetter(BPVLoginViewController, loginView, BPVLoginView)

@implementation BPVLoginViewController

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    BPVLoginFacebookContext *context = [BPVLoginFacebookContext new];
    context.loginManager = [FBSDKLoginManager new];
    context.controller = self;
    
    [context execute];
}

@end
