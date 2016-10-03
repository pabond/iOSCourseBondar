//
//  BPVFacebookContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/26/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFacebookContext.h"

#import "BPVModel.h"
#import "BPVUser.h"
#import "BPVGCD.h"
#import "BPVFriendsListContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "NSFileManager+BPVExtensions.h"
#import "NSDictionary+BPVExtensions.h"
#import "NSKeyedUnarchiver+BPVExtensions.h"

BPVStringConstantWithValue(kBPVPlist, plist);
BPVStringConstantWithValue(kBPVModelsFolder, BPVModels);

@interface BPVFacebookContext ()
@property (nonatomic, strong) BPVUser  *defaultModel;

- (void)loadModel;

@end

@implementation BPVFacebookContext

@dynamic paremeters;
@dynamic path;
@dynamic applicationModelsPath;
@dynamic filePath;
@dynamic fileName;
@dynamic isCached;

#pragma mark -
#pragma mark Accessors

- (void)setUser:(BPVUser *)user {
    if (_user != user) {
        _user = user;
        
        self.defaultModel = [_user copy];
    }
}

- (BOOL)isCached {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.filePath];
}

- (NSString *)applicationModelsPath {
    return  [NSFileManager applicationDataPathWithFolderName:kBPVModelsFolder];
}

- (NSString *)filePath {
    return [self.applicationModelsPath stringByAppendingPathComponent:[self fileName]];
}

- (NSString *)fileName {
    return [NSString stringWithFormat:@"%@.%@", self.user.ID, kBPVPlist];
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
    NSUInteger state = self.user.state;
    @synchronized (self) {
        if ([self shouldNotifyOfState:state]) {
            [self.user notifyOfState:state];
            
            return;
        }
        
        self.user.state = [self willLoadState];

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

- (void)loadModelWithRequest:(FBSDKGraphRequest *)request {
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error) {
            if (!self.isCached) {
                [self cachedModel];
            }
            
            NSLog(@"Faild data load with error: %@", error);
            self.user.state = BPVModelFailLoading;
            
            return;
        }
        
        [self fillModelWithInfo:[result JSONRepresentation]];
    }];
}

- (void)fillModelWithInfo:(NSDictionary *)info {

}

- (NSUInteger)willLoadState {
    return BPVModelWillLoad;
}

- (void)saveObject:(id)object {
    if ([NSKeyedArchiver archiveRootObject:object toFile:self.filePath]) {
        NSLog(@"[SAVE] Saving operation succeeds");
    } else {
        NSLog(@"[FAIL] Data not saved");
    }
}

@end
