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

@interface BPVArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableModels;

- (void)fillArrayModel;
- (void)notifyOfArrayChangeWithObject:(id)object;

- (NSArray *)defaultArrayModel;
- (NSArray *)arrayModel;

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

- (NSString *)applicationFilePath {
    return nil;
}

- (NSUInteger)defaultModelsCount {
    return 0;
}

- (id)newModel {
    return nil;
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
    if ([NSKeyedArchiver archiveRootObject:self.models toFile:[self applicationFilePath]]) {
        NSLog(@"[SAVE] Saving operation succeeds");
    } else {
        NSLog(@"[FAIL] Data not saved");
    }
}

- (void)load {
    @synchronized (self) {
        NSUInteger state = self.state;
        if (BPVArrayModelWillLoad == state || BPVArrayModelDidLoad == state) {
            [self notifyOfState:state];
            
            return;
        }
        
        self.state = BPVArrayModelWillLoad;
        
        BPVWeakify(self)
        BPVPerformAsyncBlockOnBackgroundQueue(^{
            BPVStrongifyAndReturnIfNil(self)
            [self fillArrayModel];
        });
    }
}

#pragma mark -
#pragma mark Private implementations

- (void)fillArrayModel {
    @synchronized (self) {
        NSArray *array = [self arrayModel];
        NSUInteger state = NSUIntegerMax;
    
        if (!array) {
            state = BPVArrayModelFailLoading;
        } else {
            self.mutableModels = [array mutableCopy];
            state = BPVArrayModelDidLoad;
        }
        
        BPVWeakify(self)
        BPVPerformAsyncBlockOnMainQueue(^{
            BPVStrongifyAndReturnIfNil(self)
                self.state = state;
        });
    }
}

- (void)notifyOfArrayChangeWithObject:(id)object {
    [self notifyOfState:BPVArrayModelDidChange withObject:object];
}

- (NSArray *)defaultArrayModel {
    BPVWeakify(self)
    NSArray *array = [NSArray arrayWithObjectsFactoryWithCount:[self defaultModelsCount]
                                                         block:^id
                                                                    {
                                                                        BPVStrongifyAndReturnNilIfNil(self)
                                                             
                                                                        return [self newModel];
                                                                    }];
    
    return array;
}

- (NSArray *)arrayModel {
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:[self applicationFilePath]]];
    
    if (array) {
        NSLog(@"[LOADING] Array will load from file");
    } else {
        array = [self defaultArrayModel];
        NSLog(@"[LOADING] Default array count will load");
    }
    
    return array;
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
