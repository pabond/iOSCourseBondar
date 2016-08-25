//
//  NSFileManager+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstant(kBPVDataFileName, @"/data.plist");

@implementation NSFileManager (BPVExtensions)

+ (NSString *)dataPath {
    return [self dataPathWithFileName:kBPVDataFileName];
}

+ (NSString *)dataPathWithFileName:(NSString *)fileName {
    static dispatch_once_t onceToken;
    static NSString *dataPath;
    dispatch_once(&onceToken, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        dataPath = [fileManager pathInFileManager];
        dataPath = [dataPath stringByAppendingString:fileName];
    });
    
    return dataPath;
}

- (NSString *)pathInFileManager {
    NSString *dataPath = [self documentsPath];
    
    NSError *error = nil;
    if (![self fileExistsAtPath:dataPath]) {
        [self createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    return dataPath;
}

- (NSString *)documentsPath {
    return [self documentsPathWithDomainMask:NSUserDomainMask];
}

- (NSString *)documentsPathWithDomainMask:(NSSearchPathDomainMask)domainMask {
    return [self pathWithDirectory:NSDocumentDirectory domainMask:domainMask];
}

- (NSString *)libraryPath {
    return [self libraryPathWithDomainMask:NSUserDomainMask];
}

- (NSString *)libraryPathWithDomainMask:(NSSearchPathDomainMask)domainMask {
    return [self pathWithDirectory:NSLibraryDirectory domainMask:domainMask];
}

- (NSString *)pathWithDirectory:(NSSearchPathDirectory)directory domainMask:(NSSearchPathDomainMask)domainMask {
    return [[self pathsWithDirectory:directory domainMask:domainMask] firstObject];
}

- (NSArray *)pathsWithDirectory:(NSSearchPathDirectory)directory domainMask:(NSSearchPathDomainMask)domainMask {
    return NSSearchPathForDirectoriesInDomains(directory, domainMask, YES);
}

@end
