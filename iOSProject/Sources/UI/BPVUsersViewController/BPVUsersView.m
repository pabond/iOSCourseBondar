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
@dynamic loading;

#pragma mark -
#pragma mark Initialastions and deallocations

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.loadingView) {
        self.loadingView = [BPVUsersLoadingView loadingViewInSuperview:self];
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setLoadingView:(BPVUsersLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        
        _loadingView = loadingView;
        
        if (loadingView) {
            [self addSubview:loadingView];
        }
    }
}

- (BOOL)editing {
    return self.usersTableView.editing;
}

- (void)setEditing:(BOOL)editing {
    self.usersTableView.editing = editing;
    
    [self.editingButton setTitle:(editing ? kBPVDoneButton : kBPVEditingButton)
                        forState:UIControlStateNormal];
}

- (void)setLoading:(BOOL)loading {
    [self.loadingView setVisible:loading animated:YES];
}

- (BOOL)loading {
    return self.loadingView.visible;
}

@end
