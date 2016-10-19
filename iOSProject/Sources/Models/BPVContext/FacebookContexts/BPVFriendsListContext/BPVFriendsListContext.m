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

#import "BPVUserInteractionContext.h"
#import <MagicalRecord/MagicalRecord.h>

BPVStringConstantWithValue(kBPVPlist, plist);

@implementation BPVFriendsListContext

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)paremeters {
    return @{kBPVFields:[NSString stringWithFormat:@"%@,%@,%@,%@", kBPVId, kBPVName, kBPVSurname, kBPVLargePicture]};
}

- (NSString *)path {
    BPVUser *model = self.model;
    
    return [NSString stringWithFormat:@"%@/%@", model.userID, kBPVFriends];
}

- (NSString *)fileName {
    BPVUser *model = self.model;
    
    return [NSString stringWithFormat:@"%@%@.%@", model.userID, kBPVFriends, kBPVPlist];
}

#pragma mark -
#pragma mark Public Implementations

- (void)fillModelWithInfo:(NSDictionary *)info {
    NSArray *friendsList = info[kBPVData];
    NSMutableArray *array = [NSMutableArray array];
    
    BPVUsers *model = [self modelToLoad];
    
    if (friendsList) {
        BPVUser *user = nil;
        for (NSDictionary *friend in friendsList) {
            user = [BPVUser MR_createEntity];
            [BPVUserInteractionContext fillUser:user withUserInfo:friend];
            
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
  
    [[NSManagedObjectContext MR_context] save:nil];
//    [self saveObject:model.models];

    model.state = BPVModelDidLoad;
}

- (void)fillModelWithCachedModel:(BPVUsers *)model {
    BPVUsers *friends = [self modelToLoad];
    BPVUser *friend = nil;
    for (NSUInteger iterator = 0; iterator < model.count; iterator++) {
        friend = friends[iterator];
        if (!friend) {
            [friends addModel:[BPVUser MR_createEntity]];
            friend = friends[iterator];
        }
        
        [BPVUserInteractionContext fillUser:friend withCachedUser:model[iterator]];
    }
}

- (id)modelToLoad {
    BPVUser *model = self.model;
    
    return model.arrayModel;
}

@end
