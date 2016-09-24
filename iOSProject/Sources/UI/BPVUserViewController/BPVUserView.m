//
//  BPVUserView.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserView.h"
#import "BPVUser.h"
#import "BPVImageView.h"

@implementation BPVUserView

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        _user = user;
        
        [self fillWithUser:user];
    }
}

- (void)fillWithUser:(BPVUser *)user {
    self.nameContainer.text = user.name;
    self.surnameContainer.text = user.surname;
    self.imageView.image = user.image;
    self.birthdayContainer.text = user.birthday;
    self.emailContainer.text = user.email;
}

@end
