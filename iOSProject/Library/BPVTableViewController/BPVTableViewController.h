//
//  BPVTableViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVArrayModel.h"
@class BPVFilteredModel;

@interface BPVTableViewController : UIViewController    <
    UITableViewDataSource,
    UITableViewDelegate,
    BPVModelObserver,
    BPVArrayModelObserver
>
@property(nonatomic, strong)    BPVArrayModel       *model;
@property (nonatomic, readonly) BPVFilteredModel    *filteredModel;

@end
