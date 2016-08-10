//
//  BPVSupportEntity.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVSupportEntity.h"

@interface BPVSupportEntity ()

- (instancetype)initWithBlock:(BPVSupportingBlock)block;

@end

@implementation BPVSupportEntity

#pragma mark -
#pragma mark Class methods

+ (instancetype)objectWithBlock:(BPVSupportingBlock)block {
    return [[self alloc] initWithBlock:block];
}

#pragma mark -
#pragma mark Initializations / Deallocations

- (instancetype)initWithBlock:(BPVSupportingBlock)block {
    self = [super init];
    self.block = block;
    
    return self;
}


#pragma mark -
#pragma mark Public implementations

- (void)onTimer:(NSTimer *)timer {
    BPVSupportingBlock block = self.block;
    
    block();
}

@end
