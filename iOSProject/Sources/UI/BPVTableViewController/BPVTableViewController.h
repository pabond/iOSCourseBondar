//
//  BPVTableViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/30/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVUsers.h"

@class BPVUser;

@interface BPVTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, BPVCollectionObserver>
@property (nonatomic, strong) BPVUser *user;

@property (nonatomic, strong) IBOutlet UIButton     *editButton;
@property (nonatomic, strong) IBOutlet UIButton     *doneButton;
@property (nonatomic, strong) IBOutlet UIButton     *addButton;

- (IBAction)onEdit:(id)sender;
- (IBAction)onDone:(id)sender;
- (IBAction)onAdd:(id)sender;

@end
