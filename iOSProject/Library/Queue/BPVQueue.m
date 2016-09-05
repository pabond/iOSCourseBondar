//
//  BPVQueue.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVQueue.h"

@interface BPVQueue ()
@property (nonatomic, retain) NSMutableArray *mutableQueue;

@end

@implementation BPVQueue

@dynamic queue;
@dynamic count;

#pragma mark -
#pragma mark Deallocation / Initialisation

- (instancetype)init {
    self = [super init];
    self.mutableQueue = [NSMutableArray array];
    
    return self;
}

- (NSArray *)queue {
    @synchronized (self.mutableQueue) {
        return [self.mutableQueue copy];
    }
}

- (NSUInteger)count {
    @synchronized (self.mutableQueue) {
        return self.queue.count;
    }
}

- (void)enqueueObject:(id)object {
    @synchronized (self) {
        if (object) {
            [self.mutableQueue addObject:object];
        }
    }
}

- (id)dequeueObject {
    @synchronized (self) {
        NSMutableArray *queue = self.mutableQueue;
        if (!queue.count) {
            return nil;
        }
        
        id nextObject = [queue firstObject];
        [queue removeObject:nextObject];
        
        return nextObject;
    }
}

- (void)enqueueObjects:(NSArray *)objects {
    @synchronized (self) {
        [self.mutableQueue addObjectsFromArray:objects];
    }
}

@end

