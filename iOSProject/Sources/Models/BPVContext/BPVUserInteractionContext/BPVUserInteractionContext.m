//
//  BPVUserInteractionContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserInteractionContext.h"

#import "BPVFacebookContext.h"

#import "BPVUser.h"

@implementation BPVUserInteractionContext

+ (void)fillUser:(BPVUser *)user withUserInfo:(NSDictionary *)userInfo {
    user.name = userInfo[kBPVName];
    user.surname = userInfo[kBPVSurname];
    
    user.userID = userInfo[kBPVId];
    
    NSDictionary *picture = userInfo[kBPVPicture][kBPVData];
    user.imageURLString = picture[kBPVUrl];
    
    user.email = userInfo[kBPVEmail];
    user.birthday = userInfo[kBPVBirthday];
}

+ (void)fillUser:(BPVUser *)user withCachedUser:(BPVUser *)cachedUser {
    user.name = cachedUser.name;
    user.surname = cachedUser.surname;
    user.userID = cachedUser.userID;
    user.imageURLString = cachedUser.imageURLString;
    user.birthday = cachedUser.birthday;
    user.email = cachedUser.email;
}

@end
