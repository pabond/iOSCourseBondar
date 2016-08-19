//
//  BPVUsersView.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/4/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPVUsersView : UIView
@property (nonatomic, strong) IBOutlet UITableView  *usersTableView;
@property (nonatomic, strong) IBOutlet UIButton     *doneButton;
@property (nonatomic, strong) IBOutlet UIButton     *addButton;
@property (nonatomic, strong) IBOutlet UIButton     *editButton;

- (void)editingMode;

@end
