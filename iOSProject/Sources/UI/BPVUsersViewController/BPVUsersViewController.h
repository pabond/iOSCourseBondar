//
//  BPVUsersViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/1/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVTableViewController.h"

#import "BPVFilteredModel.h"

@interface BPVUsersViewController : BPVTableViewController <BPVFilteredModelObserver>

- (void)onEditing:(id)sender;
- (void)onAdd:(id)sender;
- (IBAction)onSearchFieldEdit:(id)sender;

@end
