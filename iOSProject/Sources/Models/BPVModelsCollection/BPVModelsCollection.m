//
//  BPVModelsCollection.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVModelsCollection.h"

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
        [self setStateWithDataUsingIndex:[self indexOfUser:model]];
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

- (void)moveModelFromSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex {
    id model = [self modelAtIndex:sourceIndex];
    BOOL notify = NO;
    [self removeModelAtIndex:sourceIndex notify:notify];
    [self insertModel:model atIndex:destinationIndex notify:notify];
}

- (void)insertModel:(id)user atIndex:(NSUInteger)index notify:(BOOL)notify {
    if (user) {
        [self.mutableModels insertObject:user atIndex:index];
        if (notify) {
            [self setStateWithDataUsingIndex:index];
        }
    }
}

- (void)removeModelAtIndex:(NSUInteger)index notify:(BOOL)notify {
    [self.mutableModels removeObjectAtIndex:index];
    if (notify) {
        [self setStateWithDataUsingIndex:index];
    }
}

- (NSUInteger)indexOfUser:(id)user {
    return [self.mutableModels indexOfObject:user];
}

#pragma mark -
#pragma mark Redefinition of parent methods

- (SEL)selectorForState:(NSUInteger)state {
    return @selector(collection:didUpdateWithUserData:);
}

#pragma mark -
#pragma mark Private methods

- (void)setStateWithDataUsingIndex:(NSUInteger)index {
    id data = [BPVUserData userDataWithUserIndex:index];
    [self setState:self.count withObject:data];
}

@end
