//
//  UIViewController+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIViewController+BPVExtensions.h"

@implementation UIViewController (BPVExtensions)

+ (instancetype)viewControllerWithNibName:(NSString *)name {
    return [[self alloc] initWithNibName:name bundle:nil];
}

+ (instancetype)viewControllerWithNibClass:(Class)class {
    return [self viewControllerWithNibName:NSStringFromClass(class)];
}

+ (instancetype)viewController {
    return [self viewControllerWithNibClass:[self class]];
}

@end
