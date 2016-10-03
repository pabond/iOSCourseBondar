//
//  NSArray+BPVJSONRepresentation.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSArray+BPVJSONRepresentation.h"

@implementation NSArray (BPVJSONRepresentation)

- (instancetype)JSONRepresentationObjects {
    NSMutableArray *array = [NSMutableArray array];
    for (id object in self) {
        if (object) {
            [array addObject:[object JSONRepresentation]];
        }
    }
    
    return array;
}

- (instancetype)JSONRepresentation {
    return [[self class] arrayWithArray:[self JSONRepresentationObjects]];
}


@end
