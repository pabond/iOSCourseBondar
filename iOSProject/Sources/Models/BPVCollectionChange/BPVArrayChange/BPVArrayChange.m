//
//  BPVArrayCollectionChange.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayChange.h"

#import "BPVRemovingChangeModel.h"
#import "BPVAddingChangeModel.h"
#import "BPVMovingChangeModel.h"

@implementation BPVArrayChange

#pragma mark -
#pragma mark Class methods

+ (instancetype)removingChangeModelWithIndex:(NSUInteger)index {
    return [[BPVRemovingChangeModel alloc] initWithIndex:index];
}

+ (instancetype)addingChangeModelWithIndex:(NSUInteger)index{
    return [[BPVAddingChangeModel alloc] initWithIndex:index];
}

+ (instancetype)movingChangeModelWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    return [[BPVMovingChangeModel alloc] initWithIndex:index fromIndex:fromIndex];
}

@end
