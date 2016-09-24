//
//  BPVUserInfoContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserInfoContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "BPVUserViewController.h"
#import "BPVUser.h"

@implementation BPVUserInfoContext

- (void)execute {
    NSDictionary *paremters = @{@"fields":@"id,first_name,last_name,picture.type(large), email,birthday"};
    FBSDKGraphRequest *request = nil;
    request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                                parameters:paremters
                                                HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error || !result) {
            NSLog(@"Faild data load with error: %@", error);
            return;
        }
        
        BPVUser *user = self.user;
        
        user.name = result[@"first_name"];
        user.surname = result[@"last_name"];
        user.email = result[@"email"];
        user.birthday = result[@"birthday"];
        
        NSDictionary *picture = result[@"picture"][@"data"];
        user.imageURL = [NSURL URLWithString:picture[@"url"]];
        
        user.state = BPVModelDidLoad;
    }];
}

@end
