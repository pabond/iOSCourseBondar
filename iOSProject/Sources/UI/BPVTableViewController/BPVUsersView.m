//
//  BPVUsersView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/4/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsersView.h"

#import "BPVLoadingView.h"
#import "NSBundle+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstant(kBPVEditingButton, Edit);
BPVStringConstant(kBPVDoneButton, Done);

@implementation BPVUsersView

@dynamic editing;
@dynamic loading;

#pragma mark -
#pragma mark Initialastions and deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGRect bounds = self.bounds;
    
    BPVLoadingView *loadingView = [NSBundle objectWithClass:[BPVLoadingView class]];
    loadingView.frame = bounds;
    self.loadingView = loadingView;
    [self addSubview:loadingView];
    [self bringSubviewToFront:loadingView];
}

#pragma mark -
#pragma mark Accessors

- (BOOL)editing {
    return self.usersTableView.editing;
}

- (void)setEditing:(BOOL)editing {
    self.usersTableView.editing = editing;
    [self.editingButton setTitle:(editing ? kBPVDoneButton : kBPVEditingButton) forState:UIControlStateNormal];
}

- (void)setLoading:(BOOL)loading {
    if (self.loading != loading) {
        BPVLoadingView *loadingView = self.loadingView;
        if (loading) {
            [loadingView showLoadingView];
        } else {
            [loadingView hideLoadingView];
        }
    }
}

- (BOOL)loading {
    return self.loadingView.visible;
}

@end
