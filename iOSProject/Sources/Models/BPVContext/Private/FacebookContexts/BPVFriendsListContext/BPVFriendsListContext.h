//
//  BPVFriendsListContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFacebookContext.h"

@class BPVUsers;

@interface BPVFriendsListContext : BPVFacebookContext
@property (nonatomic, copy)     NSString    *userID;
@property (nonatomic, strong)   BPVUsers    *arrayModel;

@property (nonatomic, readonly) NSString *parametersList;


@end
