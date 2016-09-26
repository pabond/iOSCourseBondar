//
//  BPVUsers.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/3/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayModel.h"

@class BPVUser;

@interface BPVUsers : BPVArrayModel
@property (nonatomic, strong) BPVUser *user;

- (NSArray *)cachedArray;

@end
