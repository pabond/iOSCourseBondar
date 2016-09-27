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

@interface BPVUserInfoContext ()

- (void)fillUserWithDictionary:(NSDictionary *)result;

@end

@implementation BPVUserInfoContext

@dynamic detailedParametersList;

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)paremeters {
    return @{kBPVFields:self.detailedParametersList};
}

- (NSString *)detailedParametersList {
    return [NSString stringWithFormat:@"%@,%@,%@", self.parametersList, kBPVBirthday, kBPVEmail];
}

- (NSString *)path {
    return self.user.ID;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performLoadingWithInfo:(NSDictionary *)info {
    NSDictionary *userInfo = self.userInfo;
    
    NSDictionary *result = userInfo ? userInfo : info;
    
    [self fillUserWithDictionary:result];
}

#pragma mark -
#pragma mark Private Implementations

- (void)fillUserWithDictionary:(NSDictionary *)userInfo {
    BPVUser *user = self.user;
    
    user.name = userInfo[kBPVName];
    user.surname = userInfo[kBPVSurname];
    user.ID = userInfo[kBPVId];
    NSDictionary *picture = userInfo[kBPVPicture][kBPVData];
    user.imageURL = [NSURL URLWithString:picture[kBPVUrl]];
    
    NSUInteger state = BPVModelDidLoad;
    
    if (!userInfo) {
        user.email = userInfo[kBPVEmail];
        user.birthday = userInfo[kBPVBirthday];
        
        state = BPVModelDidLoadDetailedInfo;
    }
    
    user.state = state;
}

@end
