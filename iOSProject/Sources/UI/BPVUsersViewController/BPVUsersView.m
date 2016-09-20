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

- (BOOL)editing {
    return self.usersTableView.editing;
}

- (void)setEditing:(BOOL)editing {
    self.usersTableView.editing = editing;
}

@end
