//
//  BPVTableViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVViewController.h"
#import "BPVArrayModel.h"

@class BPVFilteredModel;
@class BPVUser;

@interface BPVTableViewController : BPVViewController    <
    UITableViewDataSource,
    UITableViewDelegate,
    BPVModelObserver,
    BPVArrayModelObserver
>
@property (nonatomic, strong) BPVFilteredModel  *filteredModel;
@property (nonatomic, strong) BPVArrayModel     *model;

@end
