//
//  NSMutableArray+BPVJSONReoresentation.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSMutableArray+BPVJSONReoresentation.h"

#import "NSArray+BPVJSONRepresentation.h"

@implementation NSMutableArray (BPVJSONReoresentation)

- (instancetype)JSONRepresentation {
    return [NSMutableArray arrayWithArray:[self JSONRepresentationObjects]];
}

@end
