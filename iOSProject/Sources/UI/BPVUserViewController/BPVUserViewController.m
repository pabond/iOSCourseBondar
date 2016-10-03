//
//  BPVUserViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserViewController.h"

#import "BPVUserView.h"
#import "BPVUsers.h"
#import "BPVUsersViewController.h"

#import "BPVUserInfoContext.h"

#import "UIViewController+BPVExtensions.h"

#import "BPVMacro.h"

BPVViewControllerBaseViewPropertyWithGetter(BPVUserViewController, userView, BPVUserView)

@implementation BPVUserViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadModel];
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
        
        if ([self isViewLoaded]) {
            [self loadModel];
        }
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onFriends:(id)sender {
    BPVUsersViewController *controller = [BPVUsersViewController viewController];
    controller.user = self.user;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public implementations

- (void)loadModel {
    BPVUserInfoContext *userFillContext  = [BPVUserInfoContext new];
    userFillContext.user = self.user;
    self.context = userFillContext;
}

#pragma mark -
#pragma mark BPVUserObserver

- (void)modelWillLoadDetailedInfo:(id)model {
    self.userView.loading = YES;
}

- (void)modelDidLoadDetailedInfo:(BPVUser *)model {
    self.context = nil;
    self.userView.loading = NO;
    self.title = model.fullName;
    self.userView.user = model;
}

- (void)modelFailLoading:(BPVUser *)model {
    [self loadModel];
    self.userView.loading = NO;
}

@end
