//
//  BPVUsersView.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/4/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVView.h"

@interface BPVUsersView : BPVView
@property (nonatomic, strong) IBOutlet UITableView  *usersTableView;
@property (nonatomic, assign) BOOL                  editing;


@end
