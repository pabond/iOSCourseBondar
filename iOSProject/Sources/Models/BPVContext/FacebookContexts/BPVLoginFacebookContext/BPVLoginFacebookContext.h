//
//  BPVLoginFacebookContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFriendsListContext.h"

@class BPVLoginViewController;

@interface BPVLoginFacebookContext : BPVFriendsListContext
@property (nonatomic, strong) BPVLoginViewController    *controller;

@end
