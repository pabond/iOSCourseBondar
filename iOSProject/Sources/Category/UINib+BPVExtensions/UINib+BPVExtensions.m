//
//  UINib+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UINib+BPVExtensions.h"

@implementation UINib (BPVExtensions)

+ (id)objectUsingNibWithClass:(Class)class {
    UINib *nib = [UINib nibWithClass:class];
    
    return [nib objectWithClass:class];
}

+ (instancetype)nibWithClass:(Class)class {
    return [self nibWithClass:class bundle:nil];
}

+ (instancetype)nibWithClass:(Class)class bundle:(NSBundle *)bundle {
    return [UINib nibWithNibName:NSStringFromClass(class) bundle:bundle];
}

- (id)objectWithClass:(Class)class {
    return [self objectWithClass:(Class)class owner:nil options:nil];
}

- (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options {
    NSArray *objects = [self instantiateWithOwner:owner options:options];
    for (id object in objects) {
        if ([object isMemberOfClass:class]) {
            return object;
        }
    }
    
    return nil;
}

@end
