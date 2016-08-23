//
//  NSTimer+BPVExtensions.m
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 7/19/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSTimer+BPVExtensions.h"

#import "BPVSupportEntity.h"

#import "NSString+BPVExtensions.h"

@implementation NSTimer (BPVExtensions)

#pragma mark -
#pragma mark Public implementations

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(BPVBlock)block {
    if (!block) {
        return nil;
    }
    
    id object = [BPVSupportEntity objectWithBlock:block];

    
    NSTimer *timer =[self scheduledTimerWithTimeInterval:interval
                                                  target:object
                                                selector:@selector(onTimer:)
                                                userInfo:nil
                                                 repeats:repeats];
    return timer;
}

#pragma mark -
#pragma mark Private implementations

@end
