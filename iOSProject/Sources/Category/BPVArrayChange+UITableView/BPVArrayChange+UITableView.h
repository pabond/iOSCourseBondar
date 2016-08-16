//
//  BPVArrayChange+UITableView.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "UIKit/UIKit.h"

#import "BPVArrayChange.h"

@interface BPVArrayChange (UITableView)

//sholuld be launched from child classes
- (void)applyToTableView:(UITableView *)tableView;

@end
