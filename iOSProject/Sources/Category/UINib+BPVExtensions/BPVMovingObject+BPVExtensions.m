//
//  BPVMovingObject+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVMovingObject+BPVExtensions.h"

@implementation BPVMovingObject (BPVExtensions)

- (void)moveToIndexPath:(NSIndexPath *)toIndexPath
          fromIndexPath:(NSIndexPath *)fromIndexPath
              tableView:(UITableView *)tableView {
    [tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
}

@end
