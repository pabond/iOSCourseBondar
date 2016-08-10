//
//  BPVUserDeleteData.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/8/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserData.h"

@interface BPVUserData ()

- (instancetype)initWithUser:(BPVUser *)user index:(NSUInteger)index;

@end

@implementation BPVUserData

#pragma mark -
#pragma mark Class methods

+ (instancetype)userDataWithUser:(BPVUser *)user index:(NSUInteger)index {
    return [[self alloc] initWithUser:user index:index];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithUser:(BPVUser *)user index:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.user = user;
        self.userIndex = index;
    }
    
    return self;
}

@end
