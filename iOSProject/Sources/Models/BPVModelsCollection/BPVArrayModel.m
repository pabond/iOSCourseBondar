//
//  BPVArrayModel.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayModel.h"

#import "BPVUser.h"

#import "BPVArrayChange.h"

#import "BPVGCD.h"
#import "BPVMacro.h"

#import "NSFileManager+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

BPVStringConstant(kBPVCollection, @"users");
BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@interface BPVArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableModels;

- (NSArray *)addModelsWithCount:(NSUInteger)count;
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
    return [self.mutableModels copy];
}

- (NSUInteger)count {
    return [self.mutableModels count];
}

#pragma mark -
#pragma mark Public implementations

- (void)addModel:(id)model {
    @synchronized (self) {
        if (model) {
            [self.mutableModels addObject:model];
            [self notifyOfArrayChangeWithObject:[BPVArrayChange addingChangeModelWithIndex:[self indexOfModel:model]]];
        }
    }
}

- (void)removeModel:(id)model {
    @synchronized (self) {
        if (model) {
            [self.mutableModels removeObject:model];
        }
    }
}

- (void)addModels:(NSArray *)models {
    if (models) {
        for (id model in models) {
            [self addModel:model];
        }
        
        self.state = BPVCollectionDidLoad;
    }
}

- (id)modelAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return self.mutableModels[index];
    }
    
    return nil;
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    id model = self[fromIndex];
    
    NSLog(@"[BEFORE MOVING] object at index:%@", model);
    NSLog(@"[MOVING] %@ fromIntdex:%lu toIndex:%lu", model, (unsigned long)fromIndex, (unsigned long)toIndex);
    
    [self performBlockWithoutNotification:^{
        @synchronized (self) {
            [self removeModelAtIndex:fromIndex];
            [self insertModel:model atIndex:toIndex];
        }
    }];
    
    NSLog(@"[AFTER MOVING] object at index:%@", self[toIndex]);
    NSLog(@"[AFTER MOVING] moved object index:%lu", (unsigned long)[self indexOfModel:model]);
    
    [self notifyOfArrayChangeWithObject:[BPVArrayChange movingChangeModelWithIndex:toIndex fromIndex:fromIndex]];
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index {
    if (!model) {
        return;
    }
    
    @synchronized (self) {
        [self.mutableModels insertObject:model atIndex:index];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange addingChangeModelWithIndex:index]];
    }
}

- (void)removeModelAtIndex:(NSUInteger)index {
    @synchronized (self) {
        [self.mutableModels removeObjectAtIndex:index];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange removingChangeModelWithIndex:index]];
    }
}

- (NSUInteger)indexOfModel:(id)model {
    return [self.mutableModels indexOfObject:model];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self modelAtIndex:index];
}

#pragma mark -
#pragma mark Redefinition of parent methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case BPVCollectionDidChange:
            return @selector(collection:didChangeWithModel:);
            
        case BPVCollectionDidLoad:
            return @selector(collectionDidLoad:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark saving and restoring of state

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.models];
    
    if ([data writeToFile:[NSFileManager dataPath] atomically:YES]) {
        NSLog(@"Saving operation succeeds");
    } else {
        NSLog(@"Data not saved");
    }
}

- (void)load {
    NSData *data = [NSData dataWithContentsOfFile:[NSFileManager dataPath]];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!array.count) {
        array = [self addModelsWithCount:kBPVDefaultUsersCount];
    }
    
    BPVWeakify(self)
    BPVPerformAsyncBlockOnMainQueue(^{
        BPVStrongify(self)
        if (data) {
            [self addModels:array];
        }
    });
}

#pragma mark -
#pragma mark Private implementations

- (NSArray *)addModelsWithCount:(NSUInteger)count {
    return [NSArray arrayWithObjectsFactoryWithCount:count block:^id{ return [BPVUser new]; }];
}

- (void)notifyOfArrayChangeWithObject:(id)object {
    [self notifyOfState:BPVCollectionDidChange withObject:object];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)length
{
    return [self.mutableModels countByEnumeratingWithState:state objects:buffer count:length];
}

@end
