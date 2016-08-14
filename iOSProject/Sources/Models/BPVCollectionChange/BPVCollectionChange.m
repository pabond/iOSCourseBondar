//
//  BPVCollectionChangeHelper.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCollectionChange.h"

#import "BPVRemovingObject.h"
#import "BPVAddingObject.h"

@implementation BPVCollectionChange

#pragma mark -
#pragma mark Class methods

+ (instancetype)removingObjectWithIndex:(NSUInteger)index {
    return [[BPVAddingObject alloc] initWithIndex:index];
}

+ (instancetype)addingObjectWithIndex:(NSUInteger)index{
    return [[BPVRemovingObject alloc] initWithIndex:index];
}

#pragma mark -
#pragma mark Initializations and deallocations

- (instancetype)initWithIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.index = index;
    }
    
    return self;
}

@end
