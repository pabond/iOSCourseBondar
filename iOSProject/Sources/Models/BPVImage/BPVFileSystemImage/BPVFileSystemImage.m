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
    [self load];
    
    return self;
}

- (UIImage *)specificLoadingOperation {
    NSString *filePath = self.path;
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    if (!image) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        [self performLoading];
    } else {
        NSLog(@"image loaded from file system");
    }
    
    return image;
}

@end
