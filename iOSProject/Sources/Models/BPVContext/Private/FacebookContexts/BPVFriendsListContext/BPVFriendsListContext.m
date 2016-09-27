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

@implementation BPVFriendsListContext

@dynamic parametersList;

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)paremeters {
    return @{kBPVFields:self.parametersList};
}

- (NSString *)parametersList {
    return [NSString stringWithFormat:@"%@,%@,%@,%@", kBPVId, kBPVName, kBPVSurname, kBPVLargePicture];
}

- (NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", self.userID, kBPVFriends];
}

#pragma mark -
#pragma mark Public Implementations

- (void)performLoadingWithInfo:(NSDictionary *)info {
    NSArray *friendsList = info[kBPVData];
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
        [array addObjectsFromArray:[(BPVUsers *)self.arrayModel cachedArray]];
        NSLog(@"[LOADING] Array will load from file");
    }
    
    BPVWeakify(self)
    [self.arrayModel performBlockWithoutNotification:^{
        BPVStrongifyAndReturnIfNil(self)
        [self.arrayModel addModels:array];
    }];
    
    self.arrayModel.state = BPVModelDidLoad;
}

@end
