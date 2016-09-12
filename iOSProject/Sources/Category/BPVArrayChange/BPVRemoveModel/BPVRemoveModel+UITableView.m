//
//  BPVRemoveModel+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemoveModel+UITableView.h"
#import "UITableView+BPVExtensions.h"
#import "BPVMacro.h"

@implementation BPVRemoveModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [tableView updateTableViewWithBlock:^{
        [tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
    }];
}

@end
