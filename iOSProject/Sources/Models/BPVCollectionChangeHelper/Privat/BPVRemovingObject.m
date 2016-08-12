//
//  BPVRemovingObject.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemovingObject.h"

@implementation BPVRemovingObject

- (instancetype)initRemovingObjectWithIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.index = index;
    }
    
    return self;
}

@end
