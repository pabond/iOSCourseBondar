//
//  BPVMovingObject+UITableView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIKit/UIKit.h"

#import "BPVMovingObject+UITableView.h"

@implementation BPVMovingObject (UITableView)

- (void)applyToTableView:(UITableView *)tableView {
    [tableView moveRowAtIndexPath:self.fromIndexPath toIndexPath:self.indexPath];
}

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [self applyToTableView:tableView];
}

@end
