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

#import "NSMutableArray+BPVExtensions.h"
#import "NSFileManager+BPVExtensions.h"
#import "NSArray+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVCollection, users);
BPVStringConstantWithValue(kBPVApplictionSaveFileName, /data.plist);
BPVConstant(NSUInteger, kBPVDefaultUsersCount, 10);

@interface BPVArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableModels;

- (void)loadModelsInBackground:(NSArray *)array;
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
            
        case BPVArrayModelUnload:
            return @selector(arrayModelUnload:);
            
        default:
            return [super selectorForState:state];
    }
}

#pragma mark -
#pragma mark saving and restoring of state

- (void)save {
    if ([NSKeyedArchiver archiveRootObject:self.mutableModels
                                    toFile:[NSFileManager applicationDataPathWithFileName:kBPVApplictionSaveFileName]]) {
        NSLog(@"[SAVE] Saving operation succeeds");
    } else {
        NSLog(@"[FAIL] Data not saved");
    }
}

- (void)load {
    NSData *data = [NSData dataWithContentsOfFile:[NSFileManager applicationDataPathWithFileName:kBPVApplictionSaveFileName]];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (array.count) {
        NSLog(@"[LOADING] Array load from file");
    }

    if (!array) {
        array = [NSArray arrayWithObjectsFactoryWithCount:kBPVDefaultUsersCount block:^id{ return [BPVUser new]; }];
        NSLog(@"[LOADING] Default array count load");
    }
    
    BPVPerformAsyncBlockOnBackgroundQueue(^{
        [self loadModelsInBackground:array];
    });
}

#pragma mark -
#pragma mark Private implementations

- (void)loadModelsInBackground:(NSArray *)array {
    @synchronized (self) {
        self.state = BPVArrayModelWillLoad;
        BPVWeakify(self)
        BPVStrongifyAndReturnIfNil(self)
        if (array) {
            self.mutableModels = [array mutableCopy];
        }

        BPVPerformAsyncBlockOnMainQueue(^{
            if (self.count) {
                self.state = BPVArrayModelDidLoad;
            } else {
                self.state = BPVArrayModelFailLoading;
            }
        });
    }
}

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
