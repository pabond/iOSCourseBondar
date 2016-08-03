//
//  BPVUsers.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsers.h"

@interface BPVUsers ()
@property (nonatomic, strong) NSMutableArray *mutableUsers;

@end

@implementation BPVUsers

@dynamic users;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mutableUsers = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)users {
    return [self.mutableUsers copy];
}

#pragma mark -
#pragma mark Public implementations

- (void)addUser:(id)user {
    if (user) {
        [self.mutableUsers addObject:user];
    }
}

- (void)removeUser:(id)user {
    if (user) {
        [self.mutableUsers removeObject:user];
    }
}

- (id)userAtIndex:(NSUInteger)index {
    if (index + 1 <= self.users.count) {
        return [self.mutableUsers objectAtIndex:index];
    }
    
    return nil;
}

- (void)moveUserFromSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex {
    [self.mutableUsers exchangeObjectAtIndex:sourceIndex withObjectAtIndex:destinationIndex];
}

- (void)insertUser:(id)user atIndex:(NSUInteger)index {
    [self.mutableUsers insertObject:user atIndex:index];
}

- (void)removeUserAtIndex:(NSUInteger)index {
    [self.mutableUsers removeObjectAtIndex:index];
}

@end
