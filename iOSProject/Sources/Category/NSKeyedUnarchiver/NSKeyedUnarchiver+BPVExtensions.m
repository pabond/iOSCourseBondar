//
//  NSKeyedUnarchiver+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSKeyedUnarchiver+BPVExtensions.h"

#import "NSFileManager+BPVExtensions.h"

@implementation NSKeyedUnarchiver (BPVExtensions)

+ (id)unarchiveObject {
    NSData *data = [NSData dataWithContentsOfFile:[NSFileManager dataPath]];
    NSArray *array = [self unarchiveObjectWithData:data];
    if (array.count) {
        NSLog(@"[LOADING] Array loaded from file");
    }
    
    return array;
}

@end
