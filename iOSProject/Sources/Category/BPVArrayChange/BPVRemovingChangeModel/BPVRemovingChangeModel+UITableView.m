//
//  BPVRemovingChangeModel+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemovingChangeModel+UITableView.h"

@implementation BPVRemovingChangeModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
}

@end
