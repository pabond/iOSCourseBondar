//
//  BPVUsers.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayModel.h"

@interface BPVUsers : BPVArrayModel
@property (nonatomic, readonly) NSString *userID;

+ (instancetype)friendsWithUserID:(NSString *)userID;

@end
