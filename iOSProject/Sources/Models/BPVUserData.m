//
//  BPVUserDeleteData.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/8/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUserData.h"

@interface BPVUserData ()

- (instancetype)initWithUserIndex:(NSUInteger)index;

@end

@implementation BPVUserData

#pragma mark -
#pragma mark Class methods

+ (instancetype)userDataWithUserIndex:(NSUInteger)index {
    return [[self alloc] initWithUserIndex:index];
}

#pragma mark -
#pragma mark Initializationa and deallocations

- (instancetype)initWithUserIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.userIndex = index;
    }
    
    return self;
}

@end
