//
//  BPVUserData.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/8/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPVUser;

@interface BPVUserData : NSObject
@property (nonatomic, assign)   NSUInteger  userIdex;
@property (nonatomic, strong)   BPVUser     *user;

- (instancetype)initWithUser:(BPVUser *)user
                       index:(NSUInteger)index;

@end
