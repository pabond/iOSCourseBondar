//
//  NSIndexPath+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSIndexPath+BPVExtensions.h"

#import "UITableView+BPVExtensions.h"

@implementation NSIndexPath (BPVExtensions)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)index {
    return [self indexPathForRow:index inSection:0];
}

@end
