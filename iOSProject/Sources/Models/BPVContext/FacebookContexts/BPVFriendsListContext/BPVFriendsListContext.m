//
//  BPVFriendsListContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFriendsListContext.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "BPVUser.h"
#import "BPVUsers.h"

BPVStringConstantWithValue(kBPVPlist, plist);

@implementation BPVFriendsListContext

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)paremeters {
    return @{kBPVFields:[NSString stringWithFormat:@"%@,%@,%@,%@", kBPVId, kBPVName, kBPVSurname, kBPVLargePicture]};
}

- (NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", self.user.ID, kBPVFriends];
}

- (NSString *)fileName {
    return [NSString stringWithFormat:@"%@%@.%@", self.user.ID, kBPVFriends, kBPVPlist];
}

#pragma mark -
#pragma mark Public Implementations

- (void)fillModelWithInfo:(NSDictionary *)info {
    NSArray *friendsList = info[kBPVData];
    NSMutableArray *array = [NSMutableArray array];
    
    BPVUser *user = self.user;
    BPVUsers *model = user.friends;
    
    if (friendsList) {
        for (NSDictionary *friend in friendsList) {
            BPVUser *user = [BPVUser new];
            [self fillUser:user withUserInfo:friend];
            
            [array addObject:user];
        }
        
        NSLog(@"[LOADING] Array loaded from Internet");
    } else {
        [array addObjectsFromArray:[self cachedModel]];
        NSLog(@"[LOADING] Array will load from file");
    }
    
    BPVWeakify(self)
    [model performBlockWithoutNotification:^{
        BPVStrongifyAndReturnIfNil(self)
        [model addModels:array];
    }];
    
    [self saveObject:model.models];
    
    NSUInteger state = BPVModelDidLoadFriends;
    if (self.isCanceled) {
        self.user = self.defaultModel;
        state = BPVModelFailLoading;
    }
    
    user.state = state;
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

- (NSUInteger)willLoadState {
    return BPVModelWillLoadFriends;
}

@end
