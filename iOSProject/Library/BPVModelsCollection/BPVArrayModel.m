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

BPVStringConstantWithValue(kBPVApplictionSaveFileName, /data.plist);

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
    NSMutableArray *array = nil;
    @synchronized (self) {
        array = [self.mutableModels copy];
    }
    
    return array;
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
            [self notifyOfArrayChangeWithObject:[BPVArrayChange addModelWithIndex:[self indexOfModel:model]]];
        }
    }
}

- (void)removeModel:(id)model {
    @synchronized (self) {
        if (model) {
            [self.mutableModels removeObject:model];
            [self notifyOfArrayChangeWithObject:[BPVArrayChange removeModelWithIndex:[self indexOfModel:model]]];
        }
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
    if (index < self.count) {
        return self.mutableModels[index];
    }
    
    return nil;
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    @synchronized (self) {
        [self performBlockWithoutNotification:^{
            [self.mutableModels moveObjectFromIndex:fromIndex toIndex:toIndex];
        }];
            
        [self notifyOfArrayChangeWithObject:[BPVArrayChange moveModelWithIndex:toIndex fromIndex:fromIndex]];
    }
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index {
    if (!model) {
        return;
    }
    
    @synchronized (self) {
        [self.mutableModels insertObject:model atIndex:index];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange addModelWithIndex:index]];
    }
}

- (void)removeModelAtIndex:(NSUInteger)index {
    @synchronized (self) {
        [self.mutableModels removeObjectAtIndex:index];
        [self notifyOfArrayChangeWithObject:[BPVArrayChange removeModelWithIndex:index]];
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
        case BPVArrayModelDidChange:
            return @selector(arrayModel:didChangeWithModel:);
            
        case BPVArrayModelDidLoad:
            return @selector(arrayModelDidLoad:);
            
        case BPVArrayModelFailLoading:
            return @selector(arrayModelFailLoading:);
            
        case BPVArrayModelWillLoad:
            return @selector(arrayModelWillLoad:);
            
        case BPVArrayModelDidUnload:
            return @selector(arrayModelUnload:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark saving and restoring of state

- (void)save {

}

- (void)load {
    NSUInteger state = self.state;
    @synchronized (self) {
        if (BPVArrayModelDidLoad == state || BPVArrayModelWillLoad == state) {
            [self notifyOfState:state];
            
            return;
        }
        
        self.state = BPVArrayModelWillLoad;
        
        BPVWeakify(self)
        BPVPerformAsyncBlockOnBackgroundQueue(^{
            BPVStrongifyAndReturnIfNil(self)
            [self performLoading];
        });
    }
}

- (void)performLoading {

}

#pragma mark -
#pragma mark Private implementations

- (void)notifyOfArrayChangeWithObject:(id)object {
    [self notifyOfState:BPVArrayModelDidChange withObject:object];
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
