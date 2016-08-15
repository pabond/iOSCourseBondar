//
//  BPVRemovingObject+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVRemovingObject.h"

@interface BPVRemovingObject (BPVExtensions)

- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@end
