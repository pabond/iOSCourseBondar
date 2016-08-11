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

- (id)cellWithClass:(Class)class {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(class)];
    if (!cell) {
        cell = [UINib objectUsingNibWithClass:class];
    }
    
    return cell;
}

@end
