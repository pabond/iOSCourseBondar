//
//  NSFileManager+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstant(kBPVDefaultApplictionFileName, /data.plist);

@implementation NSFileManager (BPVExtensions)

+ (NSString *)applicationDataPathWithDafaultFileName {
    return [self applicationDataPathWithFileName:kBPVDefaultApplictionFileName];
}

+ (NSString *)applicationDataPathWithFileName:(NSString *)fileName {
    static dispatch_once_t onceToken;
    static NSString *dataPath = nil;
    dispatch_once(&onceToken, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        dataPath = [fileManager documentDirectoryPath];
        if (![fileManager fileExistsAtPath:dataPath]) {
            [fileManager createDirectoryWithPath:dataPath];
        }

    });
    
    dataPath = [dataPath stringByAppendingString:fileName];
    
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
    return [[self pathsWithDirectory:directory] firstObject];
}

- (NSArray *)pathsWithDirectory:(NSSearchPathDirectory)directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
}

@end
