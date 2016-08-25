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

BPVStringConstant(kBPVEditingButton, @"Edit");
BPVStringConstant(kBPVDoneButton, @"Done");

@implementation BPVUsersView

@dynamic editing;
@dynamic loading;

#pragma mark -
#pragma mark Initialastions and deallocations

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        BPVLoadingView *loadingView = [[BPVLoadingView alloc] initWithFrame:self.bounds];
        self.loadingView = loadingView;
        [self addSubview:loadingView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    BPVLoadingView *view = [NSBundle objectWithClass:[BPVLoadingView class]];
    self.loadingView = view;
    [self addSubview:view];
    [self bringSubviewToFront:view];
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
    BPVLoadingView *loadingView = self.loadingView;
    loadingView.stopLoading = !loading;
    if (loading) {
        [loadingView showLoadingView];
    }
}

- (BOOL)loading {
    return self.loadingView.loading;
}

@end
