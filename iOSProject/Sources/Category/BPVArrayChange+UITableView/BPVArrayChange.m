//
//  BPVArrayCollectionChange.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayChange.h"

#import "BPVRemovingObject.h"
#import "BPVAddingObject.h"
#import "BPVMovingObject.h"

@implementation BPVArrayChange

#pragma mark -
#pragma mark Class methods

+ (instancetype)removingObjectWithIndex:(NSUInteger)index {
    return [[BPVRemovingObject alloc] initWithIndex:index];
}

+ (instancetype)addingObjectWithIndex:(NSUInteger)index{
    return [[BPVAddingObject alloc] initWithIndex:index];
}

+ (instancetype)movingObjectwithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    return [[BPVMovingObject alloc] initWithIndex:index fromIndex:fromIndex];
}

@end
