//
//  BPVModelsCollection.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVModelsCollection.h"

#import "BPVCollectionChangeFromIndex.h"

#import "BPVUserData.h"

@interface BPVModelsCollection ()
@property (nonatomic, strong)   NSMutableArray  *mutableModels;

@end

@implementation BPVModelsCollection

@dynamic modelsArray;
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
    if (model) {
        [self.mutableModels addObject:model];
        [self notifyOfState:BPVChangingTypeAdd withObject:[BPVCollectionChange addingObjectWithIndex:[self indexOfModel:model]]];
    }
}

- (void)removeModel:(id)user {
    if (user) {
        [self.mutableModels removeObject:user];
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
    [self notifyOfState:BPVChangingTypeMove
             withObject:[BPVCollectionChangeFromIndex movingObjectwithIndex:toIndex
                                                                  fromIndex:fromIndex]];
}

- (void)insertModel:(id)user atIndex:(NSUInteger)index notify:(BOOL)notify {
    if (user) {
        [self.mutableModels insertObject:user atIndex:index];
        if (notify) {
            [self notifyOfState:BPVChangingTypeAdd withObject:[BPVCollectionChange addingObjectWithIndex:index]];
        }
    }
}

- (void)removeModelAtIndex:(NSUInteger)index notify:(BOOL)notify {
    [self.mutableModels removeObjectAtIndex:index];
    if (notify) {
        [self notifyOfState:BPVChangingTypeRemove withObject:[BPVCollectionChange removingObjectWithIndex:index]];
    }
}

- (NSUInteger)indexOfModel:(id)model {
    return [self.mutableModels indexOfObject:model];
}

#pragma mark -
#pragma mark Redefinition of parent methods

- (SEL)selectorForState:(NSUInteger)state {
    return @selector(collectionUpdatedWithUserData:);
}

#pragma mark -
#pragma mark Private methods

- (void)setStateWithDataUsingIndex:(NSUInteger)index {
    id data = [BPVUserData userDataWithUserIndex:index];
    [self setState:self.count withObject:data];
}

@end
