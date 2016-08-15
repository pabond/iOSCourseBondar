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

@dynamic indexPath;

#pragma mark -
#pragma mark Class methods

+ (instancetype)removingObjectWithIndex:(NSUInteger)index {
    return [[BPVRemovingObject alloc] initWithIndex:index];
}

+ (instancetype)addingObjectWithIndex:(NSUInteger)index{
    return [[BPVAddingObject alloc] initWithIndex:index];
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

#pragma mark -
#pragma mark Accessors

- (NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:self.index inSection:0];
}

#pragma mark -
#pragma mark Public implementations

- (void)performChangesToTableView:(UITableView *)tableView {
//sould be rewritten in child classes
}

@end
