//
//  BPVArrayModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayModel.h"

#import "BPVArrayChange.h"

#import "BPVGCD.h"

#import "NSMutableArray+BPVExtensions.h"
#import "NSFileManager+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

@interface BPVArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableModels;

- (void)notifyOfArrayChangeWithObject:(id)object;

@end

@implementation BPVArrayModel

@dynamic models;
@dynamic count;

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableModels = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)models {
    @synchronized (self) {
        return [self.mutableModels copy];
    }
}

- (NSUInteger)count {
    @synchronized (self) {
        return [self.mutableModels count];
    }
}

#pragma mark -
#pragma mark Public implementations

- (void)addModel:(id)model {
    if (!model) {
        return;
    }
    
    @synchronized (self) {
        [self.mutableModels addObject:model];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange addModelWithIndex:[self indexOfModel:model] object:model]];
    }
}

- (void)removeModel:(id)model {
    if (!model) {
        return;
    }
    
    @synchronized (self) {
        NSUInteger index = [self indexOfModel:model];
        [self.mutableModels removeObject:model];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange removeModelWithIndex:index object:model]];
    }
}

- (void)addModels:(NSArray *)models {
    @synchronized (self) {
        if (models) {
            for (id model in models) {
                [self addModel:model];
            }
        }
    }
}

- (id)modelAtIndex:(NSUInteger)index {
    if (!(index < self.count)) {
        return nil;
    }
    
    @synchronized (self) {
        return self.mutableModels[index];
    }
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    @synchronized (self) {
        [self.mutableModels moveObjectFromIndex:fromIndex toIndex:toIndex];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange moveModelWithIndex:toIndex
                                                                     fromIndex:fromIndex
                                                                        object:[self modelAtIndex:fromIndex]]];
    }
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index {
    if (!model) {
        return;
    }
    
    @synchronized (self) {
        [self.mutableModels insertObject:model atIndex:index];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange addModelWithIndex:index object:model]];
    }
}

- (BOOL)containsModel:(id)model {
    @synchronized (self) {
        return [self.mutableModels containsObject:model];
    }
}

- (void)removeModelAtIndex:(NSUInteger)index {
    @synchronized (self) {
        id object = [self modelAtIndex:index];
        [self.mutableModels removeObjectAtIndex:index];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange removeModelWithIndex:index object:object]];
    }
}

- (NSUInteger)indexOfModel:(id)model {
    @synchronized (self) {
        return [self.mutableModels indexOfObject:model];
    }
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self modelAtIndex:index];
}

#pragma mark -
#pragma mark Private implementations

- (void)notifyOfArrayChangeWithObject:(id)object {
    [self notifyOfState:BPVModelDidChange withObject:object];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)length
{
    return [self.mutableModels countByEnumeratingWithState:state objects:buffer count:length];
}

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVModelDidChange:
            return @selector(model:didChangeWithModel:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone {
    BPVArrayModel *objectCopy = [super copyWithZone:zone];
    if (objectCopy) {
        objectCopy.mutableModels = [NSMutableArray arrayWithArray:[self.mutableModels copyWithZone:zone]];
    }
    
    return objectCopy;
}

@end
