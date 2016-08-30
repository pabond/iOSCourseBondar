//
//  BPVUsersView.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/4/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVView.h"

@class BPVUsersLoadingView;

@interface BPVUsersView : BPVView
@property (nonatomic, strong) IBOutlet UITableView  *usersTableView;

@property (nonatomic, strong) IBOutlet UIButton     *addButton;
@property (nonatomic, strong) IBOutlet UIButton     *editingButton;

@property (nonatomic, assign) BOOL  loading;
@property (nonatomic, assign) BOOL  editing;

@property (nonatomic, strong) BPVUsersLoadingView   *loadingView;


@end
