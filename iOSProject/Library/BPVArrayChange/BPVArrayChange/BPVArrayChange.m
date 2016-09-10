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

+ (instancetype)removeModelWithIndex:(NSUInteger)index object:(id)object {
    return [[BPVRemoveModel alloc] initWithIndex:index object:(id)object];
}

+ (instancetype)addModelWithIndex:(NSUInteger)index object:(id)object {
    return [[BPVAddModel alloc] initWithIndex:index object:(id)object];
}

+ (instancetype)moveModelWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex object:(id)object {
    return [[BPVMoveModel alloc] initWithIndex:index fromIndex:fromIndex object:(id)object];
}

- (void)applyToModel:(id)model withObject:(id)object {
    
}

@end
