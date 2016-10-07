//
//  BPVUsersViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/1/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVTableViewController.h"
#import "BPVUser.h"

@interface BPVUsersViewController : BPVTableViewController
@property (nonatomic, strong) BPVUser   *user;

- (void)onEditing:(id)sender;

@end
