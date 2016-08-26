//
//  BPVArrayCollectionChange.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayChange.h"

#import "BPVRemoveModel.h"
#import "BPVAddModel.h"
#import "BPVMoveModel.h"

@implementation BPVArrayChange

#pragma mark -
#pragma mark Class methods

+ (instancetype)removeModelWithIndex:(NSUInteger)index {
    return [[BPVRemoveModel alloc] initWithIndex:index];
}

+ (instancetype)addModelWithIndex:(NSUInteger)index{
    return [[BPVAddModel alloc] initWithIndex:index];
}

+ (instancetype)moveModelWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    return [[BPVMoveModel alloc] initWithIndex:index fromIndex:fromIndex];
}

@end
