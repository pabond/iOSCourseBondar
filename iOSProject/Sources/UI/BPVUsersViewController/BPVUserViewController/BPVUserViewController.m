//
//  BPVUserViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserViewController.h"

#import "BPVUserView.h"
#import "BPVUser.h"

#import "BPVMacro.h"

BPVViewControllerBaseViewPropertyWithGetter(BPVUserViewController, userView, BPVUserView)

@implementation BPVUserViewController

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        _user = user;
        
        self.title = user.fullName;
    }
    
    self.userView.user = user;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userView.user = self.user;
}

@end
