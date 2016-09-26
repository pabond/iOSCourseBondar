//
//  BPVFriendsListContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFriendsListContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "BPVUserInfoContext.h"

#import "BPVUser.h"
#import "BPVUsers.h"

#import "BPVMacro.h"

@implementation BPVFriendsListContext

@dynamic parametersList;

#pragma mark -
#pragma mark Accessors

- (NSString *)parametersList {
    BPVReturnOnce(NSString, parametersList, (^{
        return [NSString stringWithFormat:@"%@,%@,%@,%@", kBPVId, kBPVName, kBPVSurname, kBPVLargePicture];
    }));
}

#pragma mark -
#pragma mark Public Implementations

- (void)execute {
    NSDictionary *parameters = @{kBPVFields:self.parametersList};
    NSString *path = [self.userID stringByAppendingString:kBPVFriends];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:path
                                                                   parameters:parameters
                                                                   HTTPMethod:kBPVGetMethod];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error || !result) {
            NSLog(@"Faild data load with error: %@", error);
            return;
        }

        NSArray *friendsList = result[kBPVData];
        NSMutableArray *array = [NSMutableArray array];
        BPVUser *user = nil;
        BPVUserInfoContext *userContext = [BPVUserInfoContext new];
        
        if (friendsList) {
            for (NSDictionary *friend in friendsList) {
                user = [BPVUser new];
                userContext.user = user;
                userContext.userInfo = friend;
                
                [userContext execute];
                
                [array addObject:user];
            }
            
            NSLog(@"[LOADING] Array loaded from Internet");
        } else {
            [array addObjectsFromArray:[self.arrayModel cachedArray]];
            NSLog(@"[LOADING] Array will load from file");
        }
        
        BPVWeakify(self)
        [self.arrayModel performBlockWithoutNotification:^{
            BPVStrongifyAndReturnIfNil(self)
            [self.arrayModel addModels:array];
        }];
        
        self.arrayModel.state = BPVModelDidLoad;
    }];
}

- (NSDictionary *)dictionatyWithResponseResult:(NSDictionary *)result {
    if (!result) {
        return nil;
    }
    
//    NSMutableDictionary *dictionary = [result mutableCopy];
    
    return nil;
}

@end
