//
//  NSFileManager+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

BPVStringConstant(kBPVDataFolderName, @"DataSaving/");
BPVStringConstant(kBPVDataFileName, @"data.plist");

@implementation NSFileManager (BPVExtensions)

+ (NSString *)dataPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:kBPVDataFolderName];
    NSError *error;
    if (![fileManager fileExistsAtPath:dataPath]) {
        [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    return [dataPath stringByAppendingString:kBPVDataFileName];
}

@end
