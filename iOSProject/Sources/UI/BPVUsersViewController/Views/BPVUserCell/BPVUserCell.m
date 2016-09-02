//
//  BPVUserCell.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserCell.h"

#import "BPVLoadingView.h"

@implementation BPVUserCell

#pragma mark - 
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        _user = user;
        
        [_user addObserver:self];
        [self fillWithModel:user];
    }
}

- (void)setLoading:(BOOL)loading {
    [self.loadingView setVisible:loading animated:YES];
}

#pragma mark -
#pragma mark Public Implementations

- (void)fillWithModel:(BPVUser *)user {
    self.userNameLabel.text = self.user.fullName;
    self.userImageView.image = user.image;
}


#pragma mark -
#pragma mark BPVModelObserver

- (void)modelWillLoad:(id)arrayModel {
    self.loading = YES;
}

- (void)modelDidLoad:(id)arrayModel {
    self.loading = NO;
}

- (void)modelFailLoading:(id)arrayModel {
    [self.user load];
}

@end
