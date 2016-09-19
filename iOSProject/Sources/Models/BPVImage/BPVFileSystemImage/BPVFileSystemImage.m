//
//  BPVFileSystemImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFileSystemImage.h"
#import "BPVImagesCache.h"

@interface  BPVFileSystemImage ()

- (BOOL)removeImageWithProblem;

@end

@implementation BPVFileSystemImage

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    NSUInteger state = BPVModelDidLoad;
    UIImage *image = [self imageFromFileSystem];
    
    if (image) {
        self.image = image;
    } else {
        [self removeImageWithProblem];
        state = BPVModelFailLoading;
    }
    
    self.state = state;
}

- (BOOL)imageLoaded {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.path];
}

- (UIImage *)imageFromFileSystem {
    return [UIImage imageWithContentsOfFile:self.path];
}

#pragma mark -
#pragma mark Private implementations

- (BOOL)removeImageWithProblem {
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:self.path error:&error];
    
    NSLog(@"%@", error);
    
    return result;
}


@end
