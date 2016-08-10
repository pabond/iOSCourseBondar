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
@property (nonatomic, assign)   NSUInteger  userIndex;
@property (nonatomic, strong)   BPVUser     *user;

+ (instancetype)userDataWithUser:(BPVUser *)user index:(NSUInteger)index;

@end
