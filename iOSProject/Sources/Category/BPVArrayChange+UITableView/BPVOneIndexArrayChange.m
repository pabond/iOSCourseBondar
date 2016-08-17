//
//  BPVOneIndexCollectionChange.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVOneIndexArrayChange.h"

#import "UITableView+BPVExtensions.h"

@implementation BPVOneIndexArrayChange

@dynamic indexPath;

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
    return [UITableView indexPathForRow:self.index];
}

@end
