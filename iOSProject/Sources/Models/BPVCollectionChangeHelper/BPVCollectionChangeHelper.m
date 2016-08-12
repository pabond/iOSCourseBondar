//
//  BPVCollectionChangeHelper.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCollectionChangeHelper.h"

#import "BPVRemovingObject.h"
#import "BPVAddingObject.h"

@interface BPVCollectionChangeHelper ()

- (instancetype)initRemovingObjectWithIndex:(NSUInteger)index;
- (instancetype)initAddingObjectWithIndex:(NSUInteger)index;

@end

@implementation BPVCollectionChangeHelper

#pragma mark -
#pragma mark Class methods

+ (instancetype)removingObjectWithIndex:(NSUInteger)index {
    return [[self alloc] initRemovingObjectWithIndex:index];
}

+ (instancetype)addingObjectWithIndex:(NSUInteger)index{
    return [[self alloc] initAddingObjectWithIndex:index];
}

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initRemovingObjectWithIndex:(NSUInteger)index {
    return [[BPVRemovingObject alloc] initRemovingObjectWithIndex:index];
}

- (instancetype)initAddingObjectWithIndex:(NSUInteger)index {
    return [[BPVAddingObject alloc] initAddingObjectWithIndex:index];
}

#pragma mark -
#pragma mark Public implementations

- (id)objectWithChangingType:(BPVChangingType)type index:(NSUInteger)index {
    if (type == BPVChangingTypeAdd) {
        return [self initAddingObjectWithIndex:index];
    } else if (type == BPVChangingTypeRemove) {
        return [self initRemovingObjectWithIndex:index];
    }
    
    return nil;
}

@end
