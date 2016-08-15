//
//  BPVAddingObject.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVAddingObject.h"

#import "BPVAddingObject+BPVExtensions.h"

@implementation BPVAddingObject

- (void)performChangesToTableView:(UITableView *)tableView {
    [self insertRowAtIndexPath:self.indexPath tableView:tableView];
}

@end
