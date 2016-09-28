//
//  BPVFacebookContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/26/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFacebookContext.h"

#import "BPVModel.h"
#import "BPVGCD.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "NSDictionary+BPVExtensions.h"

@interface BPVFacebookContext ()

- (void)loadModel;

@end

@implementation BPVFacebookContext

@dynamic paremeters;
@dynamic path;

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return nil;
}

- (NSDictionary *)paremeters {
    return nil;
}

#pragma mark -
#pragma mark Public implementations

- (BOOL)shouldNotifyOfState:(NSUInteger)state {
    return BPVModelDidLoad == state || BPVModelWillLoad == state;
}

- (NSString *)HTTPMethod {
    return kBPVGetMethod;
}

- (void)execute {
    NSUInteger state = self.model.state;
    @synchronized (self) {
        if ([self shouldNotifyOfState:state]) {
            [self.model notifyOfState:state];
            
            return;
        }
        
        self.model.state = BPVModelWillLoad;

        [self loadModel];
    }
}

- (void)loadModel {
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:self.path
                                                                   parameters:self.paremeters
                                                                   HTTPMethod:[self HTTPMethod]];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error || !result) {
            NSLog(@"Faild data load with error: %@", error);
            
            return;
        }
        
        [self fillModelWithInfo:[result JSONReprezentation]];
    }];
}

- (void)fillModelWithInfo:(NSDictionary *)info {

}

@end
