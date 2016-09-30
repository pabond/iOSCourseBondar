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
#import "BPVFriendsListContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "NSDictionary+BPVExtensions.h"

@interface BPVFacebookContext ()
@property (nonatomic, strong) BPVModel  *defaultModel;

- (void)loadModel;

@end

@implementation BPVFacebookContext

@dynamic paremeters;
@dynamic path;

#pragma mark -
#pragma mark Accessors

- (void)setModel:(BPVModel *)model {
    if (_model != model) {
        _model = model;
        
        self.defaultModel = [model copy];
    }
}

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
    if (![NSThread mainThread]) {
        [self performSelectorOnMainThread:@selector(loadModelWithRequest:) withObject:request waitUntilDone:NO];
    } else {
        [self loadModelWithRequest:request];
    }
}

- (void)loadModelWithRequest:(FBSDKGraphRequest *)request {
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if ((error || !result) && !self.model.isCached) {
            NSLog(@"Faild data load with error: %@", error);
            self.model.state = BPVModelFailLoading;
            
            return;
        }
        
        [self fillModelWithInfo:[result JSONRepresentation]];
    }];
}

- (void)fillModelWithInfo:(NSDictionary *)info {

}

@end
