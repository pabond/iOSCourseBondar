//
//  BPVFacebookContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/26/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFacebookContext.h"

#import "BPVUser.h"
#import "BPVGCD.h"
#import "BPVFriendsListContext.h"

#import "BPVUserInteractionContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "NSFileManager+BPVExtensions.h"
#import "NSDictionary+BPVExtensions.h"
#import "NSKeyedUnarchiver+BPVExtensions.h"

BPVStringConstantWithValue(kBPVPlist, plist);
BPVStringConstantWithValue(kBPVModelsFolder, BPVModels);

@interface BPVFacebookContext ()

- (void)loadModel;

@end

@implementation BPVFacebookContext

@dynamic paremeters;
@dynamic path;
@dynamic applicationModelsPath;
@dynamic filePath;
@dynamic fileName;

#pragma mark -
#pragma mark Accessors

- (NSString *)applicationModelsPath {
    return  [NSFileManager applicationDataPathWithFolderName:kBPVModelsFolder];
}

- (NSString *)filePath {
    return [self.applicationModelsPath stringByAppendingPathComponent:[self fileName]];
}

- (NSString *)fileName {
    BPVUser *model = self.model;
    
    return [NSString stringWithFormat:@"%@.%@", model.userID, kBPVPlist];
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
    return [self didLoadState] == state || [self willLoadState] == state;
}

- (NSString *)HTTPMethod {
    return kBPVGetMethod;
}

- (void)execute {
    BPVModel *model = [self modelToLoad];
    NSUInteger state = model.state;
    @synchronized (self) {
        if ([self shouldNotifyOfState:state]) {
            [model notifyOfState:state];
            
            return;
        }
        
        model.state = [self willLoadState];

        [self loadModel];
    }
}

- (void)loadModel {
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:self.path
                                                                   parameters:self.paremeters
                                                                   HTTPMethod:[self HTTPMethod]];
    BPVWeakify(self)
    BPVPerformSyncBlockOnMainQueue(^{
        BPVStrongifyAndReturnIfNil(self)
        [self loadModelWithRequest:request];
    });
}

- (id)cachedModel {
    return [NSKeyedUnarchiver objectFromFileWithPath:self.filePath];
}

- (id)modelToLoad {
    return self.model;
}

- (void)loadModelWithRequest:(FBSDKGraphRequest *)request {
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        BPVModel *model = [self modelToLoad];
        if (error) {
            NSLog(@"Faild data load with error: %@", error);
            model.state = [self failLoadingState];
            
            return;
        }
        
        [self fillModelWithInfo:[result JSONRepresentation]];
    }];
}

- (void)fillModelWithInfo:(NSDictionary *)info {

}

- (void)fillModelWithCachedModel:(id)model {
    [BPVUserInteractionContext fillUser:self.model withCachedUser:model];
}

- (NSUInteger)willLoadState {
    return BPVModelWillLoad;
}

- (NSUInteger)didLoadState {
    return BPVModelDidLoad;
}

- (NSUInteger)failLoadingState {
    return BPVModelFailLoading;
}

@end
