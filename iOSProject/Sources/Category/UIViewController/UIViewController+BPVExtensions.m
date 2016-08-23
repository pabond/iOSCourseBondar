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
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
