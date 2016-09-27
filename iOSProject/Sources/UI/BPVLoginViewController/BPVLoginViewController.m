//
//  BPVLoginViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLoginViewController.h"

#import "BPVUsersViewController.h"
#import "BPVUsers.h"

#import "BPVLoginView.h"
#import "BPVLoginFacebookContext.h"

#import "BPVGCD.h"

#import "BPVImage.h"

#import "UIViewController+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVLogoImageName, facebook_logo);
BPVStringConstantWithValue(kBPVLogoImageFormat, png);

BPVViewControllerBaseViewPropertyWithGetter(BPVLoginViewController, loginView, BPVLoginView)

@interface BPVLoginViewController ()
@property (nonatomic, strong) BPVUser                   *user;

@end

@implementation BPVLoginViewController

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
        
        [self loadModel];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onLogin:(id)sender {
    self.user = [BPVUser new];
}

#pragma mark -
#pragma mark Public implementations 

- (void)loadModel {
    BPVLoginFacebookContext *context = [BPVLoginFacebookContext new];
    context.user = self.user;
    context.controller = self;
    self.context = context;
    
    [context execute];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelDidLoadID:(BPVUser *)model {
    BPVUsersViewController *usersController = [BPVUsersViewController viewController];
    usersController.user = model;
    usersController.model = [BPVUsers new];
    
    [self.navigationController pushViewController:usersController animated:YES];
}

@end
