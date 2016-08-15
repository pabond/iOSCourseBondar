//
//  BPVCollectionChangeFromIndex.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVCollectionChangeFromIndex.h"

#import "BPVMovingObject.h"

@interface BPVCollectionChangeFromIndex ()

- (instancetype)initWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex;

@end

@implementation BPVCollectionChangeFromIndex

@dynamic fromIndexPath;

#pragma mark -
#pragma mark Class methods

+ (instancetype)movingObjectwithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    return [[BPVMovingObject alloc] initWithIndex:index fromIndex:fromIndex];
}

#pragma mark -
#pragma mark Initializations and deallocations


- (instancetype)initWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex {
    self = [super initWithIndex:index];
    if (self) {
        self.fromIndex = fromIndex;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSIndexPath *)fromIndexPath {
    return [NSIndexPath indexPathForRow:self.fromIndex inSection:0];
}

@end
