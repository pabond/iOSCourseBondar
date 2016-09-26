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
    NSDictionary *paremters = @{kBPVFields:self.detailedParametersList};
    BPVUser *user = self.user;
    FBSDKGraphRequest *request = nil;
    request = [[FBSDKGraphRequest alloc] initWithGraphPath:user.ID
                                                parameters:paremters
                                                HTTPMethod:kBPVGetMethod];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error || !result) {
            NSLog(@"Faild data load with error: %@", error);
            return;
        }
    
        user.name = result[kBPVName];
        user.surname = result[kBPVSurname];
        user.email = result[kBPVEmail];
        user.birthday = result[kBPVBirthday];
        user.ID = result[kBPVId];
        
        NSDictionary *picture = result[kBPVPicture][kBPVData];
        user.imageURL = [NSURL URLWithString:picture[kBPVUrl]];
        
        user.state = BPVModelDidLoad;
    }];
}

@end
