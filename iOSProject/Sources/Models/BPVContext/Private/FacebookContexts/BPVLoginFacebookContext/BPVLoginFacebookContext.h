//
//  BPVLoginFacebookContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFacebookContext.h"
@class BPVUser;
@class BPVLoginViewController;

@interface BPVLoginFacebookContext : BPVFacebookContext
@property (nonatomic, strong) BPVLoginViewController    *controller;
@property (nonatomic, strong) BPVUser                   *user;

@end
