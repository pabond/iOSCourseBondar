//
//  BPVArrayChange+UITableView.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayChange+UITableView.h"

@implementation BPVArrayChange (UITableView)

- (void)applyToTableView:(UITableView *)tableView {
    [self applyToTableView:tableView withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    
}

@end
