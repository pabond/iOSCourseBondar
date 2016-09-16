//
//  BPVFileSystemImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFileSystemImage.h"
#import "BPVImagesCache.h"

@interface BPVFileSystemImage ()

- (BOOL)removeImageWithProblem;
- (void)reloadImage;

@end

@implementation BPVFileSystemImage

#pragma mark -
#pragma mark Public implementations

- (void)performLoading {
    UIImage *image = [UIImage imageWithContentsOfFile:self.path];
    if (!image) {
        [self reloadImage];
        return;
    } else {
        NSLog(@"image loaded from file system");
    }
    
    self.image = image;
    self.state = image ? BPVModelDidLoad : BPVModelFailLoading;
}

- (BOOL)imageExistInFileSystem {
    return [[NSFileManager defaultManager] fileExistsAtPath:self.path];
}

#pragma mark -
#pragma mark Private implementations

- (void)reloadImage {
    [self removeImageWithProblem];
    [self performLoading];
}

- (BOOL)removeImageWithProblem {
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:self.path error:&error];
    
    NSLog(@"%@", error);
    
    return result;
}

@end
