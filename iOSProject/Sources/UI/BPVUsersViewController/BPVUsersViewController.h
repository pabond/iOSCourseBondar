//
//  BPVUsersViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/1/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVTableViewController.h"

#import "BPVFilteredModel.h"

@interface BPVUsersViewController : BPVTableViewController <BPVFilteredModelObserver, UISearchBarDelegate>

- (void)onEditing:(id)sender;

@end
