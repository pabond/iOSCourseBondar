//
//  BPVUsersView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/4/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsersView.h"

@implementation BPVUsersView

@dynamic editing;

#pragma mark -
#pragma mark Accessors

- (BOOL)editing {
    return self.usersTableView.editing;
}

- (void)setEditing:(BOOL)editing {
    self.usersTableView.editing = editing;
    
    self.editButton.hidden = editing;
    self.doneButton.hidden = !editing;
}

@end
