//
//  BPVBigChangeObject+UITableView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVBigChangeObject+UITableView.h"

@implementation BPVBigChangeObject (UITableView)

- (void)applyToTableView:(UITableView *)tableView {
    [tableView reloadData];
}

@end
