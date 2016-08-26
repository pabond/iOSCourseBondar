//
//  UIViewController+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BPVExtensions)

+ (instancetype)viewController;
+ (instancetype)viewControllerWithNibClass:(Class)cls;
+ (instancetype)viewControllerWithNibClass:(Class)cls bundale:(NSBundle *)nibBundle;

@end
