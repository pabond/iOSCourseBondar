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

- (NSString *)documentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)path {
    NSString *dataPath = [self documentsPath];
    
    NSError *error;
    if (![self fileExistsAtPath:dataPath]) {
        [self createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    return dataPath;
}

+ (NSString *)dataPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataPath = [fileManager path];
    dataPath = [dataPath stringByAppendingString:kBPVDataFileName];
    
    return dataPath;
}

@end
