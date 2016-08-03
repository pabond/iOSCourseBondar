//
//  BPVUsers.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVUsers : BPVObservableObject
@property (nonatomic, readonly) NSArray *users;

- (void)addUser:(id)user;
- (void)removeUser:(id)user;

- (id)userAtIndex:(NSUInteger)index;

- (void)moveUserFromSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex;

- (void)insertUser:(id)user atIndex:(NSUInteger)index;
- (void)removeUserAtIndex:(NSUInteger)index;

@end
