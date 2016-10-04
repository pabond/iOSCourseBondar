//
//  BPVCurrentUserFriendsViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/28/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCurrentUserFriendsViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVOnLogout, Logout);

@interface  BPVCurrentUserFriendsViewController ()

- (void)onLogout:(id)sender;

@end

@implementation BPVCurrentUserFriendsViewController

#pragma mark -
#pragma mark ViewLifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:kBPVOnLogout
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(onLogout:)];
    
    [self.navigationItem setLeftBarButtonItem:logoutButton animated:YES];
}

#pragma mark -
#pragma mark Public Implementatoins

- (NSString *)nibName {
    return NSStringFromClass([BPVUsersViewController class]);
}

#pragma mark -
#pragma mark Interface Handling

- (void)onLogout:(id)sender {
    [[FBSDKLoginManager new] logOut];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
