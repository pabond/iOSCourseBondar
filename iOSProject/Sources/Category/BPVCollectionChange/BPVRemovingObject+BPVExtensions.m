//
//  BPVRemovingObject+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemovingObject+BPVExtensions.h"

@implementation BPVRemovingObject (BPVExtensions)

- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

@end
