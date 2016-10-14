//
//  BPVUpdateModel+UITableView.m
//  iOSProject
//
//  Created by Bondar Pavel on 10/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVUpdateModel+UITableView.h"

#import "UITableView+BPVExtensions.h"

@implementation BPVUpdateModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [tableView updateTableViewWithBlock:^{
        [tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
    }];
}

@end
