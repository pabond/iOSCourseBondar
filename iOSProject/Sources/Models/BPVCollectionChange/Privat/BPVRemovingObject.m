//
//  BPVRemovingObject.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemovingObject.h"

#import "BPVRemovingObject+BPVExtensions.h"

@implementation BPVRemovingObject

- (void)performChangesToTableView:(UITableView *)tableView {
    [self removeRowAtIndexPath:self.indexPath tableView:tableView];
}

@end
