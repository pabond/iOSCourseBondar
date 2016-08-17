//
//  UITableView+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UITableView+BPVExtensions.h"

#import "UINib+BPVExtensions.h"

@implementation UITableView (BPVExtensions)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)index {
    return [NSIndexPath indexPathForRow:index inSection:0];
}

- (id)cellWithClass:(Class)class {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(class)];
    if (!cell) {
        cell = [UINib objectWithClass:class];
    }
    
    return cell;
}

@end
