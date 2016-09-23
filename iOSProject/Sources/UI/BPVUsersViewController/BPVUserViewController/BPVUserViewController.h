//
//  BPVUserViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVViewController.h"

@class BPVUser;

@interface BPVUserViewController : BPVViewController
@property (nonatomic, strong) BPVUser *user;

- (IBAction)onFriends:(id)sender;

@end
