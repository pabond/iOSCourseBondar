//
//  BPVUserInfoContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVContext.h"

@class BPVUser;
@class BPVUserViewController;

@interface BPVUserInfoContext : BPVContext
@property (nonatomic, strong)   BPVUser     *user;

@end
