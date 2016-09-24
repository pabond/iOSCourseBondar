//
//  BPVUserViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/20/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVViewController.h"
#import "BPVUser.h"

@interface BPVUserViewController : BPVViewController <BPVModelObserver>
@property (nonatomic, strong) BPVUser *user;

- (IBAction)onFriends:(id)sender;

@end
