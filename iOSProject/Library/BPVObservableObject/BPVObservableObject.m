//
//  BPVObservableObject.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

@interface BPVObservableObject ()
@property (nonatomic, retain) NSHashTable     *observersTable;

- (SEL)selectorForState:(NSUInteger)state;

- (void)notifyOfStateWithSelector:(SEL)selector object:(id)object;

@end

@implementation BPVObservableObject

@dynamic observersSet;

#pragma mark -
#pragma mark Initialisations / Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observersTable = [NSHashTable weakObjectsHashTable];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observersSet {
    @synchronized (self) {
        return self.observersTable.setRepresentation;
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)addObserver:(id)observer {
    @synchronized (self) {
        if (observer) {
            [self.observersTable addObject:observer];
        }
    }
}

- (void)removeObserver:(NSObject *)observer {
    @synchronized (self) {
        [self.observersTable removeObject:observer];
    }
}

- (void)addObservers:(NSArray *)observers {
    for (id observer in observers) {
        [self addObserver:observer];
    }
}

- (void)removeObservers:(NSArray *)observers {
    for (id observer in observers) {
        [self removeObserver:observer];
    }
}

- (BOOL)containsObserver:(id)object {
    @synchronized (self) {
        return [self.observersTable containsObject:object];
    }
}

- (void)setState:(NSUInteger)state {
    @synchronized (self) {
        [self setState:state withObject:nil];
    }
}

- (void)setState:(NSUInteger)state withObject:(id)object {
    @synchronized (self) {
        if (_state != state) {
            _state = state;
            
            [self notifyOfState:state withObject:object];
        }
    }
}

- (void)notifyOfState:(NSUInteger)state {
    [self notifyOfState:state withObject:nil];
}

- (void)notifyOfState:(NSUInteger)state withObject:(id)object {
    @synchronized (self) {
        [self notifyOfStateWithSelector:[self selectorForState:state] object:object];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#pragma mark -
#pragma mark Private implementations

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

- (void)notifyOfStateWithSelector:(SEL)selector object:(id)object {
    NSHashTable *observers = self.observersTable;
    for (id observer in observers) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self withObject:object];
        }
    }
}

@end
