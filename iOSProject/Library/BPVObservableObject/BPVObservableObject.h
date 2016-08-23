//
//  BPVObservableObject.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BPVBlock)();

@interface BPVObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger  state;
@property (nonatomic, readonly) NSSet       *observersSet;

- (void)addObserver:(id)observer;
- (void)addObservers:(NSArray *)observers;

- (void)removeObserver:(NSObject *)observer;
- (void)removeObservers:(NSArray *)observers;

- (BOOL)containsObserver:(id)object;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (void)performBlockWithNotification:(BPVBlock)block;
- (void)performBlockWithoutNotification:(BPVBlock)block;

// don't call this method directly, sould be lounched only from subclasses
- (SEL)selectorForState:(NSUInteger)state;

// these methods are called in subclasses
// you should never call this methods directly from outside subclasses 
- (void)notifyOfState:(NSUInteger)state;
- (void)notifyOfState:(NSUInteger)state withObject:(id)object;

@end
