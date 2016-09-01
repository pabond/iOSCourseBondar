//
//  NSFileManager+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (BPVExtensions)

+ (NSString *)applicationDataPathWithFileName:(NSString *)fileName;
+ (NSString *)applicationDataPath;

+ (NSString *)documentDirectoryPath;
+ (NSString *)libraryDirectoryPath;

+ (NSString *)pathWithDirectory:(NSSearchPathDirectory)directory;
+ (NSArray *)pathsWithDirectory:(NSSearchPathDirectory)directory;

@end
