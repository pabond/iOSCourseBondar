//
//  UIViewController+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIViewController+BPVExtensions.h"

@interface UIViewController ()

- (instancetype)initWithNibNameFromClass:(Class)class;

@end

@implementation UIViewController (BPVExtensions)

+ (instancetype)selfClassController {
    return [[self alloc] initWithNibNameFromClass:[self class]];
}

- (instancetype)initWithNibNameFromClass:(Class)class {
    return [self initWithNibName:NSStringFromClass(class) bundle:nil];
}

@end
