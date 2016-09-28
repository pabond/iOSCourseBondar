//
//  BPVUserInfoContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserInfoContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "BPVUserViewController.h"
#import "BPVUser.h"

@implementation BPVUserInfoContext

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)paremeters {
    return @{kBPVFields:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",
                         kBPVId,
                         kBPVName,
                         kBPVSurname,
                         kBPVLargePicture,
                         kBPVBirthday,
                         kBPVEmail]};
}

- (NSString *)path {
    BPVUser *user = (BPVUser *)self.model;
    
    return user.ID;
}

#pragma mark -
#pragma mark Public Implementations

- (BOOL)shouldNotifyOfState:(NSUInteger)state {
    return BPVModelDidLoadDetailedInfo == state || BPVModelWillLoad == state;
}

- (void)fillModelWithInfo:(NSDictionary *)info {
    BPVUser *user = (BPVUser *)self.model;
    
    user.name = info[kBPVName];
    user.surname = info[kBPVSurname];
    
    user.ID = info[kBPVId];
    user.email = info[kBPVEmail];
    user.birthday = info[kBPVBirthday];
    
    NSDictionary *picture = info[kBPVPicture][kBPVData];
    user.imageURL = [NSURL URLWithString:picture[kBPVUrl]];
    
    user.state = BPVModelDidLoadDetailedInfo;
}

@end
