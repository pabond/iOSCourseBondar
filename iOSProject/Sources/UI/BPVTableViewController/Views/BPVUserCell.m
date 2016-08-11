//
//  BPVUserCell.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserCell.h"

#import "BPVUser.h"

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
    self.userImageView.image = user.image;
}

@end
