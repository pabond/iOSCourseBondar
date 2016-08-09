//
//  BPVUserDeleteData.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/8/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserData.h"

@implementation BPVUserData

- (instancetype)initWithUser:(BPVUser *)user
                       index:(NSUInteger)index
{
    self = [super init];
    if (self) {
        self.user = user;
        self.userIdex = index;
    }
    
    return self;
}

@end
