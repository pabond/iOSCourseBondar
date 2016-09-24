//
//  BPVLoginFacebookContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVContext.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>

@class BPVLoginViewController;

@interface BPVLoginFacebookContext : BPVContext
@property (nonatomic, strong) BPVLoginViewController        *controller;
@property (nonatomic, strong) FBSDKLoginManagerLoginResult  *result;

@end
