//
//  BPVUsersView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/4/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsersView.h"

#import "BPVLoadingView.h"

#import "BPVMacro.h"

BPVStringConstant(kBPVEditButton, @"Edit");
BPVStringConstant(kBPVDoneButton, @"Done");

@implementation BPVUsersView

@dynamic editing;
@dynamic loading;

#pragma mark -
#pragma mark Initialastions and deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
    
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)editing {
    return self.usersTableView.editing;
}

- (void)setEditing:(BOOL)editing {
    self.usersTableView.editing = editing;
    [self.editDoneButton setTitle:(editing ? kBPVDoneButton : kBPVEditButton) forState:UIControlStateNormal];
}

- (void)setLoading:(BOOL)loading {
    self.loadingView.loading = loading;
}

- (BOOL)loading {
    return self.loadingView.loading;
}

@end
