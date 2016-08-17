//
//  UITableView+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BPVExtensions)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)index;

- (id)cellWithClass:(Class)cls;

@end
