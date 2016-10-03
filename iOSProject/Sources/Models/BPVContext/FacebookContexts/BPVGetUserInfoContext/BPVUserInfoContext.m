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
    return self.user.ID;
}

#pragma mark -
#pragma mark Public Implementations

- (BOOL)shouldNotifyOfState:(NSUInteger)state {
    return BPVModelDidLoadDetailedInfo == state || BPVModelWillLoad == state;
}

- (void)fillModelWithInfo:(NSDictionary *)info {
    BPVUser *user = self.user;
    
    [self fillUser:user withUserInfo:info];
        
    [self saveObject:user];
    
    NSUInteger state = BPVModelDidLoadDetailedInfo;
    if (self.isCanceled) {
        user = self.defaultModel;
        state = BPVModelFailLoading;
    }
    
    user.state = state;
}

- (NSUInteger)willLoadState {
    return BPVModelWillLoadDetailedInfo;
}

@end
