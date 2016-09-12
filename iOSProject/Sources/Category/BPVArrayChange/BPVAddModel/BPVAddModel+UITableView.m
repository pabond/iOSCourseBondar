//
//  BPVAddModel+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAddModel+UITableView.h"

#import "UITableView+BPVExtensions.h"

@implementation BPVAddModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [tableView updateTableViewWithBlock:^{
         [tableView insertRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
    }];
}

@end
