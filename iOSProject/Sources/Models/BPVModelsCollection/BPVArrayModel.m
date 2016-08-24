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

BPVStringConstant(kBPVCollection, @"users");
BPVConstant(NSUInteger, kBPVDefoultUsersCount, 10);

@interface BPVArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableModels;

- (NSArray *)addModelsWithCount:(NSUInteger)count;

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
            [self notifyOfState:BPVCollectionDidChange
                     withObject:[BPVArrayChange addingChangeModelWithIndex:[self indexOfModel:model]]];
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
    NSMutableArray *models = self.mutableModels;
    
    if (index < models.count) {
        return [models objectAtIndex:index];
    }
    
    return nil;
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    id model = [self modelAtIndex:fromIndex];
    BOOL notify = NO;
    [self removeModelAtIndex:fromIndex notify:notify];
    [self insertModel:model atIndex:toIndex notify:notify];
    [self notifyOfState:BPVCollectionDidChange
             withObject:[BPVArrayChange movingChangeModelWithIndex:toIndex
                                                                  fromIndex:fromIndex]];
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index notify:(BOOL)notify {
    if (model) {
        [self.mutableModels insertObject:model atIndex:index];
        if (notify) {
            [self notifyOfState:BPVCollectionDidChange withObject:[BPVArrayChange addingChangeModelWithIndex:index]];
        }
    }
}

- (void)removeModelAtIndex:(NSUInteger)index notify:(BOOL)notify {
    [self.mutableModels removeObjectAtIndex:index];
    if (notify) {
        [self notifyOfState:BPVCollectionDidChange withObject:[BPVArrayChange removingChangeModelWithIndex:index]];
    }
}

- (NSUInteger)indexOfModel:(id)model {
    return [self.mutableModels indexOfObject:model];
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
        array = [self addModelsWithCount:kBPVDefoultUsersCount];
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
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger itertionCount = 0; itertionCount < count; itertionCount++) {
        [array addObject:[BPVUser new]];
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
