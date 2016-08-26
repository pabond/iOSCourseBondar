//
//  NSMutableArray+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/26/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSMutableArray+BPVExtensions.h"

@implementation NSMutableArray (BPVExtensions)

- (void)moveObjectFromIndex:(NSUInteger)fromIndex  toIndex:(NSUInteger)toIndex {
    @synchronized (self) {
        id object = self[fromIndex];
        
        NSLog(@"[BEFORE MOVING] object:%@ at index:%lu", object, (unsigned long)[self indexOfObject:object]);
        NSLog(@"[MOVING] %@ fromIntdex:%lu toIndex:%lu", object, (unsigned long)fromIndex, (unsigned long)toIndex);
        
        [self removeObjectAtIndex:fromIndex];
        [self insertObject:object atIndex:toIndex];
        
        NSLog(@"[AFTER MOVING] object at index:%@. Moved object index:%lu",
              self[toIndex],
              (unsigned long)[self indexOfObject:object]);
    }
}

@end
