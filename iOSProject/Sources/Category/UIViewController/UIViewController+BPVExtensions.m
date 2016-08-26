//
//  UIViewController+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIViewController+BPVExtensions.h"

@implementation UIViewController (BPVExtensions)

+ (instancetype)viewController {
    return [self viewControllerWithNibClass:[self class]];
}

+ (instancetype)viewControllerWithNibClass:(Class)class {
    return [self viewControllerWithNibClass:class bundale:nil];
}

+ (instancetype)viewControllerWithNibClass:(Class)class bundale:(NSBundle *)nibBundle {
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nibBundle];
}

@end
