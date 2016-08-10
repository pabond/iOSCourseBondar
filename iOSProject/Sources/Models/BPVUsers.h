//
//  BPVUsers.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@class BPVUsers;
@class BPVUserData;

@protocol BPVCollectionObserver <NSObject>
- (void)            collection:(BPVUsers *)collection
         didUpdateWithUserData:(BPVUserData *)data;

@end

@interface BPVUsers : BPVObservableObject
@property (nonatomic, readonly) NSArray     *users;
@property (nonatomic, readonly) NSUInteger  count;

- (void)addUser:(id)user;
- (void)removeUser:(id)user;

- (id)userAtIndex:(NSUInteger)index;

- (void)moveUserFromSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex;

- (void)insertUser:(id)user atIndex:(NSUInteger)index notify:(BOOL)notify;
- (void)removeUserAtIndex:(NSUInteger)index notify:(BOOL)notify;

@end
