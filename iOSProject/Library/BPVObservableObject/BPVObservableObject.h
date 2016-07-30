//
//  BPVObservableObject.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger  state;
@property (nonatomic, readonly) NSSet       *observersSet;

- (void)addObserver:(id)observer;
- (void)addObservers:(NSArray *)observers;

- (void)removeObserver:(NSObject *)observer;
- (void)removeObservers:(NSArray *)observers;

- (BOOL)containsObserver:(id)object;

- (SEL)selectorForState:(NSUInteger)state;

- (void)notifyOfState:(NSUInteger)state;
- (void)notifyOfState:(NSUInteger)state withObject:(id)object;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (void)notifyOfStateWithSelector:(SEL)selector object:(id)object;

@end
