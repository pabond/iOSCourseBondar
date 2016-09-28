//
//  BPVLoginViewController.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BPVViewController.h"
#import "BPVUser.h"

@interface BPVLoginViewController : BPVViewController <BPVUserObserver>

- (IBAction)onLogin:(id)sender;

@end
