//
//  UITableView+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UITableView+BPVExtensions.h"

#import "UINib+BPVExtensions.h"

#import "BPVMacro.h"

@implementation UITableView (BPVExtensions)

- (id)cellWithClass:(Class)class forRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (id)cellWithClass:(Class)class {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(class)];
    if (!cell) {
        cell = [UINib objectWithClass:class];
    }
    
    return cell;
}

- (void)updateTableViewWithUpdatesBlock:(BPVUpdatesBlock)block {
    [self beginUpdates];
    BPVPerformBlock(block);
    [self endUpdates];
}

@end
