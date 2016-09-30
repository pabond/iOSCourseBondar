//
//  NSMutableArray+BPVJSON.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSMutableArray+BPVJSON.h"

#import "NSArray+BPVExtensions.h"

@implementation NSMutableArray (BPVJSON)

- (instancetype)JSONRepresentation {
    return [self JSONRepresentationObjects];
}

@end
