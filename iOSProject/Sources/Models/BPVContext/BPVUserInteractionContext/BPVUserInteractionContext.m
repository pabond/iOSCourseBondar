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
    
    user.ID = userInfo[kBPVId];
    
    NSDictionary *picture = userInfo[kBPVPicture][kBPVData];
    user.imageURL = [NSURL URLWithString:picture[kBPVUrl]];
    
    user.email = userInfo[kBPVEmail];
    user.birthday = userInfo[kBPVBirthday];
}

+ (void)fillUser:(BPVUser *)user withUser:(BPVUser *)cachedUser {
    user.name = cachedUser.name;
    user.surname = cachedUser.surname;
    user.ID = cachedUser.ID;
    user.imageURL = cachedUser.imageURL;
    user.birthday = cachedUser.birthday;
    user.email = cachedUser.email;
}

@end
