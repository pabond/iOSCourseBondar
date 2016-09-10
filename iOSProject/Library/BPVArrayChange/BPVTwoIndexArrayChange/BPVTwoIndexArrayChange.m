//
//  BPVTwoIndexCollectionChange.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVTwoIndexArrayChange.h"

#import "NSIndexPath+BPVExtensions.h"

@implementation BPVTwoIndexArrayChange

@dynamic fromIndexPath;

#pragma mark -
#pragma mark Initializations and deallocations


- (instancetype)initWithIndex:(NSUInteger)index fromIndex:(NSUInteger)fromIndex object:(id)object {
    self = [super initWithIndex:index object:object];
    if (self) {
        self.fromIndex = fromIndex;
        self.object = object;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSIndexPath *)fromIndexPath {
    return [NSIndexPath indexPathForRow:self.fromIndex];
}

@end
