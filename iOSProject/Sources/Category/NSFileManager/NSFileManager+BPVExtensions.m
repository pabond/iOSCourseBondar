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
    static dispatch_once_t onceToken;
    static NSString *dataPath = nil;
    dispatch_once(&onceToken, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        dataPath = [fileManager documentDirectoryPath];
        if (![fileManager fileExistsAtPath:dataPath]) {
            [fileManager createDirectoryWithPath:dataPath];
        }
    });
    
    return dataPath;
}

- (void)createDirectoryWithPath:(NSString *)path {
    NSError *error = nil;
    [self createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
}

- (NSString *)documentDirectoryPath {
    return [self pathWithDirectory:NSDocumentDirectory];
}

- (NSString *)libraryDirectoryPath {
    return [self pathWithDirectory:NSLibraryDirectory];
}

- (NSString *)pathWithDirectory:(NSSearchPathDirectory)directory {
    static dispatch_once_t onceToken;
    static NSString *path = nil;
    dispatch_once(&onceToken, ^{
        path = [[self pathsWithDirectory:directory] firstObject];
    });
    
    return path;
}

- (NSArray *)pathsWithDirectory:(NSSearchPathDirectory)directory {
    static dispatch_once_t onceToken;
    static NSArray *paths = nil;
    dispatch_once(&onceToken, ^{
        paths = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    });
    
    return paths;
}

@end
