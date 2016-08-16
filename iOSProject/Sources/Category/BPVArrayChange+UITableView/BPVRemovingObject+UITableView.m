//
//  BPVRemovingObject+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemovingObject+UITableView.h"

@implementation BPVRemovingObject (UITableView)

- (void)applyToTableView:(UITableView *)tableView {
    [tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

@end
