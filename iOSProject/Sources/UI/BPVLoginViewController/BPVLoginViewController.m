//
//  BPVLoginViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoginViewController.h"

#import "BPVFirstUsersViewController.h"
#import "BPVUsers.h"

#import "BPVLoginView.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "BPVGCD.h"
#import "BPVImage.h"
#import "BPVLoginFacebookContext.h"

#import "UIViewController+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVLogoImageName, facebook_logo);
BPVStringConstantWithValue(kBPVLogoImageFormat, png);

BPVViewControllerBaseViewPropertyWithGetter(BPVLoginViewController, loginView, BPVLoginView)

@interface BPVLoginViewController ()
@property (nonatomic, strong) BPVUser   *user;

@end

@implementation BPVLoginViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    if (token) {
        BPVUser *user = [BPVUser new];
        self.user = user;
        user.ID = token.userID;
        user.state = BPVModelDidLoadID;
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    self.user = [BPVUser new];
    
    [self loadModel];
}

#pragma mark -
#pragma mark Public implementations 

- (void)loadModel {
    BPVLoginFacebookContext *context = [BPVLoginFacebookContext new];
    context.model = self.user;
    context.controller = self;
    self.context = context;
    
    [context execute];
}

#pragma mark -
#pragma mark BPVUserObserver

- (void)modelDidLoadID:(BPVUser *)model {
    BPVUsersViewController *usersController = [BPVFirstUsersViewController viewController];
    usersController.user = model;
    
    [self.navigationController pushViewController:usersController animated:YES];
}

@end
