//
//  BPVTableViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVUsers.h"

@interface BPVTableViewController : UIViewController    <UITableViewDataSource,
                                                        UITableViewDelegate,
                                                        BPVCollectionObserver,
                                                        BPVCollectionLoading>

- (IBAction)onDone:(id)sender;
- (IBAction)onEdit:(id)sender;
- (IBAction)onAdd:(id)sender;

- (void)addModel:(id)model;

@end
