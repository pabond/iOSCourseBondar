//
//  NSKeyedUnarchiver+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSKeyedUnarchiver+BPVExtensions.h"

@implementation NSKeyedUnarchiver (BPVExtensions)

+ (NSArray *)objectFromFileWithPath:(NSString *)filePath {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:filePath]];
}

@end
