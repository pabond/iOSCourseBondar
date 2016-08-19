//
//  BPVUsersView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/4/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsersView.h"

@implementation BPVUsersView

#pragma mark -
#pragma mark Public implemntations

- (void)editingMode {
    BOOL editing = self.usersTableView.editing;
    
    self.editButton.hidden = !editing;
    self.doneButton.hidden = editing;
    
    self.usersTableView.editing = !editing;
}

@end
