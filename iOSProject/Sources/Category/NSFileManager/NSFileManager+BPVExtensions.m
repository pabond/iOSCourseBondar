//
//  NSFileManager+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

@implementation NSFileManager (BPVExtensions)

+ (NSString *)applicationDataPathWithFileName:(NSString *)fileName {
    NSString *dataPath = [[self applicationDataPath] stringByAppendingString:fileName];
    
    return dataPath;
}

+ (NSString *)applicationDataPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataPath = [fileManager documentDirectoryPath];
    if (![fileManager fileExistsAtPath:dataPath]) {
        [fileManager createDirectoryWithPath:dataPath];
    }

    return dataPath;
}

- (void)createDirectoryWithPath:(NSString *)path {
    NSError *error = nil;
    [self createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
}

- (NSString *)documentDirectoryPath {
    BPVReturnOnce(NSString, documentDirectory, ^{ return [self pathWithDirectory:NSDocumentDirectory]; });
}

- (NSString *)libraryDirectoryPath {
    BPVReturnOnce(NSString, libraryDirectory, ^{ return [self pathWithDirectory:NSLibraryDirectory]; });
}

- (NSString *)pathWithDirectory:(NSSearchPathDirectory)directory {
    return [[self pathsWithDirectory:directory] firstObject];
}

- (NSArray *)pathsWithDirectory:(NSSearchPathDirectory)directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
}

@end
