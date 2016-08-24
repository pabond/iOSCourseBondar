//
//  NSKeyedArchiver+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSKeyedArchiver+BPVExtensions.h"

#import "NSFileManager+BPVExtensions.h"

@implementation NSKeyedArchiver (BPVExtensions)

+ (void)archiveObject:(id)object {
    if ([NSKeyedArchiver archiveRootObject:object toFile:[NSFileManager dataPath]]) {
        NSLog(@"Saving operation succeeds");
    } else {
        NSLog(@"Data not saved");
    }
}

@end
