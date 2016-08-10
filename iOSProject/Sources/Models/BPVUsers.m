//
//  BPVUsers.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUsers.h"
#import "BPVUserData.h"

@interface BPVUsers ()
@property (nonatomic, strong)   NSMutableArray  *mutableUsers;
@property (nonatomic, strong)   BPVUserData     *userData;

@end

@implementation BPVUsers

@dynamic users;
@dynamic count;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init {
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

- (NSUInteger)count {
    return [self.mutableUsers count];
}

#pragma mark -
#pragma mark Public implementations

- (void)addUser:(id)user {
    if (user) {
        [self.mutableUsers addObject:user];
        [self setStateWithDataUsingIndex:[self indexOfUser:user]];
    }
}

- (void)removeUser:(id)user {
    if (user) {
        [self.mutableUsers removeObject:user];
    }
}

- (id)userAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self.mutableUsers objectAtIndex:index];
    }
    
    return nil;
}

- (void)moveUserFromSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex {
    BPVUser *user = [self userAtIndex:sourceIndex];
    BOOL notify = NO;
    [self removeUserAtIndex:sourceIndex notify:notify];
    [self insertUser:user atIndex:destinationIndex notify:notify];
}

- (void)insertUser:(id)user atIndex:(NSUInteger)index notify:(BOOL)notify {
    if (user) {
        [self.mutableUsers insertObject:user atIndex:index];
        if (notify) {
            [self setStateWithDataUsingIndex:index];
        }
    }
}

- (void)removeUserAtIndex:(NSUInteger)index notify:(BOOL)notify {
    [self.mutableUsers removeObjectAtIndex:index];
    if (notify) {
        [self setStateWithDataUsingIndex:index];
    }
}

- (NSUInteger)indexOfUser:(id)user {
    return [self.users indexOfObject:user];
}

#pragma mark -
#pragma mark Redefinition of parent methods

- (SEL)selectorForState:(NSUInteger)state {
    return @selector(collection:didUpdateWithUserData:);
}

#pragma mark -
#pragma mark Private methods

- (void)setStateWithDataUsingIndex:(NSUInteger)index {
    BPVUserData *data = [BPVUserData userDataWithUserIndex:index];
    [self setState:self.count withObject:data];
}

@end
