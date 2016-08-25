//
//  NSBundle+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/25/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSBundle+BPVExtensions.h"

#import <UIKit/UINibLoading.h>

@implementation NSBundle (BPVExtensions)

+ (id)objectWithClass:(Class)class {
    for (id object in [self loadNibWithClass:class]) {
        if ([object isMemberOfClass:class]) {
            return object;
        }
    }
    
    return nil;
}

+ (NSArray *)loadNibWithClass:(Class)class {
    return [self loadNibWithClass:class owner:nil];
}

+ (NSArray *)loadNibWithClass:(Class)class owner:(id)owner {
    return [self loadNibWithClass:class owner:owner options:nil];
}

+ (NSArray *)loadNibWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options {
    return [[self mainBundle] loadNibNamed:NSStringFromClass(class) owner:owner options:options];
}

@end
