//
//  BPVUsersView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/4/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsersView.h"

#import "BPVUsersLoadingView.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVEditingButton, Edit);
BPVStringConstantWithValue(kBPVDoneButton, Done);

@implementation BPVUsersView

@dynamic editing;


- (BOOL)editing {
    return self.usersTableView.editing;
}

- (void)setEditing:(BOOL)editing {
    self.usersTableView.editing = editing;
    
    [self.editingButton setTitle:(editing ? kBPVDoneButton : kBPVEditingButton)
                        forState:UIControlStateNormal];
}

@end
