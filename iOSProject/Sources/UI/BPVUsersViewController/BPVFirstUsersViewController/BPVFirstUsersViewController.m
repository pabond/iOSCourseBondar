//
//  BPVFirstUsersViewController.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/28/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFirstUsersViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVOnLogout, Logout);

@implementation BPVFirstUsersViewController

#pragma mark -
#pragma mark ViewLifecycle

- (void)viewDidLoad {
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:kBPVOnLogout
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(onLogout)];
    
    [self.navigationItem setLeftBarButtonItem:logoutButton animated:YES];
}

#pragma mark -
#pragma mark Public Implementatoins

- (NSString *)nibName {
    return NSStringFromClass([BPVUsersViewController class]);
}

#pragma mark -
#pragma mark Interface Handling

- (void)onLogout {
    [[FBSDKLoginManager new] logOut];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
