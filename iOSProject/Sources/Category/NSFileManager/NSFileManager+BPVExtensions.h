//
//  NSFileManager+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (BPVExtensions)

+ (NSString *)dataPath;
+ (NSString *)dataPathWithFileName:(NSString *)fileName;

- (NSString *)pathInFileManager;

- (NSString *)documentsPath;
- (NSString *)documentsPathWithDomainMask:(NSSearchPathDomainMask)domainMask;

- (NSString *)libraryPath;
- (NSString *)libraryPathWithDomainMask:(NSSearchPathDomainMask)domainMask;

- (NSString *)pathWithDirectory:(NSSearchPathDirectory)directory domainMask:(NSSearchPathDomainMask)domainMask;

- (NSArray *)pathsWithDirectory:(NSSearchPathDirectory)directory domainMask:(NSSearchPathDomainMask)domainMask;

@end
