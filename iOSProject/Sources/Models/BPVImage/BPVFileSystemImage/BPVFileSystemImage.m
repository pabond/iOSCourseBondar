//
//  BPVFileSystemImage.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFileSystemImage.h"

@implementation BPVFileSystemImage

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    self.url = url;
    
    return self;
}

- (UIImage *)specificLoadingOperation {
    UIImage *image = [UIImage imageWithContentsOfFile:self.path];
    if (!image) {
        [self removeImageWithProblem];
        [self performLoading];
    } else {
        NSLog(@"image loaded from file system");
    }
    
    return image;
}

@end
