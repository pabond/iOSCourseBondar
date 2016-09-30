//
//  NSDictionary+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/28/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSDictionary+BPVExtensions.h"

@implementation NSDictionary (BPVExtensions)

- (instancetype)JSONRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *keys = [self allKeys];
    
    for (id key in keys) {
        id object = [self[key] JSONRepresentation];
        if (object) {
            [dictionary setObject:object forKey:key];
        }
    }
    
    return [[self class] dictionaryWithDictionary:dictionary];
}

@end
