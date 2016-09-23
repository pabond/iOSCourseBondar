//
//  BPVContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"
#import "BPVViewController.h"

@interface BPVContext : BPVObservableObject
@property (nonatomic, strong) BPVViewController *controller;

- (void)execute;
- (void)cancel;

@end
