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

#import "BPVFriendsListContext.h"

#import "UIViewController+BPVExtensions.h"

#import "BPVMacro.h"

BPVViewControllerBaseViewPropertyWithGetter(BPVUserViewController, userView, BPVUserView)

@implementation BPVUserViewController

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [_user addObserver:self];
        
        [_user load];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onFriends:(id)sender {
    BPVUsers *friends = [BPVUsers new];
    friends.user = self.user;
    BPVUsersViewController *controller = [BPVUsersViewController viewController];
    controller.model = friends;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelWillLoad:(id)model {
    self.userView.loading = YES;
}

- (void)modelDidLoad:(BPVUser *)model {
    self.userView.loading = NO;
    self.title = model.fullName;
    self.userView.user = model;
}

- (void)modelFailLoading:(id)model {
    self.userView.loading = NO;
}

@end
