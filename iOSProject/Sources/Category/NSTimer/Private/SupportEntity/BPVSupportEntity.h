//
//  BPVSupportEntity.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BPVSupportingBlock)(void);

@interface BPVSupportEntity : NSObject
@property (nonatomic, copy)     BPVSupportingBlock      block;

+ (instancetype)objectWithBlock:(BPVSupportingBlock)block;

- (void)onTimer:(NSTimer *)timer;

@end
