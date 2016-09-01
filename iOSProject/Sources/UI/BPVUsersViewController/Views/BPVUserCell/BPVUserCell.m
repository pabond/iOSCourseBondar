//
//  BPVUserCell.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserCell.h"

#import "BPVUser.h"
#import "BPVLoadingView.h"

@implementation BPVUserCell

#pragma mark - 
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        _user = user;
        
        [self fillWithModel:user];
    }
}

#pragma mark -
#pragma mark Public Implementations

- (void)fillWithModel:(BPVUser *)user {
    self.userNameLabel.text = self.user.fullName;
    self.userImageView.image = [BPVLoadingView loadingViewInSuperview:self];
}

#pragma mark -
#pragma mark BPVModelObserver

- (void)modelImageDidLoad:(BPVUser *)user {
    self.userImageView.image = user.image;
}

- (void)modelImageFailLoading:(id)user {
    //show default?
}

@end
