//
//  UIViewController+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BPVExtensions)

+ (instancetype)viewControllerWithNibName:(NSString *)name;
+ (instancetype)viewControllerWithNibClass:(Class)cls;
+ (instancetype)viewController;

@end
