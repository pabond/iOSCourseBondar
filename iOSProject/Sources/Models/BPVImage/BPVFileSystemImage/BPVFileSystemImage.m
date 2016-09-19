//
//  BPVFileSystemImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFileSystemImage.h"
#import "BPVImagesCache.h"

@implementation BPVFileSystemImage

#pragma mark -
#pragma mark Public implementations

- (BOOL)imageLoaded {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.path];
}

- (UIImage *)imageFromFileSystem {
    return [UIImage imageWithContentsOfFile:self.path];
}

@end
