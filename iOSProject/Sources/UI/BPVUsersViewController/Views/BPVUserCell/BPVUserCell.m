//
//  BPVUserCell.m
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserCell.h"

#import "BPVView.h"
#import "BPVImageView.h"
#import "BPVGCD.h"

#import "BPVMacro.h"

@implementation BPVUserCell

#pragma mark -
#pragma mark Initializations and deallocations

- (void)dealloc {
    self.user = nil;
}

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
    self.userImageView.image = user.image;
}

@end
