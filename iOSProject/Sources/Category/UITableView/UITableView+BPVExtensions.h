//
//  UITableView+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BPVUpdatesBlock)(void);

@interface UITableView (BPVExtensions)

- (id)cellWithClass:(Class)cls forRowAtIndexPath:(NSIndexPath *)indexPath;

- (id)cellWithClass:(Class)cls;

- (void)updateTableViewWithUpdatesBlock:(BPVUpdatesBlock)block;

@end
