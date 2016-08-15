//
//  BPVAddingObject+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAddingObject+BPVExtensions.h"

@implementation BPVAddingObject (BPVExtensions)

- (void)insertRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

@end
