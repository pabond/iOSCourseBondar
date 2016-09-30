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
    return @{kBPVFields:[NSString stringWithFormat:@"%@,%@", kBPVBirthday, kBPVEmail]};
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
    
    if (info) {
        user.email = info[kBPVEmail];
        user.birthday = info[kBPVBirthday];
        
        [user save];
    } else {
        user = [user cachedModel];
    }
    
    NSUInteger state = BPVModelDidLoadDetailedInfo;
    if (self.isCanceled) {
        self.model = self.defaultModel;
        state = BPVModelFailLoading;
    }
    
    user.state = state;
}

@end
