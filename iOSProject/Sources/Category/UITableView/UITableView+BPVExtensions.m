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

- (id)cellWithClass:(Class)class withNibClass:(Class)nibClass {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(class)];
    if (!cell) {
        cell = [UINib objectWithClass:nibClass];
    }
    
    return cell;
}

- (void)updateTableViewWithBlock:(BPVUpdatesBlock)block {
    if (!block) {
        return;
    }
    
    [self beginUpdates];
    block();
    [self endUpdates];
}

@end
