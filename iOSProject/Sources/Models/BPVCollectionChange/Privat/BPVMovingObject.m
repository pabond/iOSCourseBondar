//
//  BPVMovingObject.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/14/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVMovingObject.h"

#import "BPVMovingObject+BPVExtensions.h"

@implementation BPVMovingObject

- (void)performChangesToTableView:(UITableView *)tableView {
    [self moveToIndexPath:self.indexPath fromIndexPath:self.fromIndexPath tableView:tableView];
}

@end
