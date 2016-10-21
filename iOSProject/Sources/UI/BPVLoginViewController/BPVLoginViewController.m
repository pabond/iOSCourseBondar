//
//  BPVLoginViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoginViewController.h"

#import "BPVCurrentUserFriendsViewController.h"
#import "BPVCDUsers.h"

#import "BPVLoginView.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "NSManagedObject+BPVExtensions.h"

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
        BPVUser *user = [BPVUser objectWithID:token.userID];
        self.user = user;
        user.state = BPVModelDidLoadID;
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        [_user removeObservationWith:self];
        
        _user = user;
        [_user addObservationWith:self];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    self.user = [BPVUser objectWithID:nil];
    
    [self loadModel];
}

#pragma mark -
#pragma mark Public implementations 

- (void)loadModel {
    BPVLoginFacebookContext *context = [BPVLoginFacebookContext new];
    context.model = self.user;
    context.controller = self;
    self.context = context;
}

#pragma mark -
#pragma mark BPVUserObserver

- (void)modelDidLoadID:(BPVUser *)model {
    BPVPerformAsyncBlockOnMainQueue(^{
        BPVUsersViewController *usersController = [BPVCurrentUserFriendsViewController viewController];
        usersController.user = model;
        
        [self.navigationController pushViewController:usersController animated:YES];
    });
}

@end
