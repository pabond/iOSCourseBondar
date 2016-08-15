//
//  BPVMovingObject+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVMovingObject.h"

@interface BPVMovingObject (BPVExtensions)

- (void)moveToIndexPath:(NSIndexPath *)toIndexPath
          fromIndexPath:(NSIndexPath *)fromIndexPath
              tableView:(UITableView *)tableView;

@end
