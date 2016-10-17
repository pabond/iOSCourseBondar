//
//  BPVUserInteractionContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 10/7/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVContext.h"

@class BPVUser;

@interface BPVUserInteractionContext : BPVContext

+ (void)fillUser:(BPVUser *)user withUserInfo:(NSDictionary *)userInfo;
+ (void)fillUser:(BPVUser *)user withCachedUser:(BPVUser *)cachedUser;

@end
