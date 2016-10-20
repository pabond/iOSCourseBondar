//
//  BPVUserInfoContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserInfoContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "NSManagedObject+BPVExtensions.h"

#import "BPVUserViewController.h"
#import "BPVUser.h"

#import "BPVUserInteractionContext.h"

@implementation BPVUserInfoContext

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)paremeters {
    return @{kBPVFields:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",
                         kBPVBirthday,
                         kBPVEmail,
                         kBPVId,
                         kBPVName,
                         kBPVSurname,
                         kBPVLargePicture]};
}

- (NSString *)path {
    BPVUser *model = self.model;
    
    return model.userID;
}

#pragma mark -
#pragma mark Public Implementations

- (BOOL)shouldNotifyOfState:(NSUInteger)state {
    return BPVModelDidLoadDetailedInfo == state || BPVModelWillLoad == state;
}

- (void)fillModelWithInfo:(NSDictionary *)info {
    BPVUser *user = self.model;
    
    [BPVUserInteractionContext fillUser:user withUserInfo:info];
    [user saveManagedObject];

    user.state = BPVModelDidLoadDetailedInfo;
}

- (NSUInteger)willLoadState {
    return BPVModelWillLoadDetailedInfo;
}

- (NSUInteger)didLoadState {
    return BPVModelDidLoadDetailedInfo;
}

- (NSUInteger)failLoadingState {
    return BPVModelFailLoadingDetailedInfo;
}

@end
