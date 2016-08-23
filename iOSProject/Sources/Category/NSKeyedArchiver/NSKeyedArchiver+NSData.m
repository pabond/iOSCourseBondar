//
//  NSKeyedArchiver+NSData.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSKeyedArchiver+NSData.h"

@implementation NSKeyedArchiver (NSData)

+ (NSData *)archivateObject:(id)object {
    return [self archivedDataWithRootObject:object];
}

@end
