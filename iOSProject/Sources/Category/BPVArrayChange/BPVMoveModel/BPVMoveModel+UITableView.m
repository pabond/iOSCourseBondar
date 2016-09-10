//
//  BPVMoveModel+UITableView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIKit/UIKit.h"

#import "BPVMoveModel+UITableView.h"

@implementation BPVMoveModel (UITableView)

- (void)applyToTableView:(UITableView *)tableView {
    [tableView moveRowAtIndexPath:self.fromIndexPath toIndexPath:self.indexPath];
}

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [self applyToTableView:tableView];
}

@end
