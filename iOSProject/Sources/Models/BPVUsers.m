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

- (void)notifyOfCollectionDidChangeWhithData:(BPVUserData *)data;

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
        BPVUserData *data = [BPVUserData userDataWithUser:user index:[self indexOfUser:user]];
        [self notifyOfCollectionDidChangeWhithData:data];
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
    [self.mutableUsers exchangeObjectAtIndex:sourceIndex withObjectAtIndex:destinationIndex];
}

- (void)insertUser:(id)user atIndex:(NSUInteger)index {
    if (user) {
        [self.mutableUsers insertObject:user atIndex:index];
    }
}

- (void)removeUserAtIndex:(NSUInteger)index {
    [self.mutableUsers removeObjectAtIndex:index];
    BPVUserData *data = [BPVUserData userDataWithUser:[self userAtIndex:index] index:index];
    [self notifyOfCollectionDidChangeWhithData:data];
}

- (NSUInteger)indexOfUser:(id)user {
    return [self.users indexOfObject:user];
}

#pragma mark -
#pragma mark Private implementations

- (void)notifyOfCollectionDidChangeWhithData:(BPVUserData *)data {
    [self notifyOfStateWithSelector:@selector(collection:didUpdateWithUserData:) object:data];
}

#pragma mark -
#pragma mark Redefinition of parent methods

//- (SEL)selectorForState:(NSUInteger)state {
//    return @selector(collectionDidChange:);
//}

@end
