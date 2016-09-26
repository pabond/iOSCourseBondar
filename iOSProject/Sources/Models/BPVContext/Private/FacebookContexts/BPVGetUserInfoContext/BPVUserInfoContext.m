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

- (NSString *)detailedParametersList {
    BPVReturnOnce(NSString, parametersList, (^{
        return [NSString stringWithFormat:@"%@,%@,%@", self.parametersList, kBPVBirthday, kBPVEmail];
    }));
}

#pragma mark -
#pragma mark Public Implementations

- (void)execute {
    NSDictionary *userInfo = self.userInfo;
    
    if (userInfo) {
        [self fillUserWithDictionary:userInfo];
        return;
    }
    
    NSDictionary *paremters = @{kBPVFields:self.detailedParametersList};
    BPVUser *user = self.user;
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:user.ID
                                                                   parameters:paremters
                                                                   HTTPMethod:kBPVGetMethod];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error || !result) {
            NSLog(@"Faild data load with error: %@", error);
            return;
        }
    
        [self fillUserWithDictionary:result];
        
        user.state = BPVModelDidLoad;
    }];
}

#pragma mark -
#pragma mark Private Implementations

- (void)fillUserWithDictionary:(NSDictionary *)userInfo {
    BPVUser *user = self.user;
    
    user.name = userInfo[kBPVName];
    user.surname = userInfo[kBPVSurname];
    user.email = userInfo[kBPVEmail];
    user.birthday = userInfo[kBPVBirthday];
    user.ID = userInfo[kBPVId];
    
    NSDictionary *picture = userInfo[kBPVPicture][kBPVData];
    user.imageURL = [NSURL URLWithString:picture[kBPVUrl]];
}

@end
