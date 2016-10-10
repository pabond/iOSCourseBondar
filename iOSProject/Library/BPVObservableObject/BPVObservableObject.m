//
//  BPVObservableObject.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

#import "BPVMacro.h"

@interface BPVObservableObject ()
@property (nonatomic, retain) NSHashTable   *observersTable;
@property (nonatomic, assign) BOOL          shouldNotify;
@property (nonatomic, weak)   id            target;

- (void)notifyOfStateWithSelector:(SEL)selector object:(id)object;

- (instancetype)initWithTarget:(id)target;

@end

@implementation BPVObservableObject

@dynamic observersSet;

#pragma mark -
#pragma mark Class methods

+ (instancetype)observableObjectWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

#pragma mark -
#pragma mark Initialisations / Deallocations

- (instancetype)init {
    return [self initWithTarget:nil];
}

- (instancetype)initWithTarget:(id)target {
    self = [super init];
    self.shouldNotify = YES;
    self.observersTable = [NSHashTable weakObjectsHashTable];
    self.target = target ? target : self;
    
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

- (void)performBlockWithNotification:(BPVBlock)block {
    [self performBlock:block notify:YES];
}

- (void)performBlockWithoutNotification:(BPVBlock)block {
    [self performBlock:block notify:NO];
}

- (void)performBlock:(BPVBlock)block notify:(BOOL)notify {
    if (!block) {
        return;
    }
    
    @synchronized (self) {
        BOOL shouldNotify = self.shouldNotify;
        self.shouldNotify = notify;
        
        block();
        
        self.shouldNotify = shouldNotify;
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
    if (self.shouldNotify) {
        NSHashTable *observers = self.observersTable;
        for (id observer in observers) {
            if ([observer respondsToSelector:selector]) {
                [observer performSelector:selector withObject:self withObject:object];
            }
        }
    }
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    BPVObservableObject *objectCopy = [[self class] new];
    objectCopy.observersTable = [self.observersTable copyWithZone:zone];
        
    return objectCopy;
}

@end
