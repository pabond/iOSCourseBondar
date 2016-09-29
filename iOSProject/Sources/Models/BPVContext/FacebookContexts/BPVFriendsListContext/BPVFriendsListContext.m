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

@implementation BPVFriendsListContext

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)paremeters {
    return @{kBPVFields:[NSString stringWithFormat:@"%@,%@,%@,%@", kBPVId, kBPVName, kBPVSurname, kBPVLargePicture]};
}

- (NSString *)path {
    return [NSString stringWithFormat:@"%@/%@", self.user.ID, kBPVFriends];
}

#pragma mark -
#pragma mark Public Implementations

- (void)fillModelWithInfo:(NSDictionary *)info {
    NSString *userID = self.user.ID;
    NSArray *friendsList = info[kBPVData];
    NSMutableArray *array = [NSMutableArray array];
    
    BPVUsers *model = (BPVUsers *)self.model;
    
    if (friendsList) {
        for (NSDictionary *friend in friendsList) {
            BPVUser *user = [BPVUser new];
            
            user.name = friend[kBPVName];
            user.surname = friend[kBPVSurname];
            
            user.ID = friend[kBPVId];
            
            NSDictionary *picture = friend[kBPVPicture][kBPVData];
            user.imageURL = [NSURL URLWithString:picture[kBPVUrl]];
            
            [array addObject:user];
        }
        
        [self.model saveToFile:userID];
        NSLog(@"[LOADING] Array loaded from Internet");
    } else {
        [array addObjectsFromArray:[model cachedArrayWithUserID:userID]];
        NSLog(@"[LOADING] Array will load from file");
    }
    
    BPVWeakify(self)
    [model performBlockWithoutNotification:^{
        BPVStrongifyAndReturnIfNil(self)
        [model addModels:array];
    }];
    
    NSUInteger state = BPVModelDidLoad;
    if (self.isCanceled) {
        self.model = self.defaultModel;
        state = BPVModelFailLoading;
    }
    
    model.state = state;
}

@end
