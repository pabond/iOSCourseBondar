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

#import "BPVUserViewController.h"
#import "BPVUser.h"

#import "BPVLoginView.h"
#import "BPVLoginFacebookContext.h"

#import "BPVImage.h"

#import "UIViewController+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVLogoImageName, facebook_logo);
BPVStringConstantWithValue(kBPVLogoImageFormat, png);

BPVViewControllerBaseViewPropertyWithGetter(BPVLoginViewController, loginView, BPVLoginView)

@interface BPVLoginViewController ()
@property (nonatomic, strong) BPVLoginFacebookContext   *context;

@end

@implementation BPVLoginViewController

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    FBSDKLoginManagerLoginResult *result = nil;
    BPVLoginFacebookContext *context = [BPVLoginFacebookContext new];
    context.result = result;
    context.controller = self;
    self.context = context;
    
    [context execute];
}

#pragma mark -
#pragma mark publicImplementations

- (void)showUserProfile {
    BPVLoginFacebookContext *context = self.context;
    FBSDKAccessToken *token = context.result.token;
    if (!token || context.isCanceled) {
        return;
    }
    
    BPVUser *user = [BPVUser new];
    user.ID = token.userID;
    
    BPVUserViewController *userController = [BPVUserViewController viewController];
    userController.user = user;
    [self.navigationController pushViewController:userController animated:YES];
}


@end
