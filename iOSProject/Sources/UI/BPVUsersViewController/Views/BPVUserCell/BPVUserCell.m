//
//  BPVUserCell.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserCell.h"

#import "BPVView.h"
#import "BPVImage.h"
#import "BPVGCD.h"

#import "BPVMacro.h"

@implementation BPVUserCell

#pragma mark - 
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {        
        _user = user;
        
        [self fillWithModel:_user];
    }
}

#pragma mark -
#pragma mark Public Implementations

- (void)fillWithModel:(BPVUser *)user {
    self.userNameLabel.text = self.user.fullName;
    
    BPVImage *image = user.image;
    [image addObserver:self];
    [image load];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelWillLoad:(BPVImage *)model {
    self.contentLoadingView.loading = YES;
}

- (void)modelDidLoad:(BPVImage *)model {
    self.userImageView.image = model.image;
    
    self.contentLoadingView.loading = NO;
}

- (void)modelFailLoading:(BPVImage *)model {
    [model performLoading];
}

@end
