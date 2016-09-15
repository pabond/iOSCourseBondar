//
//  NSKeyedUnarchiver+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/2/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedUnarchiver (BPVExtensions)

+ (id)objectFromFileWithPath:(NSString *)filePath;

@end
