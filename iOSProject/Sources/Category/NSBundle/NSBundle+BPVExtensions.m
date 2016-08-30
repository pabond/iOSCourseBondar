//
//  NSBundle+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/25/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSBundle+BPVExtensions.h"

#import "NSArray+BPVExtensions.h"

#import <UIKit/UINibLoading.h>

@implementation NSBundle (BPVExtensions)

+ (id)objectWithClass:(Class)class {
    return [self objectWithClass:class owner:nil];
}

+ (id)objectWithClass:(Class)class owner:(id)owner {
    return [self objectWithClass:class owner:owner options:nil];
}

+ (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options {
    return [[[self mainBundle] loadNibNamed:NSStringFromClass(class) owner:owner options:options] memberOfClass:class];
}

@end
