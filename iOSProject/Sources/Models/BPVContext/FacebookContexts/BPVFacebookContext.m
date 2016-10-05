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
            [self.user notifyOfState:state];
            
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
    return self.user;
}

- (void)loadModelWithRequest:(FBSDKGraphRequest *)request {
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        BPVUser *user = self.user;
        if (error) {
            if (self.isCached) {
                id cachedModel = [self cachedModel];
                [self fillModelWithCachedModel:cachedModel];
                user.state = [self didLoadState];
                
                return;
            }
            
            NSLog(@"Faild data load with error: %@", error);
            user.state = [self failLoadingState];
            
            return;
        }
        
        [self fillModelWithInfo:[result JSONRepresentation]];
    }];
}

- (void)fillModelWithInfo:(NSDictionary *)info {

}

- (void)fillModelWithCachedModel:(id)model {
    [self fillUser:self.user withUser:model];
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

- (void)fillUser:(BPVUser *)user withUserInfo:(NSDictionary *)userInfo {
    user.name = userInfo[kBPVName];
    user.surname = userInfo[kBPVSurname];
    
    user.ID = userInfo[kBPVId];
    
    NSDictionary *picture = userInfo[kBPVPicture][kBPVData];
    user.imageURL = [NSURL URLWithString:picture[kBPVUrl]];
    
    user.email = userInfo[kBPVEmail];
    user.birthday = userInfo[kBPVBirthday];
}

- (void)saveObject:(id)object {
    if ([NSKeyedArchiver archiveRootObject:object toFile:self.filePath]) {
        NSLog(@"[SAVE] Saving operation succeeds");
    } else {
        NSLog(@"[FAIL] Data not saved");
    }
}

- (void)fillUser:(BPVUser *)user withUser:(BPVUser *)cachedUser {
    user.name = cachedUser.name;
    user.surname = cachedUser.surname;
    user.ID = cachedUser.ID;
    user.imageURL = cachedUser.imageURL;
    user.birthday = cachedUser.birthday;
    user.email = cachedUser.email;
}

@end
