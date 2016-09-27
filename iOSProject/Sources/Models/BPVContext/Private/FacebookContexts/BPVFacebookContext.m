//
//  BPVFacebookContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/26/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFacebookContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation BPVFacebookContext

#pragma mark -
#pragma mark Public implementations

- (void)execute {
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:self.path
                                                                   parameters:self.paremeters
                                                                   HTTPMethod:kBPVGetMethod];
        
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error || !result) {
            NSLog(@"Faild data load with error: %@", error);
            return;
        }
        
        [self performLoadingWithInfo:result];
    }];
}

- (void)performLoadingWithInfo:(NSDictionary *)info {

}

@end
