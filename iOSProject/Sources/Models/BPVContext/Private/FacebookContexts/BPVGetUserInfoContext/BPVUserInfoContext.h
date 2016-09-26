//
//  BPVUserInfoContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFriendsListContext.h"

@class BPVUser;
@class BPVUserViewController;

@interface BPVUserInfoContext : BPVFriendsListContext
@property (nonatomic, strong)   BPVUser     *user;

@property (nonatomic, readonly) NSString *detailedParametersList;

@end
